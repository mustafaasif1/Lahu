import 'dart:convert';
import 'data/error.dart';
import 'data/place_response.dart';
import 'data/result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class PlacesSearchMapSample extends StatefulWidget {
  final String keyword;
  PlacesSearchMapSample(this.keyword);

  @override
  State<PlacesSearchMapSample> createState() {
    return _PlacesSearchMapSample();
  }
}

class _PlacesSearchMapSample extends State<PlacesSearchMapSample> {
  static const String _API_KEY = 'AIzaSyDINE9o8FKPGlQO4ICYofztw_cJf98y9P0';
  static double latitude = 30.3753;
  static double longitude = 69.3451;
  static const String baseUrl =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json";

  List<Marker> markers = <Marker>[];
  Error error;
  List<Result> places;
  bool searching = true;
  String keyword;

  GoogleMapController mapController;

  var location = new Location();

  Future firstLocation() async {
    await location.getLocation().then((LocationData locationData) {
      //Sets the changing location in the Map Controller
      LatLng latLng = new LatLng(locationData.latitude, locationData.longitude);
      CameraUpdate cameraUpdate = CameraUpdate.newLatLngZoom(latLng, 15);
      mapController.animateCamera(cameraUpdate);
    });
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  void initState() {
    super.initState();
    firstLocation();
  }

  static final CameraPosition _myLocation = CameraPosition(
      target: LatLng(latitude, longitude), zoom: 6, bearing: 15.0, tilt: 75.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _myLocation,
            onMapCreated: _onMapCreated,
            markers: Set<Marker>.of(markers),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 80),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.red[800],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Search Places!", style: TextStyle(fontSize: 20)),
                ),
                onPressed: () {
                  searchNearby(latitude, longitude);
                },
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                elevation: 1,
              ),
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     searchNearby(latitude, longitude);
      //   },
      //   label: Text('Places Nearby'),
      //   icon: Icon(Icons.place),
      // ),
    );
  }

  void searchNearby(double latitude, double longitude) async {
    var currentLocation = await Geolocator().getCurrentPosition();

    setState(() {
      markers.clear();
    });

    String url =
        '$baseUrl?key=$_API_KEY&location=${currentLocation.latitude},${currentLocation.longitude}&radius=100000&keyword=${widget.keyword}';
    print(url);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _handleResponse(data);
    } else {
      throw Exception('An error occurred getting places nearby');
    }

    // make sure to hide searching
    setState(() {
      searching = false;
    });
  }

  void _handleResponse(data) {
    // bad api key or otherwise
    if (data['status'] == "REQUEST_DENIED") {
      setState(() {
        error = Error.fromJson(data);
      });
      // success
    } else if (data['status'] == "OK") {
      setState(() {
        places = PlaceResponse.parseResults(data['results']);
        for (int i = 0; i < places.length; i++) {
          markers.add(
            Marker(
              markerId: MarkerId(places[i].placeId),
              position: LatLng(places[i].geometry.location.lat,
                  places[i].geometry.location.long),
              infoWindow: InfoWindow(
                  title: places[i].name, snippet: places[i].vicinity),
              // onTap: () {
              //   print('hi');
              // },
            ),
          );
        }
      });
    } else {
      print(data);
    }
  }
}
