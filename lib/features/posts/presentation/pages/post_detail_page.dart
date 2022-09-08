import 'package:flutter/material.dart';
import 'package:news_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:news_clean_architecture/features/posts/presentation/widgets/post_detail_widgets/post_detail_widget.dart';

class PostDetailPage extends StatelessWidget {

  final Post post;

  PostDetailPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Detail"),
      ),
      body:BuildBody(post: post) ,
    );
  }
}
class BuildBody extends StatelessWidget {

  final Post post;

  BuildBody({required this.post});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:PostDetailWidget(post: post) ,
    );
  }
}

