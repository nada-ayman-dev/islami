import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../sebha/sebha_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Text(
        "Home Screen",
        style: TextStyle(color: AppColors.textPrimary),
      ),
    ),
    Center(
      child: Text(
        "Quran Screen",
        style: TextStyle(color: AppColors.textPrimary),
      ),
    ),
    SebhaScreen(),
    Center(
      child: Text(
        "Radio Screen",
        style: TextStyle(color: AppColors.textPrimary),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xFF202020).withOpacity(0.6),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Quran',
            backgroundColor: Color(0xFF202020).withOpacity(0.6),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: 'Sebha',
            backgroundColor: Color(0xFF202020).withOpacity(0.6),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.radio),
            label: 'Radio',
            backgroundColor: Color(0xFF202020).withOpacity(0.6),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        backgroundColor: AppColors.textPrimary,
        onTap: _onItemTapped,
      ),
    );
  }
}
