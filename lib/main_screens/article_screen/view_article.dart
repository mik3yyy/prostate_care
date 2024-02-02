import 'package:flutter/material.dart';
import 'package:prostate_care/models/article.dart';
import 'package:prostate_care/settings/constants.dart';

class ViewArticle extends StatefulWidget {
  const ViewArticle({super.key, required this.article});
  final Article article;
  @override
  State<ViewArticle> createState() => _ViewArticleState();
}

class _ViewArticleState extends State<ViewArticle> {
  @override
  Widget build(BuildContext context) {
    Article article = widget.article;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text(
            article.title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Constants.gap(width: 20),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: "1",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      article.image,
                      height: 178,
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Constants.gap(height: 10),
                Text(
                  article.heading,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Constants.gap(height: 10),
                Text(article.body)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
