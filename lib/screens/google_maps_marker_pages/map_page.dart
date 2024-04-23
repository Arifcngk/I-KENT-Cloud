import 'dart:async';
import 'dart:typed_data';
import 'package:e_belediyecilik/misc/colors.dart';
import 'package:e_belediyecilik/screens/google_maps_marker_pages/map_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => GoogleMapViewState();
}

class GoogleMapViewState extends State<GoogleMapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.803191, 29.3866817),
    zoom: 14,
  );

  BitmapDescriptor petsIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    _getCustomMarker();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void _getCustomMarker() async {
    final Uint8List _petsIcon = await getBytesFromAsset("img/pets.png", 100);
    petsIcon = BitmapDescriptor.fromBytes(_petsIcon);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<Marker> markers = [
      // ulus mah lat-log
      createMarker("ulus1", ulusPets1, petsIcon, "ulus mah. "),
      createMarker("ulus2", ulusPets2, petsIcon, "ulus mah. "),
      createMarker("ulus3", ulusPets3, petsIcon, "ulus mah. "),
      //  beylikbağı mah lat-log
      createMarker("beylikbağı1", beylikbagPets1, petsIcon, "beylikbağı mah."),
      createMarker("beylikbağı2", beylikbagPets2, petsIcon, "beylikbağı mah."),
      createMarker("beylikbağı3", beylikbagPets3, petsIcon, "beylikbağı mah."),
      // arapçeşe mah lat-log
      createMarker("arapçeşme1", arapCesmePets1, petsIcon, "arapçeşme"),
      createMarker("arapçeşme2", arapCesmePets2, petsIcon, "arapçeşme"),
      // mevlana mah lat-long
      createMarker("mevlana1", mevlanaPets1, petsIcon, "arapçeşme"),
      createMarker("mevlana2", mevlanaPets2, petsIcon, "arapçeşme"),
      // sekerpınar mah lat-long
      createMarker("sekerpinar1", sekerpinarPets1, petsIcon, "arapçeşme"),
      createMarker("sekerpinar2", sekerpinarPets2, petsIcon, "arapçeşme"),
      // diğer besleme alanları
      createMarker("diğer1", sekerpinarPets1, petsIcon, "arapçeşme"),
      createMarker("diğer2", sekerpinarPets2, petsIcon, "arapçeşme"),
    ];

    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) async {
            _controller.complete(controller);
          },
          markers: markers.toSet(),
          myLocationEnabled: true, // Kullanıcı konumunu göstermek için
          myLocationButtonEnabled:
              true, // Kullanıcının konumunu otomatik olarak güncellemek için
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 15,
            child: SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildNeighborhoodButton("Ulus Mah.", ulus),
                  _buildNeighborhoodButton("Beylikbağ Mah.", beylikbag),
                  _buildNeighborhoodButton("Arapçeşme Mah.", arapcesme),
                  _buildNeighborhoodButton("Mevlana Mah.", mevlana),
                  _buildNeighborhoodButton("Şekerpınar Mah.", arapcesme),
                ],
              ),
            ))
      ],
    ));
  }

  Widget _buildNeighborhoodButton(
      String neighborhoodName, CameraPosition position) {
    return GestureDetector(
      onTap: () {
        _moveToNeighborhood(position);
      },
      child: Container(
        width: 120,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: AppColors.blueColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          neighborhoodName,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _moveToNeighborhood(CameraPosition position) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  Marker createMarker(
      String id, LatLng position, BitmapDescriptor icon, String title) {
    return Marker(
      markerId: MarkerId(id),
      position: position,
      icon: icon,
      infoWindow: InfoWindow(title: title),
    );
  }
}
