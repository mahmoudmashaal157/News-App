import 'package:flutter/material.dart';
import 'package:news_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:news_clean_architecture/features/posts/presentation/pages/post_add_update_page.dart';

class UpdatePostBtnWidget extends StatelessWidget {

  final Post post;

  UpdatePostBtnWidget({required this.post});



  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
            return PostAddUpdatePage(isUpdatePost: true,post: post,);
          }));
        },
        icon: Icon(Icons.edit),
        label: Text("Edit")
    );
  }
}
