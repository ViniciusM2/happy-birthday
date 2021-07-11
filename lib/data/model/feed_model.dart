import 'package:get/get.dart';
import 'package:redeinfo/data/model/post_model.dart';

class FeedModel {
  List<PostModel> posts = [];

  FeedModel.fromPosts({required this.posts});
  FeedModel.empty();
}
