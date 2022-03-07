import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/logic/create_post_notifier.dart';
import 'package:riverpod_app/logic/edit_post_notifier.dart';

final editPostNotifier = StateNotifierProvider.autoDispose<EditPostNotifier, EditPostState>((_) => EditPostNotifier());

class EditPostPage extends ConsumerStatefulWidget {
  final String id;
  const EditPostPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends ConsumerState<EditPostPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    onInit(ref, widget.id);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watcher = ref.watch(editPostNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onPress(context, ref),
        child: const Icon(Icons.add),
      ),
      body: Builder(builder: (context) {
        if (watcher.loading) return const Center(child: CircularProgressIndicator.adaptive());

        return Column(
          children: [
            Text(widget.id),
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
    final provider = ref.read(editPostNotifier.notifier);
    final title = titleController.text;
    final description = titleController.text;
    final res = await provider.editPost(widget.id, title, description);
    if (res) {
      GoRouter.of(ctx).goNamed('list');
    }
  }

  Future<void> onInit(WidgetRef ref, String id) async {
    final provider = ref.read(editPostNotifier.notifier);
    final post = await provider.fetchPost(widget.id);
    titleController.text = post.title ?? '';
    descriptionController.text = post.body ?? '';
  }
}
