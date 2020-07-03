import 'package:flutter/material.dart';
import 'package:lahu/Chats/chatHomepage.dart';
import 'package:lahu/Helper/constants.dart';
import 'package:lahu/Helper/helper_functions.dart';
import 'package:lahu/Pages/blood_banks.dart';
import 'package:lahu/Pages/my_posts.dart';
import 'package:lahu/Pages/requests_near_you.dart';
import 'package:lahu/Services/auth.dart';
import 'package:lahu/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:lahu/Models/lahu_data_class.dart';
import 'package:lahu/Pages/ask_data.dart';
import 'package:lahu/Pages/filter_page.dart';
import 'package:lahu/Pages/all_blood_requests.dart';

class Home extends StatefulWidget {
  // const Home({Key key, @required this.user}) : super(key: key);
  // final FirebaseUser user;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
  }

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

    Widget _createHeader() {
      return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: CircleAvatar(
            radius: 70.0,
            backgroundImage: AssetImage('assets/LahuLogo.jpg'),
            backgroundColor: Colors.white,
          ),
        ),
      );
    }

    // Widget _createDrawerItem(
    //     {IconData icon, String text, GestureTapCallback onTap}) {
    //   return ListTile(
    //     title: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Row(
    //         children: <Widget>[
    //           Icon(icon),
    //           Padding(
    //             padding: EdgeInsets.only(left: 16.0),
    //             child: Text(text),
    //           )
    //         ],
    //       ),
    //     ),
    //     onTap: () {},
    //   );
    // }

    return StreamProvider<List<LahuRequestObject>>.value(
      value: DatabaseService().requestData,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors
                  .white, //This will change the drawer background to blue.
              //other styles
            ),
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  _createHeader(),
                  // _createDrawerItem(
                  //   icon: Icons.local_post_office,
                  //   text: 'My Posts',
                  // ),

                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.local_post_office,
                            color: Colors.red[800],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              'My Posts',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyPosts()),
                      )
                    },
                  ),
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.comment,
                            color: Colors.red[800],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Chat Room',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatHomePage()),
                      );
                    },
                  ),
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.notifications,
                            color: Colors.red[800],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Requests Near You',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RequestsNearYouPage()),
                      );
                    },
                  ),
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.domain,
                            color: Colors.red[800],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Blood Banks',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BloodBanks()),
                      );
                    },
                  ),

                  // ListTile(
                  //   title: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Row(
                  //       children: <Widget>[
                  //         Icon(
                  //           Icons.public,
                  //           color: Colors.red[800],
                  //         ),
                  //         Padding(
                  //           padding: EdgeInsets.only(left: 16.0),
                  //           child: Text(
                  //             'Tips',
                  //             style: TextStyle(fontSize: 16),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  //   onTap: () {},
                  // ),
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.input,
                            color: Colors.red[800],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Logout',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () async {
                      await _auth.signOut();
                    },
                  ),
                  // _createDrawerItem(
                  //   icon: Icons.input,
                  //   text: 'Logout',
                  // ),
                ],
              ),
            ),
          ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  iconSize: 25,
                  icon: Icon(Icons.info_outline),
                  tooltip: 'Information',
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
                            padding: EdgeInsets.symmetric(
                                vertical: 35.0, horizontal: 20.0),
                            child: ListView(
                              children: <Widget>[
                                Center(
                                    child: Text(
                                  'Blood Compatibility',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                )),
                                SizedBox(height: 10),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columns: const <DataColumn>[
                                      DataColumn(
                                        label: Text(
                                          'Blood Group',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Donate To',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Accept From',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ],
                                    rows: const <DataRow>[
                                      DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text('A+')),
                                          DataCell(Text('A+, AB+')),
                                          DataCell(Text('A+, A-, O+, O-')),
                                        ],
                                      ),
                                      DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text('A-')),
                                          DataCell(Text('A+, A-, AB+, AB-')),
                                          DataCell(Text('A-, O-')),
                                        ],
                                      ),
                                      DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text('B+')),
                                          DataCell(Text('B+, AB+')),
                                          DataCell(Text('B+, B-, O+, O-')),
                                        ],
                                      ),
                                      DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text('B-')),
                                          DataCell(Text('B+, B-, AB+, AB-')),
                                          DataCell(Text('B-, O-')),
                                        ],
                                      ),
                                      DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text('AB+')),
                                          DataCell(Text('AB+')),
                                          DataCell(Text('Anyone')),
                                        ],
                                      ),
                                      DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text('AB-')),
                                          DataCell(Text('AB+, AB-')),
                                          DataCell(Text('AB-, A-, B-, O-')),
                                        ],
                                      ),
                                      DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text('O+')),
                                          DataCell(Text('A+, B+, O+, AB+')),
                                          DataCell(Text('O+, O-')),
                                        ],
                                      ),
                                      DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text('O-')),
                                          DataCell(Text('Anyone')),
                                          DataCell(Text('O-')),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                ),
              ),

              // FlatButton.icon(
              //     onPressed: () => {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(builder: (context) => MyPosts()),
              //           )
              //         },
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
              // FlatButton.icon(
              //   icon: Icon(
              //     Icons.input,
              //     color: Colors.white,
              //   ),
              //   label: Text(
              //     'Logout',
              //     style: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              //   onPressed: () async {
              //     await _auth.signOut();
              //   },
              // ),
            ],
          ),
          body: TabBarView(
            children: [
              AllBloodRequests(),
              FilterPage(),
              AskData(),
            ],
          ),
        ),
      ),
    );
  }
}
