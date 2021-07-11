import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redeinfo/controller/feed_controller.dart';
import 'package:redeinfo/ui/feed/widgets/feed_card.dart';

class FeedScreen extends GetView<FeedController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('Feed'),
          automaticallyImplyLeading: false,
        ),
        body: _ColumnsLayout(
          crossAxisCount: context.width < 2000 ? 3 : 3,
        ),
        floatingActionButton: controller.loading
            ? FloatingActionButton(
                backgroundColor: Get.theme.primaryColor,
                child: CircularProgressIndicator(
                  color: Get.theme.colorScheme.secondary,
                ),
                onPressed: () {},
              )
            : FloatingActionButton(
                child: Icon(Icons.post_add),
                onPressed: controller.handleNewPostFirstAct,
              ),
      ),
    );
  }
}

bool get isPermanentDrawerSituation {
  var context = Get.context;
  return context?.orientation == Orientation.landscape &&
      GetPlatform.isWeb &&
      !(GetPlatform.isMobile) &&
      context!.height > 500 &&
      context.width > 1050;
}

class _ColumnsLayout extends StatelessWidget {
  final int crossAxisCount;
  _ColumnsLayout({required this.crossAxisCount});
  final FeedController controller = Get.find<FeedController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Obx(() => GridView.builder(
                    itemCount: controller.feedModel.value.posts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: FeedCard.fromPostModel(
                            post: controller.feedModel.value.posts[index],
                          ),
                        ),
                      );
                    },
                  ))
              // crossAxisCount: crossAxisCount,
              // children: [
              //   // SizedBox(height: 12),
              //   ...(controller.feedModel.value.posts
              //       .map((element) => Padding(
              //             padding: const EdgeInsets.only(bottom: 12),
              //             child: AspectRatio(
              //                 aspectRatio: 1,
              //                 child: FeedCard.fromPostModel(post: element)),
              //           ))
              //       .toList())
              // ],
              ),
        ),
      ],
    );
  }
}
