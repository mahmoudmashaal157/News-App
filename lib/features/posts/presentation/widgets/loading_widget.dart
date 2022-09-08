import 'package:flutter/material.dart';
import 'package:news_clean_architecture/core/app_theme.dart';

class LoadingWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: secondaryColor,
      ),
    );
  }
}
