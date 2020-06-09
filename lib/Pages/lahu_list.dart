import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lahu/Models/lahu_data_class.dart';
import 'package:lahu/Pages/lahu_tile.dart';

class LahuList extends StatefulWidget {
  @override
  _LahuListState createState() => _LahuListState();
}

class _LahuListState extends State<LahuList> {
  @override
  Widget build(BuildContext context) {
    final lahuData = Provider.of<List<LahuDataObject>>(context) ?? [];

    return ListView.builder(
      itemCount: lahuData.length,
      itemBuilder: (context, index) {
        return LahuTile(lahuObject: lahuData[index]);
      },
    );
  }
}
