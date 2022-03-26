import 'package:dio/dio.dart';
import 'package:riverpod_app/models/post.dart';

class Service {
  late Dio _dio;

  Service() {
    _dio = Dio();
  }

  String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> getAllPost() async {
    final url = "$baseUrl/posts";
    final res = await _dio.get(url);
    return (res.data as List).map((e) => Post.fromJson(e)).toList();
  }

  Future<Post> createPost(Map params) async {
    final url = "$baseUrl/posts";
    final res = await _dio.post(url, data: params);
    return Post.fromJson(res.data);
  }

  Future<Post> editPost(String id, Map params) async {
    final url = "$baseUrl/posts/$id";
    final res = await _dio.put(url, data: params);
    return Post.fromJson(res.data);
  }

  Future<Post> getPost(String id) async {
    final url = "$baseUrl/posts/$id";
    final res = await _dio.get(url);
    return Post.fromJson(res.data);
  }
}
