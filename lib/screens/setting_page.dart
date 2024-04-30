import 'package:e_belediyecilik/misc/colors.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueColor,
      body: const Center(
        child: Text('Ayarlar içeriği'),
      ),
    );
  }
}
