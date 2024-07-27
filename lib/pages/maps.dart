import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SearchWithMap extends StatefulWidget {
  const SearchWithMap({super.key});

  @override
  State<SearchWithMap> createState() => _SearchWithMapState();
}

//AIzaSyBxg7DeKtn1o_V4VKWtE7BprIw9d-KLMnA
//AIzaSyAjPVTxvUFaLNyXuXbB9Mor2z1edNbCwkg

/* Pour trouver la clé API google maps, voici le lien de la video youtube :
  https://www.youtube.com/watch?v=xwJVkaCkNws */
class _SearchWithMapState extends State<SearchWithMap> {
  Completer<GoogleMapController> _controller = Completer();
  bool showMarkers = false;
  LocationData? currentLocation;
  late GoogleMapController controller2;

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
        print(currentLocation!.altitude);
        print(currentLocation!.longitude);
      });
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: currentLocation == null
          ? Center(
              child: CircularProgressIndicator()
            )
          : GoogleMap(
              zoomControlsEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: /* _myLocation */
                  CameraPosition(
                      zoom: 18,
                      target: LatLng(currentLocation!.latitude!,
                          currentLocation!.longitude!)),
              mapType: MapType.hybrid,
              onMapCreated: (GoogleMapController controller) async {
                controller2 = controller;
                _controller.complete(controller);
                controller2.showMarkerInfoWindow(MarkerId('22'));
                controller.showMarkerInfoWindow(MarkerId('2'));
                for (int i = 0; i < 22; i++) {
                  controller.showMarkerInfoWindow(MarkerId('$i'));
                }
              },
            ),
    );
  }
}
