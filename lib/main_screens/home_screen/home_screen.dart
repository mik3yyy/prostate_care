import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prostate_care/global_comonents/custom_button.dart';
import 'package:prostate_care/global_comonents/custom_text_button.dart';
import 'package:prostate_care/main_screens/article_screen/view_article.dart';
import 'package:prostate_care/main_screens/notification_screen/notification_screen.dart';
import 'package:prostate_care/main_screens/reminders/add_reminder.dart';
import 'package:prostate_care/main_screens/reminders/edit_reminder.dart';
import 'package:prostate_care/main_screens/risk_screen/risk_screen.dart';
import 'package:prostate_care/models/article.dart';
import 'package:prostate_care/models/reminder.dart';
import 'package:prostate_care/providers/auth_provider.dart';
import 'package:prostate_care/providers/reminder_provider.dart';
import 'package:prostate_care/settings/constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.toReminders, required this.toResources});
  final VoidCallback toReminders;
  final VoidCallback toResources;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    var reminderProvider = Provider.of<ReminderProvider>(context, listen: true);

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
                "How are you doing today?",
                style: TextStyle(
                  fontSize: 14,
                  color: Constants.grey,
                ),
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationScreen()));
            },
            icon: Icon(
              Icons.notifications_outlined,
              color: Constants.teal,
              size: 30,
            ),
          ),
          Constants.gap(width: 16)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 16),
        child: Column(
          children: [
            Container(
              height: 180,
              child: PageView(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    // height: 142,
                    width: MediaQuery.sizeOf(context).width * .7,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Constants.primaryBlue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 130,
                          child: Text(
                            "Need to take a risk test?",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Constants.white,
                            ),
                          ),
                        ),
                        // Constants.gap(height: 10),
                        CustomButton(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RiskScreen()));
                          },
                          title: "Risk Calculation",
                          style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFF3E64FF),
                          ),
                          color: Constants.white,
                          height: 30,
                          width: 124,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    // height: 142,
                    width: MediaQuery.sizeOf(context).width * .7,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Constants.lightBlue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 140,
                          child: Text(
                            "Don’t forget your reminders!",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Constants.black,
                            ),
                          ),
                        ),
                        // Constants.gap(height: 10),
                        CustomButton(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddReminderScreen()));
                          },
                          title: "Add reminder",
                          style: TextStyle(
                            fontSize: 9,
                            color: Constants.white,
                          ),
                          color: Constants.darkPurple,
                          height: 30,
                          width: 124,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Constants.gap(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Reminders",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      CustomTextButton(
                        text: 'See all',
                        onPressed: widget.toReminders,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Constants.purple,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 170,
              child: ListView.builder(
                itemCount: reminderProvider.reminders.length > 2
                    ? 2
                    : reminderProvider.reminders.length,
                itemBuilder: (context, index) {
                  Reminder reminder = reminderProvider.reminders[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditReminderScreen(reminder: reminder)));
                    },
                    leading: Image.asset(
                        'assets/images/reminder/${int.parse(reminder.image) + 1}.png'),
                    title: Text(
                      reminder.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      reminder.description,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: Text(
                      Constants.formatTimeOfDay(reminder.time),
                      style: TextStyle(
                        color: Constants.teal,
                      ),
                    ),
                  );
                },
              ),
            ),
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
                  Row(
                    children: [
                      CustomTextButton(
                        text: 'See all',
                        onPressed: widget.toResources,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Constants.purple,
                      )
                    ],
                  ),
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
                          tag: '$index',
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
          ],
        ),
      ),
    );
  }
}
