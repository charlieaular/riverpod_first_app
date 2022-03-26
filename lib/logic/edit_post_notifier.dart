import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/services/service.dart';

import '../models/post.dart';

class EditPostState {
  bool loading = false;
  Post? post;

  EditPostState({this.loading = false, this.post});

  EditPostState copyWith({bool? loading, Post? post}) {
    return EditPostState(
      loading: loading ?? this.loading,
      post: post ?? this.post,
    );
  }
}

class EditPostNotifier extends StateNotifier<EditPostState> {
  EditPostNotifier() : super(EditPostState());

  Future<Post> fetchPost(String id) async {
    state = state.copyWith(loading: true);
    final service = Service();
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(loading: false);
    final res = await service.getPost(id);
    return res;
  }

  Future<bool> editPost(String id, String title, String description) async {
    state = state.copyWith(loading: true);
    final service = Service();
    final params = {
      "id": id,
      "title": title,
      "body": description,
      "userId": 1,
    };
    final res = await service.editPost(id, params);
    log(res.toString());

    state = state.copyWith(loading: false);
    return res.id != null;
  }
}
