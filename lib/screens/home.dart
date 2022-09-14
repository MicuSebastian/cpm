import 'package:cpm/screens/gallery.dart';
import 'package:cpm/screens/models.dart';
import 'package:cpm/screens/welcome.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../reuseWidget.dart';
import 'signin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    GalleryScreen(),
    WelcomeScreen(),
    ModelsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      backgroundColor: Colors.lightBlue.shade200,
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        backgroundColor: Colors.lightBlue.shade200,
        color: Colors.lightBlue.shade400,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          // ignore: avoid_print
          print("Index: $index");
          onTappedBar(index);
        },
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const Icon(
            Icons.cloud_upload,
            color: Colors.white,
          ),
          const Icon(
            Icons.home,
            color: Colors.white,
          ),
          const Icon(
            Icons.threed_rotation,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
