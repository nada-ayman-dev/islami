import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/widgets/app_navigation.dart';
import 'package:islami/core/constants/app_images.dart';
import 'package:islami/core/widgets/app_header.dart';
import '../quran/quran_view.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _screens = [
    QuranView(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const AppHeader(),
            Expanded(
              child: _screens[_selectedIndex],
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}