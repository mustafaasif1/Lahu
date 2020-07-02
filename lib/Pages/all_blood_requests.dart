import 'package:flutter/material.dart';
import 'package:lahu/Pages/request_donation.dart';
import 'package:provider/provider.dart';
import 'package:lahu/Models/lahu_data_class.dart';
import 'package:lahu/Pages/lahu_tile.dart';

class AllBloodRequests extends StatefulWidget {
  @override
  _AllBloodRequestsState createState() => _AllBloodRequestsState();
}

class _AllBloodRequestsState extends State<AllBloodRequests> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final lahuData = Provider.of<List<LahuRequestObject>>(context) ?? [];

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'All Blood Donation Requests',
                        style: TextStyle(
                          fontSize: 22,
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
        ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 3,
          onPressed: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    padding:
                        EdgeInsets.symmetric(vertical: 35.0, horizontal: 40.0),
                    child: RequestDonation(),
                  );
                });
          },
          label: Text(
            'Request Donation',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          // icon: Icon(Icons.add),
          backgroundColor: Colors.red[800],
        ));
  }
}
