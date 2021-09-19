import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:group_matching_app/registration.dart';
import 'package:group_matching_app/root_page.dart';
import 'package:group_matching_app/user_account_list_page.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Matching app',
        home: RootPage(),
        routes: <String, WidgetBuilder>{
          '/user_account_list': (BuildContext context) => UserAccountListPage(),
          '/register': (BuildContext context) => Registration(),
          '/login': (BuildContext context) => Login(),
        });
  }
}
