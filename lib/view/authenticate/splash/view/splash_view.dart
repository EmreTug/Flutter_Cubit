import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../home/homepage/view/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.microtask(() async {
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) =>
           HomeView()),(route) => false,);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.blue,
            Colors.yellow,
          ])),
      child: Lottie.asset('assets/lottie/news_lottie.json'),
    );
  }
}
