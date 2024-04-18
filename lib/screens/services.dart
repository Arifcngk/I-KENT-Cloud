import 'package:e_belediyecilik/misc/colors.dart';
import 'package:e_belediyecilik/screens/services_pages/clean_city.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
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
                  title: Text('Hizmetlerim',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white)),
                  trailing: const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: Icon(
                      CupertinoIcons.person_2_alt, // İkonunuzu buraya ekleyin
                      size: 40, // İkon boyutunu istediğiniz gibi ayarlayın
                      color: Colors
                          .orange, // İkon rengini istediğiniz gibi ayarlayın
                    ),
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
                  itemDashboard('Temiz Şehir', CupertinoIcons.archivebox_fill,
                      Colors.green, CleanCityScreen()),
                  itemDashboard('Yol Çalışması', CupertinoIcons.ear,
                      Colors.black, CleanCityScreen()),
                  itemDashboard('Patili Dostlarımız', CupertinoIcons.map,
                      Colors.purple, CleanCityScreen()),
                  itemDashboard('İhbar Blok', CupertinoIcons.chat_bubble_2,
                      Colors.brown, CleanCityScreen()),
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
          Widget servicesPages) =>
      GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => servicesPages,
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
