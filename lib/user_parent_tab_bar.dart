import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:masjiduserapp/masjit_main_new_screen.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/user_logout_responce_model.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/user_login_screen.dart';
import 'package:masjiduserapp/util/constant.dart';

import 'package:http/http.dart' as http;
import 'package:masjiduserapp/util/get_location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'masjit_user_app_api/place.dart';
import 'all_masjit_list.dart';
import 'common.color.dart';
import 'exit_app_dialog.dart';

class ParentTabBarScreen extends StatefulWidget {
  const ParentTabBarScreen({Key? key}) : super(key: key);

  @override
  _ParentTabBarScreenState createState() => _ParentTabBarScreenState();
}

class _ParentTabBarScreenState extends State<ParentTabBarScreen>
    with SingleTickerProviderStateMixin {
  bool serchIcon = true;
  late Box box;
  bool searchBar = false;
  final _searchFocus = FocusNode();
  final searchController = TextEditingController();
  final String _searchText = "";
  late TabController _tabController;
  late Future<UseLogoutResponceModel> result;
  Place? address;
  String _address = '';

  @override
  void initState() {
    box = Hive.box(kBoxName);
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                child: IconButton(
                  icon: Image.asset(
                    "assets/images/drower.png",
                    height: SizeConfig.screenHeight * 16,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              );
            },
          ),
          title: Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.0),
            child: Center(
              child: Image(
                image: const AssetImage("assets/images/appLogo.png"),
                height: SizeConfig.screenHeight * 0.04,
              ),
            ),
          ),
          actions: [
            /* IconButton(
              onPressed: () {
                Future<Place?> result = Navigator.of(context).push<Place>(
                  MaterialPageRoute(
                    builder: (context) => const GetLocation(),
                  ),
                );

                result.then((value) {
                  if (value == null) return;
                  setState(() {
                    address = value;
                    _address =
                    'Area ${address?.lat},\n City ${address?.long}, \n Postal Code ${address?.postalCode},\n State ${address?.administrativeArea}, \n Country ${address?.country}';
                    setState(() {});
                  });
                });
              },
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on_sharp),
                  Text("${address?.subLocality}")
                ],
              ),
            ),*/
            Container(
              width: SizeConfig.screenWidth * 0.4,
              // color: Colors.red,
              child: IconButton(
                onPressed: () {
                  Future<Place?> result = Navigator.of(context).push<Place>(
                    MaterialPageRoute(
                      builder: (context) => const GetLocation(comeFrom: "1",),
                    ),
                  );

                  result.then((value) {
                    if (value == null) return;

                    box.delete("currentLatitude");
                    box.delete("currentLongitude");
                    box.delete("currentsubLocality");
                    box.delete("currentLocality");

                    setState(() {
                      address = value;
                      _address =
                          'Area ${address?.lat},\n City ${address?.long}, \n Postal Code ${address?.postalCode},\n State ${address?.administrativeArea}, \n Country ${address?.country}';
                      box.put(kUserLatitude, address?.lat);
                      box.put(kUserLongitude, address?.long);
                      box.put(kUserSubLocality, address?.subLocality);
                      box.put(kUserLocality, address?.locality);
                      setState(() {});
                    });
                  });
                },
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: const Icon(Icons.location_on_sharp),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("${box.get("currentsubLocality")}"),
                        Text("${box.get("currentLocality")}"),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR]),
            ),
          ),
        ),
        body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 20),
          children: [
            SizedBox(
                height: SizeConfig.screenHeight * 0.90,
                child: getAddGameTabLayout(
                    SizeConfig.screenHeight, SizeConfig.screenWidth)),
          ],
        ),
        drawer: Padding(
          padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.04),
          child: SizedBox(
            height: SizeConfig.screenHeight * .99,
            width: SizeConfig.screenHeight * .35,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30.0),
              ),
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    SizedBox(
                      height: 180,
                      child: DrawerHeader(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                CommonColor.LEFT_COLOR,
                                CommonColor.RIGHT_COLOR
                              ])),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 40),
                                child: Image(
                                  image:
                                      AssetImage("assets/images/appLogo.png"),
                                  height: 120,
                                ),
                              ),
                            ],
                          )),
                    ),
                    /*         ListTile(
                      // leading: Icon(Icons.message),
                      title: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Notification",
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Roboto_Medium',
                              fontWeight: FontWeight.w500,
                              color: CommonColor.REGISTRARTION_COLOR),
                        ),
                      ),
                    ),*/
                    ListTile(
                      onTap: () {
                        // Navigator.push(
                        //     context, MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                        launch("http://azan4salah.com/policy.html");
                      },
                      // leading: Icon(Icons.message),
                      title: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.02),
                        child: const Text(
                          "Privacy Policy",
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Roboto_Medium',
                              fontWeight: FontWeight.w500,
                              color: CommonColor.REGISTRARTION_COLOR),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        // Navigator.push(
                        //     context, MaterialPageRoute(builder: (context) => TermsAndCondition()));
                        launch("http://azan4salah.com/terms.html");
                      },
                      // leading: Icon(Icons.message),
                      title: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.02),
                        child: const Text(
                          "Terms & Condition",
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Roboto_Medium',
                              fontWeight: FontWeight.w500,
                              color: CommonColor.REGISTRARTION_COLOR),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  title: const Center(
                                      child: Text(
                                    "Logout",
                                    style: TextStyle(
                                      color: CommonColor.REGISTRARTION_COLOR,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                      fontFamily: 'Roboto_Medium',
                                    ),
                                  )),
                                  content: Padding(
                                    padding: EdgeInsets.only(
                                        left: SizeConfig.screenWidth * 0.04),
                                    child: const Text(
                                      "Are you sure you want to log out ? You can log in anytime you want again.",
                                      style: TextStyle(
                                        color: CommonColor.BLACK,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        fontFamily: 'Roboto_Medium',
                                      ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom:
                                              SizeConfig.screenHeight * 0.03),
                                      child: Center(
                                        child: Column(
                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                getLogoutUser().then((value) {
                                                  box.delete(kToken);
                                                  //box.delete(kBoxName);
                                                  box.delete(kUserPhoneNumber);

                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const LoginScreen()),
                                                          (Route route) =>
                                                              false);

                                                  //  Navigator.popUntil(context, ModalRoute.withName (EnterMobileNumber()));
                                                  /*   Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EnterMobileNumber()));*/
                                                });
                                                //cityController.text.isEmpty ? _validate = true : _validate = false;
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left:
                                                        SizeConfig.screenWidth *
                                                            0.1,
                                                    right:
                                                        SizeConfig.screenWidth *
                                                            0.1),
                                                child: Container(
                                                    height: SizeConfig
                                                            .screenHeight *
                                                        0.05,
                                                    decoration: BoxDecoration(
                                                      gradient:
                                                          const LinearGradient(
                                                              begin: Alignment
                                                                  .centerLeft,
                                                              end: Alignment
                                                                  .centerRight,
                                                              colors: [
                                                            CommonColor
                                                                .LEFT_COLOR,
                                                            CommonColor
                                                                .RIGHT_COLOR
                                                          ]),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Yes",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Roboto_Regular",
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                4.5,
                                                            color: CommonColor
                                                                .WHITE_COLOR),
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .screenHeight *
                                                        0.03),
                                                child: GestureDetector(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: SizeConfig
                                                                .screenHeight *
                                                            0.0,
                                                        left: SizeConfig
                                                                .screenWidth *
                                                            0.1,
                                                        right: SizeConfig
                                                                .screenWidth *
                                                            0.1),
                                                    child: Container(
                                                        height: SizeConfig
                                                                .screenHeight *
                                                            0.05,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient: const LinearGradient(
                                                              begin: Alignment
                                                                  .centerLeft,
                                                              end: Alignment
                                                                  .centerRight,
                                                              colors: [
                                                                CommonColor
                                                                    .LEFT_COLOR,
                                                                CommonColor
                                                                    .RIGHT_COLOR
                                                              ]),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Roboto_Regular",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    4.5,
                                                                color: CommonColor
                                                                    .WHITE_COLOR),
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ));
                      },
                      // leading: Icon(Icons.message),
                      title: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.02),
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Roboto_Medium',
                              fontWeight: FontWeight.w500,
                              color: CommonColor.REGISTRARTION_COLOR),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getAddGameTabLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
          top: parentHeight * 0.03,
          right: parentWidth * 0.04,
          left: parentWidth * 0.04),
      child: Column(children: [
        // give the tab bar a height [can change hheight to preferred height]
        Container(
          height: parentHeight * 0.05,
          decoration: BoxDecoration(
            color: CommonColor.WHITE_COLOR,
            borderRadius: BorderRadius.circular(
              25.0,
            ),
            border: Border.all(
                color: CommonColor.REGISTRARTION_TRUSTEE, width: 0.7),
          ),
          child: TabBar(
            controller: _tabController,
            // give the indicator a decoration (color and border radius)
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                25.0,
              ),
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR]),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.green.shade800,
            tabs: const [
              // first tab [you can add an icon using the icon property]
              Tab(
                text: 'Joined Masjid',
              ),

              // second tab [you can add an icon using the icon property]
              Tab(
                text: 'All Masjid List',
              ),
            ],
          ),
        ),
        // tab bar view here
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(top: parentHeight * 0.0),
          child: TabBarView(
            controller: _tabController,
            children: [
              Stack(
                children: [
                  const Center(
                      child: Text(
                    "Aaysha",
                    style: TextStyle(color: Colors.red),
                  )),
                  MasjitMainScreen(
                    tabbr: '',
                    masjitIdRemoved: '',
                    onNext: () {
                      _tabController.index = 1;
                    },
                  ),
                ],
              ),
              AllMasjitList(
                onNext: () {
                  _tabController.index = 2;
                },
              ),
            ],
          ),
        ))
      ]),
    );
  }

  Future<UseLogoutResponceModel> getLogoutUser() async {
    print(" tokennn ${box.get(kToken)}");

    var headersList = {'Authorization': 'Bearer ${box.get(kToken)}'};

    var response = await http.get(
        Uri.parse('http://masjid.exportica.in/api/user/logout'),
        headers: headersList);

    if (response.statusCode == 200) {
      print("Yess.. ${response.body}");

      print("Hiii");

      return useLogoutResponceModelFromJson(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  static showExitDialog(BuildContext context) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          // return Transform(
          //   transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: const ExitAppDialog(
                message: "Are You Sure To Exit",
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation2, animation1) {
          return Container();
        });
  }

  Future<bool> _onBackPressed() {
    return showExitDialog(context);
  }
}
