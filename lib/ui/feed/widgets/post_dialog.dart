import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostForm extends StatelessWidget {
  final TextEditingController? messageController;
  final TextEditingController? nameController;
  final VoidCallback onSend;
  final VoidCallback onPickImage;
  final Uint8List imageBytes;
  PostForm({
    required this.messageController,
    required this.nameController,
    required this.onSend,
    required this.onPickImage,
    required this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Digite a sua frase de feliz aniversário!',
              style: Get.theme.textTheme.bodyText1,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome da Pessoa'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: messageController,
              decoration: InputDecoration(labelText: 'Parabéns!'),
            ),
            Card(
              elevation: 0,
              child: InkWell(
                onTap: onPickImage,
                child: Container(
                  decoration: imageBytes.length > 0
                      ? BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(imageBytes),
                          ),
                        )
                      : null,
                  height: Get.height / 4,
                  child: imageBytes.length == 0
                      ? Center(
                          child: Icon(
                            Icons.image_search,
                          ),
                        )
                      : Container(),
                ),
              ),
            ),
            ButtonBar(
              children: [
                ElevatedButton(
                  onPressed: onSend,
                  child: Text(
                    'ENVIAR',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
