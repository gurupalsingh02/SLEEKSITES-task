// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

bool null_user = false;

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);
  @override
  static var auth = FirebaseAuth.instance;

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    String email = "", password = "";
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) return "error";
                        email = value.toString();
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text("Email"), hintText: "Enter Your Email"),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) return "error";
                        password = value.toString();
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          label: Text("Password"),
                          hintText: "Enter Your Password"),
                    )
                  ],
                )),
            ElevatedButton(
              onPressed: () async {
                if (_formkey.currentState!.validate()) {
                  try {
                    await LogInPage.auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    Navigator.pushReplacementNamed(context, '/secret');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('User Successfully Logged in'),
                    ));
                  } on FirebaseAuthException catch (err) {
                    if (err.code == 'wrong-password')
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('wrong password'),
                      ));
                    else if (err.code == 'user-not-found')
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('user not found'),
                      ));
                    else if (err.code == 'user-disabled')
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Acoount is disabled'),
                      ));
                    else if (err.code == 'invalid-email')
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('email is Invalid'),
                      ));
                  }
                }
              },
              child: Text("Log In"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: null_user
                  ? Text(
                      "wrong email or password",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/Sign_in');
                            },
                            child: Row(
                              children: const [
                                Text(
                                  'new user? Sign In',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Icon(
                                  Icons.arrow_right_alt,
                                  color: Colors.lightBlue,
                                )
                              ],
                            )),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
