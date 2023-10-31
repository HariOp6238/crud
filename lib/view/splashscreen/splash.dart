import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:crud/view/homescreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 8))
        .then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            )));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/logo2.jpg"),
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill)),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                  height: 80,
                ),
                const Text(
                  "Be",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
                const SizedBox(
                  width: 20,
                  height: 80,
                ),
                DefaultTextStyle(
                    style: GoogleFonts.audiowide(
                      fontSize: 30,
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      pause: const Duration(milliseconds: 0),
                      stopPauseOnTap: true,
                      animatedTexts: [
                        RotateAnimatedText("ORIGINAL"),
                        RotateAnimatedText("OPTIMESTIC"),
                        RotateAnimatedText("DIFFERNT"),
                        RotateAnimatedText("UNIQUE"),
                      ],
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ));
                      },
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
