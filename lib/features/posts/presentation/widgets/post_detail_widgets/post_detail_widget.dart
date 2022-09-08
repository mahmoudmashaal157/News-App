import 'package:flutter/material.dart';
import 'package:news_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:news_clean_architecture/features/posts/presentation/widgets/post_detail_widgets/post_delete_btn.dart';
import 'package:news_clean_architecture/features/posts/presentation/widgets/post_detail_widgets/update_post_btn_widget.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;

  PostDetailWidget({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(
            post.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Divider(
            height: 50,
          ),
          Text(
            post.body,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UpdatePostBtnWidget(post:post),
              SizedBox(width: 50,),
              PostDeleteBtn(postId:post.id!),
            ],
          )
        ],
      ),
    );
  }
  

}
