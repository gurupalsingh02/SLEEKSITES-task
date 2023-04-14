import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_screen.dart';
import 'package:flutter_application_1/secret_screen.dart';
import 'package:flutter_application_1/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

String? userId;
Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chat GPT Clone',
        debugShowCheckedModeBanner: false,
        routes: {
          '/Sign_in': (context) => const SignInPage(),
          '/Log_in': (context) => const LogInPage(),
          '/secret': (context) => const SecretScreen(),
        },
        home: FutureBuilder(
          future: check(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return const SecretScreen();
              } else {
                return const LogInPage();
              }
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ));
  }
}

Future<bool> check() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  userId = sharedPreferences.getString('email');
  if (userId == null) return false;
  return true;
}
