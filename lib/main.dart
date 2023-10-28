import 'dart:ui';

import 'package:crud/components/theme.dart';
import 'package:crud/components/themedata.dart';
import 'package:crud/controll/controller.dart';
import 'package:crud/view/homescreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Screencontroller(),
        ),
        ChangeNotifierProvider(
          create: (context) => Themeprovider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        theme: lightmode,
        darkTheme: darkmode,
        //theme: Provider.of<Themeprovider>(context).themedata,
      ),
    );
  }
}
