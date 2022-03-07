import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/logic/create_post_notifier.dart';

final createPostNotifier = StateNotifierProvider<CreatePostNotifier, CreatePostState>((_) => CreatePostNotifier());

class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watcher = ref.watch(createPostNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onPress(context, ref),
        child: const Icon(Icons.add),
      ),
      body: Builder(builder: (context) {
        if (watcher.loading) return const Center(child: CircularProgressIndicator.adaptive());
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextFormField(
                controller: descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Description',
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Future<void> onPress(BuildContext ctx, WidgetRef ref) async {
    final provider = ref.read(createPostNotifier.notifier);
    final title = titleController.text;
    final description = titleController.text;
    final res = await provider.create(title, description);
    if (res) {
      GoRouter.of(ctx).goNamed('list');
    }
  }
}
