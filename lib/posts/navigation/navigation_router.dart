import 'package:flutter/material.dart';

import '../models/post.dart';
import 'package:tp_al/posts/posts_screen/post_detail_screen/post_detail_screen.dart';

class NavigationRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    Widget page = const SizedBox.shrink();
    switch (settings.name) {
      case PostDetailScreen.routeName:
        if (settings.arguments is Post) {
          page = PostDetailScreen(post: settings.arguments as Post);
        }
        break;
    }

    return MaterialPageRoute(builder: (context) => page);
  }
}