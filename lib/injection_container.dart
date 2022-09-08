import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_clean_architecture/core/network/network_info.dart';
import 'package:news_clean_architecture/features/posts/data/datasources/post_local_data_source.dart';
import 'package:news_clean_architecture/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:news_clean_architecture/features/posts/data/repositories/post_repository_impl.dart';
import 'package:news_clean_architecture/features/posts/domain/repositories/posts_repository.dart';
import 'package:news_clean_architecture/features/posts/domain/usecases/add_post.dart';
import 'package:news_clean_architecture/features/posts/domain/usecases/delete_post.dart';
import 'package:news_clean_architecture/features/posts/domain/usecases/get_all_posts.dart';
import 'package:news_clean_architecture/features/posts/domain/usecases/update_post.dart';
import 'package:news_clean_architecture/features/posts/presentation/bloc/add_delete_update/add_delete_update_bloc.dart';
import 'package:news_clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init()async{
  //Features - posts


  //Bloc

  sl.registerFactory(() => PostsBloc(getAllPostsUsecase: sl()));
  sl.registerFactory(() => AddDeleteUpdateBloc(
      addPostUseCase: sl(),
      deletePostUseCase: sl(),
      updatePostUseCase: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetAllPosts(repository: sl()));
  sl.registerLazySingleton(() => AddPost(postsRepository: sl()));
  sl.registerLazySingleton(() => DeletePost(postsRepository: sl()));
  sl.registerLazySingleton(() => UpdatePost(postsRepository: sl()));

  //Repository
  sl.registerLazySingleton<PostsRepository>(() => PostRepositoryImpl(remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl()));

  //Datasources
  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImpl(sharedPreferences: sl()));


  //core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

}