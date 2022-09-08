import 'package:flutter/material.dart';
import 'package:news_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:news_clean_architecture/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:news_clean_architecture/features/posts/presentation/pages/post_detail_page.dart';

class PostListWidget extends StatelessWidget {

  List<Post>posts;

  PostListWidget({required this.posts});


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(posts[index].id.toString()),
            title: Text(posts[index].title.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
            ),
            subtitle: Text(posts[index].body,
            style: TextStyle(
              fontSize: 16,
            ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return PostDetailPage(post: posts[index]);
              }));
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(thickness: 1,);
        },
        itemCount: posts.length,
    );
  }
}
