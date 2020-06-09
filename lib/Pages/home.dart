import 'package:flutter/material.dart';
import 'package:lahu/Services/auth.dart';
import 'package:lahu/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:lahu/Pages/lahu_list.dart';
import 'package:lahu/Models/lahu_data_class.dart';
import 'package:lahu/Pages/settings_form.dart';

class Home extends StatefulWidget {
  // const Home({Key key, @required this.user}) : super(key: key);
  // final FirebaseUser user;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<LahuDataObject>>.value(
      value: DatabaseService().lahuData,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
              ],
            ),
            title: Text('Home '),
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
              FlatButton.icon(
                  onPressed: () => _showSettingsPanel(),
                  icon: Icon(Icons.settings),
                  label: Text('Settings'))
            ],
          ),
          body: TabBarView(
            children: [
              LahuList(),
              // Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}

// return StreamProvider<List<LahuDataObject>>.value(
//   value: DatabaseService().lahuData,
//   child: Scaffold(
//       appBar: AppBar(
//         title: Text('Home '),
//         elevation: 0.0,
//         actions: <Widget>[
//           FlatButton.icon(
//             icon: Icon(Icons.person),
//             label: Text('Logout'),
//             onPressed: () async {
//               await _auth.signOut();
//             },
//           ),
//           FlatButton.icon(
//               onPressed: () => _showSettingsPanel(),
//               icon: Icon(Icons.settings),
//               label: Text('Settings'))
//         ],
//       ),
//       body: TabBarDemo()),
// );
