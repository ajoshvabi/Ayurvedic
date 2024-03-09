import 'package:ayurvedic/presentation/pages/splash.dart';
import 'package:flutter/material.dart';

// import 'pages/welcome.dart';

void main() => runApp(const Ayurvedic());

class Ayurvedic extends StatelessWidget {
  const Ayurvedic({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
