import 'package:flutter/material.dart';
import 'package:prostate_care/models/blogs.dart';
import 'package:prostate_care/settings/constants.dart';

class ViewBlog extends StatefulWidget {
  const ViewBlog({super.key, required this.blog});
  final Blog blog;
  @override
  State<ViewBlog> createState() => _ViewBlogState();
}

class _ViewBlogState extends State<ViewBlog> {
  @override
  Widget build(BuildContext context) {
    Blog blog = widget.blog;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text(
            blog.title,
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
                  tag: "blog",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      blog.image,
                      height: 178,
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Constants.gap(height: 10),
                Text(
                  blog.heading,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Constants.gap(height: 10),
                Text(blog.body)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
