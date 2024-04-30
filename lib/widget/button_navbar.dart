import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_belediyecilik/misc/colors.dart';
import 'package:e_belediyecilik/screens/favorite_page.dart';
import 'package:e_belediyecilik/screens/home_page.dart';
import 'package:e_belediyecilik/screens/setting_page.dart';
import 'package:flutter/material.dart';

class ButtonNavbarWidget extends StatefulWidget {
  const ButtonNavbarWidget({Key? key});

  @override
  State<ButtonNavbarWidget> createState() => _ButtonNavbarWidgetState();
}

class _ButtonNavbarWidgetState extends State<ButtonNavbarWidget> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.blueColor, // Arka plan rengini mavi olarak ayarladık
      body: _getPage(_pageIndex),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.blueColor,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        items: const [
          Icon(Icons.home),
          Icon(Icons.favorite),
          Icon(Icons.settings),
        ],
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const FavoriteScreen();
      case 2:
        return SettingsScreen();
      default:
        return Container();
    }
  }
}
