import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/services/service.dart';

class CreatePostState {
  bool loading = false;
  String title = "";
  String description = "";

  CreatePostState({
    this.loading = false,
    this.title = "",
    this.description = "",
  });

  CreatePostState copyWith({
    bool? loading,
    String? title,
    String? description,
  }) {
    return CreatePostState(
      loading: loading ?? this.loading,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}

class CreatePostNotifier extends StateNotifier<CreatePostState> {
  CreatePostNotifier() : super(CreatePostState());

  Future<bool> create(String title, String description) async {
    state = state.copyWith(loading: true);
    final service = Service();
    final params = {
      "title": title,
      "body": description,
      "userId": 1,
    };
    final res = await service.createPost(params);
    log(res.toString());

    state = state.copyWith(loading: false);
    return res.id != null;
  }
}
