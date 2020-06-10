import 'package:flutter/material.dart';
import 'package:lahu/Services/auth.dart';
import 'package:lahu/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:lahu/Pages/lahu_list.dart';
import 'package:lahu/Models/lahu_data_class.dart';
import 'package:lahu/Pages/filter_form.dart';
import 'package:lahu/Pages/ask_data.dart';
import 'package:lahu/Pages/filter_page.dart';

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
    void _showFilterPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 500,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: FilterForm(),
          );
        },
      );
    }

    // void _showAskDataPanel() {
    //   showModalBottomSheet(
    //       context: context,
    //       builder: (context) {
    //         return Container(
    //           padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
    //           child: SettingsForm(),
    //         );
    //       });
    // }

    return StreamProvider<List<LahuDataObject>>.value(
      value: DatabaseService().lahuData,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          // resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(
                    icon: Icon(
                  Icons.search,
                )),
                Tab(
                    icon: Icon(
                  Icons.favorite,
                )),
              ],
            ),
            title: Text('Lahu'),
            elevation: 0.0,
            actions: <Widget>[
              // FlatButton.icon(
              //     onPressed: () => _showFilterPanel(),
              //     // onPressed: () {},
              //     icon: Icon(Icons.search),
              //     label: Text('Search')),
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text(
                  'Logout',
                ),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
          body: TabBarView(
            children: [
              LahuList(),
              FilterPage(),
              AskData(),
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
