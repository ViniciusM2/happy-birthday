import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redeinfo/data/model/feed_model.dart';
import 'package:redeinfo/data/model/post_model.dart';

class FeedProvider {
  final DocumentReference feed =
      FirebaseFirestore.instance.collection('feeds').doc('vinimenezez');
  Future<FeedModel> getFeed() async {
    var postsSnapshot = await feed.collection('posts').get();
    var feedModel = FeedModel.fromPosts(
      posts: postsSnapshot.docs
          .map(
            (e) => PostModel.fromMap(
              e.data(),
            ),
          )
          .toList(),
    );
    print(feedModel.posts.map((e) => e.authorName));
    return feedModel;
  }

  addPostToFeed(PostModel postModel) async {
    var posts = feed.collection('posts');
    await posts.add(
      postModel.toMap(),
    );
  }
}

/*
  final CollectionReference courses =
      FirebaseFirestore.instance.collection('users');
  Future<UserModel> getUser() async {
    var query = await courses.doc('vinimenezez').get();
    return UserModel.fromMap(query.data());
  }
*/
