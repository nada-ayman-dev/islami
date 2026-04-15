import 'package:flutter/material.dart';
import 'package:islami/Radio/radio_view.dart';
import 'package:islami/hadeth/hadeth_view.dart';
import 'package:islami/quran/quran_view.dart';
import 'package:islami/sebha/sebha_view.dart';
import '../core/widgets/app_navigation.dart';
//import 'package:islami/core/constants/app_images.dart';
//import 'package:islami/core/widgets/app_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    QuranView(),
    HadethView(),
    SebhaView(),
    RadioView(),
    const Center(child: Text('Time')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // 👈 الحل هنا
      child: SafeArea(
        child: Column(
          children: [
            Expanded(child: _screens[_selectedIndex]),

            AppNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ],
        ),
      ),
    );
  }
}
