import 'dart:developer';

import 'package:e_belediyecilik/screens/services_pages/services.dart';
import 'package:e_belediyecilik/services/image_api_cloud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';

class RoadNoticeScreen extends StatefulWidget {
  const RoadNoticeScreen({Key? key}) : super(key: key);

  @override
  State<RoadNoticeScreen> createState() => _RoadNoticeScreenState();
}

class _RoadNoticeScreenState extends State<RoadNoticeScreen> {
  File? _image;
  Uint8List? _imageBytes;
  final picker = ImagePicker();
  String? _imageName;
  CloudApi? api;
  bool isUploaded = false;
  bool loading = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/credentials.json').then((json) {
      api = CloudApi(json);
    });
  }

  void _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      print(pickedFile.path);
      setState(() {
        _image = File(pickedFile.path);
      });
      _imageBytes = await _image!.readAsBytes();
      _imageName = _image!.path.split('/').last;
    } else {
      print('No image selected.');
    }
  }

  void _saveImage() async {
    setState(() {
      loading = true;
    });
    // Upload to Google cloud
    final response = await api!.save(
      _imageName!,
      _imageBytes!,
    );
    print(response.downloadLink);
    setState(() {
      loading = false;
      isUploaded = true;
    });
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
          'Yol İhbarı',
          style: TextStyle(color: Colors.black), // Başlık metni rengi siyah
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _getImage,
              child: Container(
                height: 400, // Belirli bir yükseklik ayarlayın
                color: Colors.grey[300], // Dilediğiniz arka plan rengi
                child: _imageBytes == null
                    ? const Icon(Icons.camera_alt,
                        size: 50, color: Colors.black) // Kamera simgesi
                    : Image.memory(_imageBytes!, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 20), // Boşluk ekledik
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Başlık',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Açıklama',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 20), // Boşluk ekledik
            if (loading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (isUploaded)
              const Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              )
            else
              ElevatedButton(
                onPressed: _saveImage,
                child: const Text('Gönder'),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'Select image',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
