import 'package:flutter/material.dart';
import 'package:lahu/Pages/my_post_tiles.dart';
import 'package:provider/provider.dart';
import 'package:lahu/Models/lahu_data_class.dart';

class MyPostsInside extends StatefulWidget {
  @override
  _MyPostsInsideState createState() => _MyPostsInsideState();
}

class _MyPostsInsideState extends State<MyPostsInside> {
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
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: Column(
              //     children: <Widget>[
              //       Text(
              //         'All Blood Donation Requests',
              //         style: TextStyle(
              //           fontSize: 25,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       SizedBox(height: 20.0),
              //     ],
              //   ),
              // ),
              lahuData.isEmpty
                  ? Center(child: Text('You do have have any posts '))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: lahuData.length,
                        itemBuilder: (context, index) {
                          return MyPostTiles(lahuObject: lahuData[index]);
                        },
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
