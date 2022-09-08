import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:news_clean_architecture/features/posts/presentation/bloc/add_delete_update/add_delete_update_bloc.dart';
import 'package:news_clean_architecture/features/posts/presentation/widgets/post_add_update_widgets/form_submit_btn.dart';
import 'package:news_clean_architecture/features/posts/presentation/widgets/post_add_update_widgets/text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatepost;
  final Post? post;

  FormWidget({this.post, required this.isUpdatepost});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatepost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final post = widget.isUpdatepost
          ? Post(
              id: widget.post!.id,
              title: _titleController.text,
              body: _bodyController.text)
          : Post(title: _titleController.text, body: _bodyController.text);
      if (widget.isUpdatepost == true) {
        BlocProvider.of<AddDeleteUpdateBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdateBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget (name: "Title", multiLines:false, controller: _titleController),
            TextFormFieldWidget (name: "Body", multiLines:true, controller: _bodyController),
            FormSubmitBtn(isUpdatePost: widget.isUpdatepost, onPressed:validateFormThenUpdateOrAddPost),
          ],
        ));
  }
}
