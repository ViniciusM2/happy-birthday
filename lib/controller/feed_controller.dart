import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redeinfo/data/model/feed_model.dart';
import 'package:redeinfo/data/model/post_model.dart';
import 'package:redeinfo/data/repository/feed_repository.dart';
import 'package:redeinfo/ui/feed/widgets/post_dialog.dart';

class FeedController extends GetxController {
  final FeedRepository repository;
  final ImagePicker _picker = ImagePicker();

  TextEditingController textController =
      TextEditingController(text: 'Parabéns!');

  final imageBytes = Uint8List.fromList([]).obs;
  PickedFile _pickedFile = PickedFile('');

  final _loading = false.obs;
  get loading => this._loading.value;
  set loading(value) => this._loading.value = value;

  FeedController({required this.repository});
  @override
  void onInit() async {
    feedModel.value = await getFeed();
    super.onInit();
  }

  Future<FeedModel> getFeed() async {
    return await repository.getFeed();
  }

  final listOfPosts = [].obs;
  var feedModel = FeedModel.empty().obs;

  handleNewPostFirstAct() {
    Get.dialog(
      Dialog(
        child: Obx(
          () => PostForm(
            messageController: textController,
            onSend: handleNewPostSecondAct,
            onPickImage: pickImage,
            imageBytes: imageBytes.value,
          ),
        ),
      ),
    );
  }

  handleNewPostSecondAct() async {
    loading = true;
    Get.back();
    if (_pickedFile.path != '') {
      var task = await FirebaseStorage.instance
          .ref('uploads/${_pickedFile.path.split('/').last}')
          .putData(imageBytes.value);

      var post = PostModel(
        title: textController.text,
        dateTime: DateTime.now(),
        authorName: 'Autor Anônimo',
        numberOfLikes: 0,
        numberOfComments: 0,
        imageUrl: await task.ref.getDownloadURL(),
      );

      await repository.addPostToFeed(post);
      feedModel.value = await getFeed();
    }
    loading = false;
    Get.snackbar(
      textController.text,
      textController.text + ' Feliz aniversário!',
    );
    textController.text = "Parabéns";
  }

  pickImage() async {
    final PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      print(pickedFile);
      try {
        imageBytes.value = await pickedFile.readAsBytes();
        _pickedFile = pickedFile;
      } on FirebaseException catch (e) {
        print(e);
        // e.g, e.code == 'canceled'
      }
    }
  }
}
