import 'package:flutter/material.dart';
import 'package:prostate_care/main_screens/article_screen/article_screen.dart';
import 'package:prostate_care/main_screens/home_screen/home_screen.dart';
import 'package:prostate_care/main_screens/main_function.dart';
import 'package:prostate_care/main_screens/profile/profile_screen.dart';
import 'package:prostate_care/main_screens/reminders/reminders_screen.dart';
import 'package:prostate_care/providers/auth_provider.dart';
import 'package:prostate_care/settings/constants.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static String id = '/main_screen';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var user = authProvider.user!;
    MainFunction.Reload(
      email: user.email,
      password: user.password,
      scaffoldKey: scaffoldKey,
      context: context,
    );
    // LoginFunction.donorLogin(
    //     email: authProvider.donor!.email,
    //     password: Constants.hashPassword(authProvider.donor!.password),
    //     scaffoldKey: scaffoldKey,
    //     context: context);
  }

  void reminder() {
    setState(() {
      currentIndex = 2;
    });
  }

  void resourse() {
    setState(() {
      currentIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _sceens = <Widget>[
      HomeScreen(
        toReminders: reminder,
        toResources: resourse,
      ),
      ArticleScreen(),
      ReminderScreen(),
      ProfileScreen()
    ];
    return Scaffold(
      body: _sceens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: currentIndex,
        selectedItemColor: Constants.darkPurple,
        unselectedItemColor: Constants.grey,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        // selectedLabelStyle:
        //     currentIndex == 2 ? TextStyle(fontSize: 10) : null,
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 30,
              height: 30,
              child: currentIndex == 0
                  ? Image.asset("assets/images/nav_bar/home-1.png")
                  : Image.asset("assets/images/nav_bar/home-2.png"),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 30,
              height: 30,
              child: currentIndex == 1
                  ? Image.asset("assets/images/nav_bar/resources-1.png")
                  : Image.asset("assets/images/nav_bar/resources-2.png"),
            ),
            label: "Resources",
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 30,
              height: 30,
              child: currentIndex == 2
                  ? Image.asset("assets/images/nav_bar/reminders-1.png")
                  : Image.asset("assets/images/nav_bar/reminders-2.png"),
            ),
            label: "Reminders",
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 30,
              height: 30,
              child: currentIndex == 3
                  ? Image.asset("assets/images/nav_bar/profile-1.png")
                  : Image.asset("assets/images/nav_bar/profile-2.png"),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
