import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  const NewsDetail(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.description});
  final String title;
  final String imageUrl;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detay"),
      ),
      body: SafeArea(
          child: Container(
              child: Column(
        children: [
          Container(
            height: 230,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    ),
                image: DecorationImage(
                    image: NetworkImage(imageUrl), fit: BoxFit.cover)),
          ),
       
           Container(
            padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
            child: Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                  decoration: TextDecoration.none, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey,
          ),
           Container(
            padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
            child: Text(
              description,
              style: const TextStyle(
                  decoration: TextDecoration.none, fontStyle: FontStyle.italic),
            ),
          ),

        ],
      ))),
    );
  }
}
