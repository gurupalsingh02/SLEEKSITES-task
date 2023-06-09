// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_screen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String email = "", password = "";
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
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
                        if (value == null || value.isEmpty)
                          return "Email is Invalid";
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
                    final cred = await LogInPage.auth
                        .createUserWithEmailAndPassword(
                            email: email, password: password);
                  } on FirebaseAuthException catch (err) {
                    if (err.code == 'weak-password')
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('weak password'),
                      ));
                    else if (err.code == 'invalid-email')
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Invalid Email'),
                      ));
                    else if (err.code == 'email-already-in-use')
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Email is Already Registered'),
                      ));
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('User Successfully Registered'),
                      ));
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(e.toString()),
                    ));
                  }
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("InValid Email")));
                }
              },
              child: Text("Create Account"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/Log_in');
                    },
                    child: Row(
                      children: const [
                        Text(
                          'already have account? log in',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          color: Colors.lightBlue,
                        )
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
