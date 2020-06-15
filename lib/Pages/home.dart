import 'package:flutter/material.dart';
import 'package:lahu/Services/auth.dart';
import 'package:lahu/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:lahu/Models/lahu_data_class.dart';
import 'package:lahu/Pages/ask_data.dart';
import 'package:lahu/Pages/filter_page.dart';
import 'package:lahu/Pages/all_recovered.dart';

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
    // void _showFilterPanel() {
    //   showModalBottomSheet(
    //     context: context,
    //     builder: (context) {
    //       return Container(
    //         height: 500,
    //         padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
    //         child: FilterForm(),
    //       );
    //     },
    //   );
    // }

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

    // TabController _tabController;

    // void initState() {
    //   super.initState();
    //   _tabController = TabController(vsync: this, length: 3);
    // }

    // @override
    // void dispose() {
    //   _tabController.dispose();
    //   super.dispose();
    // }

    // int _selectedIndex = 0;

    // _onItemTapped(int index) {
    //   setState(() {
    //     _selectedIndex = index;
    //     print(_selectedIndex);
    //     print(_tabController);
    //   });
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
              //currentIndex: _selectedIndex,
            ),
            title: Text(
              'Lahu',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0.0,
            actions: <Widget>[
              // FlatButton.icon(
              //     onPressed: () => {},
              //     // onPressed: () {},
              //     icon: Icon(
              //       Icons.local_post_office,
              //       color: Colors.white,
              //     ),
              //     label: Text(
              //       'My Posts',
              //       style: TextStyle(
              //         color: Colors.white,
              //       ),
              //     )),
              FlatButton.icon(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
          body: TabBarView(
            children: [
              AllRecovered(),
              FilterPage(),
              AskData(),
            ],
          ),
        ),
      ),
    );
  }
}
