import 'package:e_belediyecilik/misc/colors.dart';
import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ), // Metnin boşluk değeri
              const Text(
                "Hep Birlikte ! ",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Daha Güzel Günlere",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.8,
                child: Image.asset("img/intro_page3.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
