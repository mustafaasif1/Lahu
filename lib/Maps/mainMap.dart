import 'package:flutter/material.dart';
import 'places_search_map.dart';
import 'search_filter.dart';
//import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsSampleApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoogleMapSampleApp();
  }
}

class _GoogleMapSampleApp extends State<GoogleMapsSampleApp> {
  //var currentLocation = LocationData;
  var cameraLocation = LatLng(24.87, 67.03);
  static String keyword = "Blood Bank";

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    var currentLocation = await Geolocator().getCurrentPosition();
    setState(() {
      cameraLocation =
          LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    // print(cameraLocation.longitude);
    // print('Helooooooooooooooooooooooooooooooooo');
  }

  void updateKeyWord(String newKeyword) {
    print(newKeyword);
    setState(() {
      keyword = newKeyword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Banks'),
        actions: <Widget>[
          // FlatButton.icon(
          //   onPressed: () {
          //     //searchNearby(latitude, longitude);
          //   },
          //   // onPressed: () {},
          //   icon: Icon(
          //     Icons.location_on,
          //     color: Colors.white,
          //   ),
          //   label: Text(
          //     'Search',
          //     style: TextStyle(
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: Icon(Icons.filter_list),
                  tooltip: 'Filter Search',
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  });
            },
          ),
        ],
      ),
      body: PlacesSearchMapSample(keyword),
      endDrawer: SearchFilter(updateKeyWord),
    );
  }
}
