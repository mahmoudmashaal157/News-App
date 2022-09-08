import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:news_clean_architecture/core/error/exception.dart';
import 'package:news_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource{
  Future<List<PostModel>> getCachedPost();
  Future<Unit> cachePosts(List<PostModel>postModels);
}

class PostLocalDataSourceImpl implements PostLocalDataSource{
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelsToJson = postModels.map<Map<String,dynamic>>((postModel) => postModel.toJson()).toList();
    sharedPreferences.setString("CACHED_POSTS",json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPost() {
    final jsonString = sharedPreferences.getString("CACHED_POSTS");
    if(jsonString !=null){
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData.map<PostModel>((jsonPostModel) =>PostModel.fromJson(jsonPostModel)).toList();
      return Future.value(jsonToPostModels);
    }
    else {
      throw EmptyCacheException();
    }
  }
  
}