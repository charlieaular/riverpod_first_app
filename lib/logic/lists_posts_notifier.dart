import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/models/post.dart';
import 'package:riverpod_app/services/service.dart';

class ListPostState {
  ListPostState({
    this.loading = false,
    this.posts = const [],
  });

  bool loading = false;
  List<Post> posts = [];

  ListPostState copyWith({
    bool? loading,
    List<Post>? posts,
  }) {
    return ListPostState(
      loading: loading ?? this.loading,
      posts: posts ?? this.posts,
    );
  }
}

class ListPostsNotifier extends StateNotifier<ListPostState> {
  ListPostsNotifier() : super(ListPostState()) {
    getAll();
  }

  Future<void> getAll() async {
    state = state.copyWith(loading: true);
    final service = Service();
    final list = await service.getAllPost();
    state = state.copyWith(loading: false, posts: list);
  }
}
