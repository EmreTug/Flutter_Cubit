import 'package:flutter/material.dart';
import 'package:flutter_architecture/view/authenticate/login/view/loginview.dart';
import 'package:flutter_architecture/view/authenticate/splash/view/splash_view.dart';
import 'package:flutter_architecture/view/home/homepage/view/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(      
      home:  HomeView(),
    );
  }
}


