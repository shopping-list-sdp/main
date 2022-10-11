import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shopping_list/screens/my_list_screen.dart';
import 'package:shopping_list/screens/pantry_screen.dart';
import '../custom_icons_icons.dart';
import '../queries/my_list_queries.dart';
import '../reusable_widgets/reusable_widgets.dart';
import '../utils/color_utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // do something
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
            backgroundColor: myColors("White"),
            body: ListView(children: <Widget>[
              SingleChildScrollView(
                  //allow page to scroll
                  child: Padding(
                padding: EdgeInsets.fromLTRB(
                    35, MediaQuery.of(context).size.height * 0.1, 35, 0),
                child: Column(children: <Widget>[
                  Text("Home", //title of page
                      style: TextStyle(
                          color: myColors("Purple"),
                          fontSize: 30,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    dashboardButtons(context, "Blue", "My List",
                        const MyListScreen()), //my list screen
                    dashboardButtons(context, "Pink", "Family List",
                        const MyListScreen()), //takes you to family list
                  ]),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    dashboardButtons(
                        context, "Yellow", "scheduled", const MyListScreen()),
                    dashboardButtons(
                        context,
                        "Purple",
                        "pantry", //takes you pantry page
                        const PantryScreen()),
                  ]),
                  const SizedBox(
                    //add space
                    height: 30,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    dashboardButtons(context, "Green", "expenses",
                        const MyListScreen()), //take you to spending page
                  ]),
                ]),
              )),
            ]),
            appBar: appBar(context),
            bottomNavigationBar: navBar(context, "dashboard")));
  }
}
