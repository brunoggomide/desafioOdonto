import 'package:flutter/material.dart';
import 'package:odonto/src/pages/auth/sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white.withAlpha(200)),
      debugShowCheckedModeBanner: false,
      home: const SignIn(),
    );
  }
}
