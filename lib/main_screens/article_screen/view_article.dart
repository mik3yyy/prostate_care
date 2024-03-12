import 'package:flutter/material.dart';
import 'package:prostate_care/global_comonents/custom_button.dart';
import 'package:prostate_care/global_comonents/custom_messageHandler.dart';
import 'package:prostate_care/models/article.dart';
import 'package:prostate_care/settings/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewArticle extends StatefulWidget {
  const ViewArticle({super.key, required this.article, required this.index});
  final Article article;
  final int index;
  @override
  State<ViewArticle> createState() => _ViewArticleState();
}

class _ViewArticleState extends State<ViewArticle> {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    Article article = widget.article;
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
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
                    tag: "${widget.index}",
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
        bottomNavigationBar: Container(
          height: 100,
          child: CustomButton(
            onTap: () async {
              if (!await launchUrl(Uri.parse(widget.article.link))) {
                MyMessageHandler.showSnackBar(
                    scaffoldKey, 'Could not launch rrl');
              }
            },
            title: "View article",
          ),
        ),
      ),
    );
  }
}
