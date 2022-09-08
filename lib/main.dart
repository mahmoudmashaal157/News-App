import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_clean_architecture/core/app_theme.dart';
import 'package:news_clean_architecture/features/posts/presentation/bloc/add_delete_update/add_delete_update_bloc.dart';
import 'package:news_clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:news_clean_architecture/features/posts/presentation/pages/posts_page.dart';
import 'injection_container.dart' as di;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_)=>di.sl<PostsBloc>()..add(GetAllPostsEvent())),
          BlocProvider(create: (_)=>di.sl<AddDeleteUpdateBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
      theme: appTheme,
      home:PostsPage()  ,
        )
    );
  }

}


