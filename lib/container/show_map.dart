import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMap extends StatefulWidget {
  @override
  _ShowMapState createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  //field
  static LatLng gloCenter = LatLng(13.880496, 100.504845);
  CameraPosition cameraPosition = CameraPosition(
    target: gloCenter,
    zoom: 16.0,
  );

  //method

  Marker gloMaker() {
    return Marker(
      infoWindow: InfoWindow(
        title: 'สำนักงานสลากกินแบ่งรัฐบาล',
        snippet: '235 ถ.สนามบินน้ำ จ.นนทบุรี',
      ),
      markerId: MarkerId('glo'),
      position: gloCenter,
    );
  }

  Set<Marker> setMarker() {
    return <Marker>[
      gloMaker(),
    ].toSet();
  }

  Widget showGoogleMap() {
    return GoogleMap(
      markers: setMarker(),
      initialCameraPosition: cameraPosition,
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController controller) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return showGoogleMap();
  }
}
