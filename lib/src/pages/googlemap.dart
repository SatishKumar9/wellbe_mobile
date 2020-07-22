import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// import '../helper/error.dart';

class GooglemapPage extends StatefulWidget {
  final String keyword;
  GooglemapPage(this.keyword);

  @override
  _GooglemapPage createState() => _GooglemapPage();
}

class _GooglemapPage extends State<GooglemapPage> {
  GoogleMapController mapController;
  static const String _API_KEY = 'AIzaSyAIKkrKllWjajrA3Me6s5b0JE0XRDgfgG8';

  static double latitude = 40.7484405;
  static double longitude = -73.9878531;  
  static const String baseUrl =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json";

  List<Marker> markers = <Marker>[];
  Error error;
  // List<Result> places;
  bool searching = true;
  String keyword;

  // final LatLng center = LatLng(45.521563, -122.677433);

  LatLng _lastMapPosition = LatLng(45.521563, -122.677433);

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
        // icon: BitmapDescriptor.fromAsset(‘assets/asset_name.png)
      ));
    });
  }

  // void searchNearby(double latitude, double longitude) async {
  //   setState(() {
  //     markers.clear();
  //   });
    
  //   String url =
  //       '$baseUrl?key=$_API_KEY&location=$latitude,$longitude&radius=10000&keyword=${widget.keyword}';
  //   print(url);
    
  //   final response = await http.get(url);
    
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     _handleResponse(data);
  //   } else {
  //     throw Exception('An error occurred getting places nearby');
  //   }
  //   setState(() {
  //     searching = false; // 6
  //   });
  // }

  // void _handleResponse(data){
  //   // bad api key or otherwise
  //     if (data['status'] == "REQUEST_DENIED") {
  //       setState(() {
  //         error = Error.fromJson(data);
  //       });
  //       // success
  //     } else if (data['status'] == "OK") {
  //       setState(() {
  //         places = PlaceResponse.parseResults(data['results']);
  //         for (int i = 0; i < places.length; i++) {
  //           markers.add(
  //             Marker(
  //               markerId: MarkerId(places[i].placeId),
  //               position: LatLng(places[i].geometry.location.lat,
  //                   places[i].geometry.location.long),
  //               infoWindow: InfoWindow(
  //                   title: places[i].name, snippet: places[i].vicinity),
  //               onTap: () {},
  //             ),
  //           );
  //         }
  //       });
  //     } else {
  //       print(data);
  //     }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hospitals near Me'),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(latitude, longitude),
                zoom: 10.0,
              ),
              markers: Set<Marker>.of(markers),
              onCameraMove: _onCameraMove,
            ),
            Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  onPressed: _onAddMarkerButtonPressed,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  // backgroundColor: Colors.green,
                  child: const Icon(Icons.place, size: 20.0),
                ))
          ],
        ));
  }
}
