import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vnnews/Service/cloudfirestore.dart';
import 'package:vnnews/compoment/constrant.dart';

class CommentTextField extends StatefulWidget {
  const CommentTextField({Key? key, required this.snapshot}) : super(key: key);
  final QueryDocumentSnapshot snapshot;

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  static final commentFormKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  void onTapComment(String comment) async {
    await CloudFireStore().addComment(widget.snapshot["id"], comment);
    textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Form(
        key: commentFormKey,
        child: Stack(children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black),
              ),
              height: 50,
              child: Container(
                margin: const EdgeInsets.only(right: 40),
                child: TextFormField(
                  controller: textEditingController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Hãy nhập gì đó";
                    } else {
                      return null;
                    }
                  },
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: kDefaultFontSize + 2),
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              )),
          Positioned(
            right: 0,
            child: IconButton(
                onPressed: () {
                  if (commentFormKey.currentState!.validate()) {
                    onTapComment(textEditingController.text);
                  }
                },
                icon: const Icon(LineIcons.alternateLongArrowRight)),
          )
        ]),
      ),
    );
  }
}
