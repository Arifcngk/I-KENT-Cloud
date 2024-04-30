import 'package:e_belediyecilik/screens/services_pages/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MolozBildirimScreen extends StatefulWidget {
  const MolozBildirimScreen({super.key});

  @override
  State<MolozBildirimScreen> createState() => _MolozBildirimScreenState();
}

class _MolozBildirimScreenState extends State<MolozBildirimScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // AppBar arka plan rengi beyaz
        elevation: 0, // Gölgelendirme kaldırıldı
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const ServicesScreen())); // Önceki sayfaya dönme işlevi
          },
          icon:
              const Icon(Icons.arrow_back, color: Colors.black), // Geri butonu
        ),
        title: const Text(
          'Gebze Moloz Bildirimi',
          style: TextStyle(color: Colors.black), // Başlık metni rengi siyah
        ),
        centerTitle: true,
      ),
      body: Text('Moloz Bildirimi'),
    );
  }
}
