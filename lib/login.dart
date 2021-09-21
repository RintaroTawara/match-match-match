import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:group_matching_app/user_account_list_page.dart';
import 'authentication_error.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String loginEmail = "";
  String loginPassword = "";
  String infoText = "";

  User? user;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final authError = AuthenticationError();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "メールアドレス"
                ),
                onChanged: (String value) {
                  loginEmail = value;
                }
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "パスワード(6~20文字)"
                ),
                obscureText: true,
                maxLength: 20,
                maxLengthEnforcement: MaxLengthEnforcement.none,
                onChanged: (String value) {
                  loginPassword = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
              child: Text(
                infoText,
                style: TextStyle(
                    color: Colors.red
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
              child: SizedBox(
                width: 350.0,
                child: ElevatedButton(
                  child: Text(
                    'ログイン',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white
                  ),
                  onPressed: () async {
                    try {
                      UserCredential result = await auth.signInWithEmailAndPassword(email: loginEmail, password: loginPassword);
                      user = result.user;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserAccountListPage()
                          )
                      );
                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        infoText = authError.loginErrorMsg(e.code);
                      });
                    }},
                )

            ))
      ]
        )
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: 350.0,
                child: ElevatedButton(
                  child: Text(
                    'アカウントを作成する',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue[50],
                      onPrimary: Colors.blue
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  }
                )
            ),
          )
        ],
      ),
    );
  }
}
