import 'dart:io';

import 'package:e_belediyecilik/misc/colors.dart';
import 'package:e_belediyecilik/screens/services_pages/clean_city_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CleanCityScreen extends StatefulWidget {
  const CleanCityScreen({Key? key}) : super(key: key);

  @override
  State<CleanCityScreen> createState() => _CleanCityScreenState();
}

class _CleanCityScreenState extends State<CleanCityScreen> {
  int currentStep = 0;
  List<Map<String, String>> collectedInformation = [];
  late ImagePicker _imagePicker;

  late TextEditingController ihbarBasligiController;
  late TextEditingController ihbarIcerikController;
  late TextEditingController copKonteynirIdController;
  late TextEditingController ihbarAdressController;

  @override
  void initState() {
    super.initState();
    ihbarBasligiController = TextEditingController();
    ihbarIcerikController = TextEditingController();
    ihbarAdressController = TextEditingController();
    copKonteynirIdController = TextEditingController();
    _imagePicker = ImagePicker();
  }

  @override
  void dispose() {
    ihbarBasligiController.dispose();
    ihbarIcerikController.dispose();
    copKonteynirIdController.dispose();
    ihbarAdressController.dispose();
    super.dispose();
  }

  //Resimleri alma fonksiyonu
  XFile? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      Step(
        title: Text(
          'İhbar Başlığı',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: TextFormField(
          controller: ihbarBasligiController,
          decoration: InputDecoration(labelText: 'İhbar Başlığını Giriniz'),
        ),
      ),
      Step(
        title: Text('İhbar İçeriği',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: TextFormField(
          controller: ihbarIcerikController,
          decoration: InputDecoration(labelText: 'İhbar İçeriği'),
        ),
      ),
      Step(
        title:
            Text('İhbar Adresi', style: TextStyle(fontWeight: FontWeight.bold)),
        content: TextFormField(
          controller: ihbarIcerikController,
          decoration: InputDecoration(labelText: 'İhbar Adresi'),
        ),
      ),
      Step(
        title: Text('Fotoğraf', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _pickImage(ImageSource.gallery); // Galeriden fotoğraf seçme
              },
              child: Text('Galeriden Fotoğraf Seç'),
            ),
            ElevatedButton(
              onPressed: () {
                _pickImage(ImageSource.camera); // Kameradan fotoğraf çekme
              },
              child: Text('Kameradan Fotoğraf Çek'),
            ),
            if (_imageFile != null)
              Image.file(
                File(_imageFile!.path),
                height: 200,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
      Step(
        title: Text('Çöp Konteynır ID',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: TextFormField(
          controller: copKonteynirIdController,
          decoration: InputDecoration(labelText: 'Çöp Konteynır ID'),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.blueColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 30,
                right: 30,
                left: 30,
                top: 50,
              ),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Temiz Şehir İhbarı",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                      height:
                          20), // Başlık ile içerik arasına boşluk eklemek için
                  Text(
                    "İçerik metni buraya gelecek.",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 30,
                right: 30,
                left: 30,
                top:
                    20, // Önceki container ile arasındaki boşluğu azaltmak için değeri düşürdüm
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stepper(
                steps: steps,
                currentStep: currentStep,
                onStepContinue: () {
                  setState(() {
                    if (currentStep == 0) {
                      collectedInformation.add({
                        'İhbar Başlığı': ihbarBasligiController.text,
                      });
                    } else if (currentStep == 1) {
                      collectedInformation.add({
                        'İhbar İçeriği': ihbarIcerikController.text,
                      });
                    } else if (currentStep == 2) {
                      collectedInformation.add({
                        'İhbar Adresi': ihbarAdressController.text,
                      });
                    } else if (currentStep == 4) {
                      collectedInformation.add({
                        'Çöp Konteynır ID': copKonteynirIdController.text,
                      });
                    }
                    currentStep < steps.length - 1 ? currentStep += 1 : null;
                  });
                },
                onStepCancel: () {
                  setState(() {
                    currentStep > 0 ? currentStep -= 1 : null;
                  });
                },
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CollectedInformationScreen(
                          collectedInformation: collectedInformation),
                    ),
                  );
                },
                child: Text("Bilgileri Gönder"))
          ],
        ),
      ),
    );
  }
}
