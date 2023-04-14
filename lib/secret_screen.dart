import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_screen.dart';
import 'package:flutter_application_1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecretScreen extends StatefulWidget {
  const SecretScreen({super.key});

  @override
  State<SecretScreen> createState() => _SecretScreenState();
}

class _SecretScreenState extends State<SecretScreen> {
  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    store();
  }

  store() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('email', LogInPage.auth.currentUser!.email!);
    userId = sharedPreferences.getString('email');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('secret screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('user email : $userId'),
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    sharedPreferences.remove('email');
                    LogInPage.auth.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/Log_in',
                      (route) => false,
                    );
                  },
                  child: const Text('log out'))),
        ],
      ),
    );
  }
}
