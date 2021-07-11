import 'package:redeinfo/data/model/feed_model.dart';
import 'package:redeinfo/data/model/post_model.dart';
import 'package:redeinfo/data/provider/feed_provider.dart';

class FeedRepository {
  final FeedProvider feedProvider;

  FeedRepository({required this.feedProvider});

  Future<FeedModel> getFeed() async {
    return await feedProvider.getFeed();
  }

  Future addPostToFeed(PostModel postModel) async {
    return await feedProvider.addPostToFeed(
      postModel,
    );
  }
}
