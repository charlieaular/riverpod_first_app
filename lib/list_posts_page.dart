import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/models/post.dart';

import 'logic/lists_posts_notifier.dart';

final postProvider = StateNotifierProvider<ListPostsNotifier, ListPostState>((ref) => ListPostsNotifier());

class ListPostsPage extends ConsumerWidget {
  const ListPostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postWatcher = ref.watch(postProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Builder(builder: (context) {
              if (postWatcher.loading) return const CircularProgressIndicator();
              return Expanded(
                child: ListView.builder(
                  itemCount: postWatcher.posts.length,
                  itemBuilder: (ctx, index) {
                    final item = postWatcher.posts[index];
                    return InkWell(
                      onTap: () => onTapCard(ctx, item),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text('Title:'),
                                    const SizedBox(width: 10),
                                    Text(item.title ?? ''),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    const Text('Body:'),
                                    const SizedBox(width: 10),
                                    Text(item.body ?? ''),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => goToCreate(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void onTapCard(BuildContext ctx, Post item) {
    GoRouter.of(ctx).goNamed('edit-post', params: {"id": item.id.toString()});
  }

  void goToCreate(BuildContext ctx) {
    GoRouter.of(ctx).goNamed('create-post');
  }
}
