import 'dart:convert';

import 'package:flutter/material.dart';

class CreateComment extends StatelessWidget {
  final List<dynamic> comment;
  const CreateComment({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.4,
      ),
      child: ListView.builder(
          itemCount: comment.length,
          itemBuilder: (context, index) {
            return Text(comment[index]["content"].toString());
          }),
    );
  }
}
