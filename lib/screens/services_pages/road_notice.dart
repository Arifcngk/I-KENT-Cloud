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
    final response = await api!.save(_imageName!, _imageBytes!);
    print(response.downloadLink);
    setState(() {
      loading = false;
      isUploaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _imageBytes == null
              ? Text('No image selected.')
              : Stack(
                  children: [
                    Image.memory(_imageBytes!),
                    if (loading)
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    isUploaded
                        ? Center(
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
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: _saveImage,
                              child: Text('Save to cloud'),
                            ),
                          )
                  ],
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'Select image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
