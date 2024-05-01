import 'package:e_belediyecilik/misc/colors.dart';
import 'package:e_belediyecilik/screens/google_maps_marker_pages/map_page.dart';
import 'package:e_belediyecilik/screens/moloz_bildir.dart';
import 'package:e_belediyecilik/screens/post_form_page.dart';
import 'package:e_belediyecilik/screens/services_pages/clean_city.dart';
import 'package:e_belediyecilik/screens/services_pages/road_notice.dart';
import 'package:e_belediyecilik/screens/services_pages/sentius_eczane.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  List<bool> isFavorite = List.generate(9, (index) => false);

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
                  title: Text('Hizmetler',
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
                  itemDashboard(' Yol İhbar   \n   Bildirimi', "img/path.png",
                      const RoadNoticeScreen(), 0),
                  itemDashboard('Çevre temizlik \n     Bildirimi',
                      "img/trash.png", const PostFormScreen(), 1),
                  itemDashboard('Evde Bakım', "img/patient.png",
                      const CleanCityScreen(), 2),
                  itemDashboard('Patili Dotlarımız', "img/pets.png",
                      const GoogleMapView(), 3),
                  itemDashboard('İş Yeri Ruhsat \n Sorgulama', "img/shop.png",
                      const CleanCityScreen(), 4),
                  itemDashboard('Nöbetçi Eczane', "img/eczane.png",
                      const SentiusEczaneScreen(), 5),
                  itemDashboard(' Bilgi Talebi', "img/support.png",
                      const CleanCityScreen(), 6),
                  itemDashboard('Arsa e-Beyanı \n Bildirimi', "img/lanf.png",
                      const CleanCityScreen(), 7),
                  itemDashboard('Moloz \n Bildirimi', "img/rubble.png",
                      const MolozBildirimScreen(), 8),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  itemDashboard(
          String title, String imagePath, Widget servicesPages, int index) =>
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
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      imagePath,
                      width: 60,
                      height: 60,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(title.toUpperCase(),
                        style: Theme.of(context).textTheme.titleMedium),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isFavorite[index] = !isFavorite[index];
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    isFavorite[index] ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite[index] ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
