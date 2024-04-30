import 'package:e_belediyecilik/misc/colors.dart';
import 'package:flutter/material.dart';
import 'package:e_belediyecilik/services/ezcane_api.dart'; // Eczane sınıfı ve diğer ilgili sınıfların olduğu dosyanın yolu

class EczaneCard extends StatelessWidget {
  final Result eczane;

  const EczaneCard({Key? key, required this.eczane}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sol tarafta eczane ikonu
            const Image(
              image: AssetImage('img/eczane_logo.jpg'),
              width: 80,
              height: 90,
            ),
            const SizedBox(width: 16),
            // Sağ tarafta eczane bilgileri
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eczane.name ?? '',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(eczane.address ?? ''),
                  const SizedBox(height: 4),
                  Text(eczane.phone ?? ''),
                  const SizedBox(height: 4),
                  Text(eczane.dist ?? ''),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.location_on,
                          color: AppColors.blueColor), // Konum ikonu
                      const SizedBox(width: 4),
                      Text("Haritada Göster",
                          style: TextStyle(color: AppColors.blueColor)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
