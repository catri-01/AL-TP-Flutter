import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tp_al/posts/navigation/navigation_router.dart';
import 'package:tp_al/posts/service/posts_data_source/fake_posts_data_source.dart';
import 'package:tp_al/posts/service/posts_repository.dart';


import '../posts_bloc/posts_bloc.dart';
import '../posts_screen/create_post_screen/create_post_screen.dart';
import '../posts_screen/post_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostsRepository(
        postsDataSource: FakePostsDataSource(),
      ),
      child: Builder(
        builder: (context) {
          return BlocProvider(
            create: (context) => PostsBloc(
              postsRepository: context.read<PostsRepository>(),
            ),
            child: MaterialApp(
              routes: {
                PostsScreen.routeName: (context) => const PostsScreen(),
                CreatePostScreen.routeName: (context) => CreatePostScreen(),
              },
              onGenerateRoute: NavigationRouter.onGenerateRoute,
            ),
          );
        },
      ),
    );
  }
}