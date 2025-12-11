import 'package:dio/dio.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_11/constants/eleven_constants.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_11/models/comment_model.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_11/models/post_model.dart';

class PostRemoteDataSource {
  PostRemoteDataSource({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<List<PostModel>> getPosts() async {
    try {
      final response = await _dio.get(ElevenApiConstants.posts);
      return (response.data as List).map((e) => PostModel.fromJson(e)).toList();
    } on DioException catch (error) {
      throw Exception('Не вдалося отримати пости: ${error.message}');
    } catch (error) {
      throw Exception('Неочікувана помилка під час отримання постів: $error');
    }
  }

  Future<List<CommentModel>> getCommentsByPost(int id) async {
    try {
      final response = await _dio.get(ElevenApiConstants.commentsByPost(id));
      return (response.data as List)
          .map((e) => CommentModel.fromJson(e))
          .toList();
    } on DioException catch (error) {
      throw Exception('Не вдалося отримати коментарі: ${error.message}');
    } catch (error) {
      throw Exception(
        'Неочікувана помилка під час отримання коментарів: $error',
      );
    }
  }

  Future<void> deletePost(int id) async {
    try {
      await _dio.delete(ElevenApiConstants.post(id));
    } on DioException catch (error) {
      throw Exception('Не вдалося видалити пост: ${error.message}');
    } catch (error) {
      throw Exception('Неочікувана помилка під час видалення поста: $error');
    }
  }
}
