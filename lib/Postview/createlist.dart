import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vnnews/compoment/constrant.dart';

class CreateList extends StatelessWidget {
  final QueryDocumentSnapshot post;
  const CreateList({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> list = post["content"].toString().split(";");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Text(
            post["tittle"].toString(),
            textAlign: TextAlign.justify,
            style: const TextStyle(
                color: Colors.black,
                fontSize: kDefaultFontSize + 8,
                fontWeight: FontWeight.bold),
            softWrap: true,
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(LineIcons.clock),
                ),
                Text(
                  DateFormat('dd-MM-yyyy hh:mm').format(
                      DateTime.parse(post["posttime"].toDate().toString())),
                  style: const TextStyle(
                      fontSize: kDefaultFontSize, fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(LineIcons.eye),
                ),
                Text(
                  post["viewed"].toString(),
                  style: const TextStyle(
                      fontSize: kDefaultFontSize, fontWeight: FontWeight.bold),
                )
              ],
            )),
        SizedBox(
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(
                        top: 6.0, bottom: 6, left: 4, right: 4),
                    child: Text(
                      list.elementAt(index).toString(),
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      style: const TextStyle(
                          color: Colors.black, fontSize: kDefaultFontSize),
                    ));
              }),
        ),
      ],
    );
  }
}
