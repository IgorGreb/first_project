import 'package:dio/dio.dart';
import 'package:flutter_application_grebenyuk/homeworks/eleven/constants/eleven_constants.dart';
import 'package:flutter_application_grebenyuk/homeworks/eleven/models/comment_model.dart';
import 'package:flutter_application_grebenyuk/homeworks/eleven/models/post_model.dart';

class PostRemoteDataSource {
  PostRemoteDataSource({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<List<PostModel>> getPosts() async {
    try {
      final response = await _dio.get(ElevenApiConstants.posts);
      return (response.data as List).map((e) => PostModel.fromJson(e)).toList();
    } on DioException catch (error) {
      throw Exception('Failed to fetch posts: ${error.message}');
    } catch (error) {
      throw Exception('Unexpected error while fetching posts: $error');
    }
  }

  Future<List<CommentModel>> getCommentsByPost(int id) async {
    try {
      final response = await _dio.get(
        ElevenApiConstants.commentsByPost(id),
      );
      return (response.data as List)
          .map((e) => CommentModel.fromJson(e))
          .toList();
    } on DioException catch (error) {
      throw Exception('Failed to fetch comments: ${error.message}');
    } catch (error) {
      throw Exception('Unexpected error while fetching comments: $error');
    }
  }

  Future<void> deletePost(int id) async {
    try {
      await _dio.delete(ElevenApiConstants.post(id));
    } on DioException catch (error) {
      throw Exception('Failed to delete post: ${error.message}');
    } catch (error) {
      throw Exception('Unexpected error while deleting post: $error');
    }
  }
}
