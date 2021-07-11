import 'package:get/route_manager.dart';
import 'package:redeinfo/bindings/feed_binding.dart';
import 'package:redeinfo/ui/feed/feed_screen.dart';

import 'app_routes.dart';

class AppPages {
  static final values = <GetPage>[
    GetPage(
      name: Routes.FEED,
      page: () => FeedScreen(),
      binding: FeedBinding(),
    ),
  ];
}
