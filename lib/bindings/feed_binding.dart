import 'package:get/get.dart';
import 'package:redeinfo/controller/feed_controller.dart';
import 'package:redeinfo/data/provider/feed_provider.dart';
import 'package:redeinfo/data/repository/feed_repository.dart';

class FeedBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FeedController>(
      FeedController(
        repository: FeedRepository(
          feedProvider: FeedProvider(),
        ),
      ),
    );
  }
}
