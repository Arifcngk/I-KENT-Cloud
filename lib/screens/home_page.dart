import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_belediyecilik/misc/colors.dart';
import 'package:e_belediyecilik/screens/favorite_page.dart';
import 'package:e_belediyecilik/screens/google_maps_marker_pages/map_page.dart';
import 'package:e_belediyecilik/screens/post_page.dart';
import 'package:e_belediyecilik/screens/services_pages/services.dart';
import 'package:e_belediyecilik/screens/setting_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? userName;

  @override
  void initState() {
    super.initState();
    // getCurrentUser(); // Google ile giriş yapılırsa kullanıcı adı alınır.
  }
//  Google ile giriş yapılırsa kullanıcı adı alınır.
  // Future<void> getCurrentUser() async {
  //   final User? user = _auth.currentUser;
  //   final DocumentSnapshot snapshot =
  //       await _firestore.collection('users').doc(user!.uid).get();
  //   setState(() {
  //     userName = snapshot['displayName'];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.blueColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text('Merhaba Kullanıcı Adı  ',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white)),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('img/user.png'),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: AppColors.blueColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard('Hizmetler', CupertinoIcons.person_2_alt,
                      Colors.orange, const ServicesScreen()),
                  itemDashboard('Engelsiz Belediye', CupertinoIcons.ear,
                      Colors.black, const ServicesScreen()),
                  itemDashboard('Patili \n Dostlarımız', CupertinoIcons.map,
                      Colors.purple, const GoogleMapView()),
                  itemDashboard('İhbar Akış', CupertinoIcons.chat_bubble_2,
                      Colors.brown, PostScreen()),
                  itemDashboard('E-İhale', CupertinoIcons.money_dollar_circle,
                      Colors.indigo, const ServicesScreen()),
                  itemDashboard('Hakkımızda', Icons.account_balance_outlined,
                      Colors.teal, const ServicesScreen()),
                  itemDashboard('Favorilerim', CupertinoIcons.heart_fill,
                      Colors.red, const FavoriteScreen()),
                  itemDashboard('Ayarlar', CupertinoIcons.settings, Colors.blue,
                      SettingScreen()),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background,
          Widget destinationPage) =>
      GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => destinationPage,
            )),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    color: Theme.of(context).primaryColor.withOpacity(.2),
                    spreadRadius: 2,
                    blurRadius: 5)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: Colors.white)),
              const SizedBox(height: 8),
              Text(title.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium)
            ],
          ),
        ),
      );
}
