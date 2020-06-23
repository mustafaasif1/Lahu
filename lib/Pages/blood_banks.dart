import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lahu/Maps/mainMap.dart';
//import 'package:lahu/Maps/places_search_map.dart';
import 'package:location/location.dart';

class BloodBanks extends StatefulWidget {
  @override
  _BloodBanksState createState() => _BloodBanksState();
}

class _BloodBanksState extends State<BloodBanks> {
  GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  var currentLocation = LocationData;
  var cameraLocation = LatLng(24.87, 67.03);

  // void _onMapCreated(GoogleMapController controller) {
  //   setState(() {
  //     mapController = controller;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getLocation);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMapsSampleApp();

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Blood Banks'),
    //     actions: <Widget>[
    //       FlatButton.icon(
    //           onPressed: _getLocation,
    //           // onPressed: () {},
    //           icon: Icon(
    //             Icons.location_on,
    //             color: Colors.white,
    //           ),
    //           label: Text(
    //             'My Location',
    //             style: TextStyle(
    //               color: Colors.white,
    //             ),
    //           )),
    //     ],
    //   ),
    //   body: GoogleMap(
    //     initialCameraPosition: CameraPosition(target: cameraLocation, zoom: 11),
    //     onMapCreated: _onMapCreated,
    //     myLocationEnabled:
    //         true, // Add little blue dot for device location, requires permission from user
    //     markers: _markers.values.toSet(),
    //   ),
    // );
  }

  void _getLocation() async {
    var currentLocation = await Geolocator().getCurrentPosition();

    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;

      cameraLocation =
          LatLng(currentLocation.latitude, currentLocation.longitude);
    });
  }
}
