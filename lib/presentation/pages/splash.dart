import 'package:ayurvedic/presentation/pages/login.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3200)).then((value) => {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Login()))
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/bg.jpg',
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.height / 4,
                height: MediaQuery.of(context).size.height / 4,
                child: ClipOval(
                  child: Image.asset(
                    'assets/logo.png',
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
