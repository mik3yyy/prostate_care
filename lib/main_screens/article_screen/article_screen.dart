import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prostate_care/main_screens/article_screen/view_article.dart';
import 'package:prostate_care/main_screens/article_screen/view_blog.dart';
import 'package:prostate_care/models/article.dart';
import 'package:prostate_care/models/blogs.dart';
import 'package:prostate_care/providers/auth_provider.dart';
import 'package:prostate_care/settings/constants.dart';
import 'package:provider/provider.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Container(
          padding: EdgeInsets.only(left: 5),
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi ${authProvider.user!.fullName.split(' ')[0]},",
                style: TextStyle(
                  fontSize: 18,
                  color: Constants.black,
                ),
              ),
              Text(
                "Resources carefully picked for you",
                style: TextStyle(
                  fontSize: 14,
                  color: Constants.grey,
                ),
              )
            ],
          ),
        ),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     Icons.add,
          //     color: Constants.teal,
          //   ),
          // ),
          // Constants.gap(width: 16)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Articles",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     CustomTextButton(
                  //       text: 'See all',
                  //       onPressed: widget.toResources,
                  //     ),
                  //     Icon(
                  //       Icons.chevron_right,
                  //       color: Constants.purple,
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('articles').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                List<Article> articles = snapshot.data!.docs.map((doc) {
                  return Article.fromMap(doc.data() as Map<String, dynamic>);
                }).toList();

                return Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      Article article = articles[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewArticle(
                                        article: article,
                                        index: index,
                                      )));
                        },
                        leading: Hero(
                          tag: "$index",
                          child: Image.network(
                            article.image,
                            width: 115,
                            // height: 140,
                            fit: BoxFit.cover,
                          ),
                        ),

                        title: Text(
                          article.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(article.author),
                        // You can add more details here, like an Image widget for the article image, etc.
                      );
                    },
                  ),
                );
              },
            ),
            // Container(
            //   height: 150,
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(left: 20, right: 20),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             const Text(
            //               "Blogs",
            //               style: TextStyle(
            //                 fontSize: 18,
            //               ),
            //             ),
            //             // Row(
            //             //   children: [
            //             //     CustomTextButton(
            //             //       text: 'See all',
            //             //       onPressed: widget.toResources,
            //             //     ),
            //             //     Icon(
            //             //       Icons.chevron_right,
            //             //       color: Constants.purple,
            //             //     )
            //             //   ],
            //             // ),
            //           ],
            //         ),
            //       ),
            //       Constants.gap(height: 10),
            //       StreamBuilder<QuerySnapshot>(
            //         stream: FirebaseFirestore.instance
            //             .collection('blogs')
            //             .snapshots(),
            //         builder: (context, snapshot) {
            //           if (snapshot.hasError) {
            //             return Text('Something went wrong');
            //           }

            //           if (snapshot.connectionState == ConnectionState.waiting) {
            //             return CircularProgressIndicator();
            //           }

            //           List<Blog> blogs = snapshot.data!.docs.map((doc) {
            //             return Blog.fromMap(doc.data() as Map<String, dynamic>);
            //           }).toList();

            //           return Expanded(
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 20),
            //               child: ListView.separated(
            //                 separatorBuilder: (context, index) => Divider(),
            //                 itemCount: blogs.length,
            //                 scrollDirection: Axis.horizontal,
            //                 itemBuilder: (context, index) {
            //                   Blog blog = blogs[index];
            //                   return GestureDetector(
            //                     onTap: () {
            //                       Navigator.push(
            //                           context,
            //                           MaterialPageRoute(
            //                               builder: (context) =>
            //                                   ViewBlog(blog: blog)));
            //                     },
            //                     child: Container(
            //                       width: 116,
            //                       // height: 50,
            //                       child: Hero(
            //                         tag: 'blog',
            //                         child: ClipRRect(
            //                           borderRadius: BorderRadius.circular(10),
            //                           child: Image.network(
            //                             blog.image,
            //                             fit: BoxFit.cover,
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 },
            //               ),
            //             ),
            //           );
            //         },
            //       ),

            //     ],

            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
