import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:e_belediyecilik/misc/eczane_card.dart';
import 'package:e_belediyecilik/screens/services_pages/services.dart';
import 'package:e_belediyecilik/services/ezcane_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SentiusEczaneScreen extends StatefulWidget {
  const SentiusEczaneScreen({super.key});

  @override
  State<SentiusEczaneScreen> createState() => _SentiusEczaneScreenState();
}

class _SentiusEczaneScreenState extends State<SentiusEczaneScreen> {
  late Future<Eczane> futureEczane;
  Future<Eczane> fetchEczane() async {
    final response = await http.get(
      Uri.parse(
          'https://api.collectapi.com/health/dutyPharmacy?ilce=Gebze&il=Kocaeli'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            'apikey 0yBj127jPIIotjUmgSxfIq:3Q3V3hCKrzRUbjF2Hgf7Ai',
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      print("response.body: ${response.body}");
      // then parse the JSON.
      return Eczane.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futureEczane = fetchEczane(); // futureEczane'i başlatın
  }

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
          'Gebze Nöbetçi Eczaneleri',
          style: TextStyle(color: Colors.black), // Başlık metni rengi siyah
        ),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<Eczane>(
          future: futureEczane,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.result!.length,
                itemBuilder: (context, index) {
                  return EczaneCard(eczane: snapshot.data!.result![index]);
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
