import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lahu/Models/lahu_data_class.dart';

import 'package:lahu/Pages/lahu_tile.dart';

class AllRecovered extends StatefulWidget {
  @override
  _AllRecoveredState createState() => _AllRecoveredState();
}

class _AllRecoveredState extends State<AllRecovered> {
  @override
  Widget build(BuildContext context) {
    final lahuData = Provider.of<List<LahuDataObject>>(context) ?? [];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'All Recovered Patients',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: lahuData.length,
                itemBuilder: (context, index) {
                  return LahuTile(lahuObject: lahuData[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
