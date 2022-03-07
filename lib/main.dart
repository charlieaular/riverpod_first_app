import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/create_post_page.dart';
import 'package:riverpod_app/edit_post_page.dart';

import 'list_posts_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, state) => const ListPostsPage(), name: 'list'),
        GoRoute(path: '/create-post', builder: (_, state) => const CreatePostPage(), name: 'create-post'),
        GoRoute(
            path: '/edit-post/:id',
            builder: (_, state) {
              final id = state.params["id"]!;
              return EditPostPage(id: id);
            },
            name: 'edit-post'),
      ],
    );

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}
