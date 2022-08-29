import 'package:flutter/material.dart';
import 'package:masjiduserapp/size_config.dart';

import 'common.color.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({
    Key? key
  }) : super(key: key);

  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> with SingleTickerProviderStateMixin  {

  bool serchIcon = true;
  bool searchBar = false;
  final _searchFocus = FocusNode();
  final searchController = TextEditingController();
  String _searchText = "";
  late TabController _tabController;
  @override
  void initState() {
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
    return Scaffold(
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
                  //s width: SizeConfig.screenWidth * 30,
                ),

                /* Image(image: AssetImage("assets/images/drower.png"),),*/
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            );
          },
        ),
        title: Stack(
          children: [
            Visibility(
              visible: serchIcon,
              child: Padding(
                padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.0),
                child: Center(
                  child: Text("Logo",
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                          fontFamily: 'Roboto_Bold',
                          letterSpacing: SizeConfig.screenWidth * 0.00,
                          fontWeight: FontWeight.w400,
                          color: CommonColor.WHITE_COLOR)),
                ),
              ),
            ),
            Visibility(
              visible: searchBar,
              child: Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth * .0,
                      right: SizeConfig.screenWidth * .0,top: SizeConfig.screenHeight*0.01),
                  child: Container(
                    height: SizeConfig.screenHeight * .050,

                    decoration: BoxDecoration(
                      color: CommonColor.SEARCH_COLOR,
                      borderRadius:
                      BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth *
                                  0.03),
                          child: Image(
                            image: const AssetImage("assets/images/searchs.png"),
                            // fit: BoxFit.contain,


                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.screenWidth *
                                    0.02,
                                right: SizeConfig.screenWidth *
                                    .01),
                            child: TextFormField(
                              scrollPadding: EdgeInsets.only(
                                  bottom:
                                  SizeConfig.screenHeight *
                                      .005),
                              controller: searchController,
                              focusNode: _searchFocus,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                isDense: true,
                                counterText: "",
                                hintText: "Search",
                                hintStyle: TextStyle(
                                  fontFamily: "Roboto_Regular",
                                  fontSize: SizeConfig
                                      .blockSizeHorizontal *
                                      4.6,
                                  color: CommonColor
                                      .SEARCH_TEXT_COLOR,
                                  fontWeight: FontWeight.w500,
                                ),
                                /* suffixIcon:
                                _searchText.isNotEmpty
                                    ? IconButton(
                                  onPressed:
                                  searchController
                                      .clear,
                                  icon: Icon(
                                    Icons.cancel,
                                    //color: CommonColor.SEARCH_CLEAR_COLOR,
                                  ),
                                )
                                    : null,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontFamily: "Roboto_Regular",
                                fontSize: SizeConfig
                                    .blockSizeHorizontal *
                                    4.6,
                                color: CommonColor.BLACK_COLOR,
                              ),*/
                              ),
                            ),
                          ),)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(
                  right: SizeConfig.screenWidth * 0.0,
                  top: SizeConfig.screenHeight * 0.02),
              child: Visibility(
                visible: serchIcon,
                child: Container(
                  width: SizeConfig.screenWidth * .15,
                  child: IconButton(
                    onPressed: () {
                      print("cjxb ${searchController}");

                      if(mounted)
                        setState(() {
                          serchIcon = false;
                          searchBar = true;
                        });

                    },
                    icon: Icon(Icons
                        .search), /*Image.asset(
                  'assets/images/appBarIcon.png',
                ),*/
                  ),
                ),
              ))
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
      body: Container(
          height: SizeConfig.screenHeight * 0.90,
          child: getAddGameTabLayout(
              SizeConfig.screenHeight, SizeConfig.screenWidth)
      ),
      drawer: Padding(
        padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.04),
        child: Container(
          height: SizeConfig.screenHeight * .99,
          width: SizeConfig.screenHeight * .4,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30.0),
            ),
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: const <Widget>[
                  SizedBox(
                    height: 110,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                CommonColor.LEFT_COLOR,
                                CommonColor.RIGHT_COLOR
                              ])),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Text(
                          "User Name  \n City",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Roboto_Medium',
                              fontWeight: FontWeight.w700,
                              color: CommonColor.WHITE_COLOR),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
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
                  ),
                  ListTile(
                    // leading: Icon(Icons.message),
                    title: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
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
                    // leading: Icon(Icons.message),
                    title: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
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
                    // leading: Icon(Icons.message),
                    title: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
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
    );
  }


  Widget getAddGameTabLayout(double parentHeight, double parentWidth) {
    return Container(

        child: Padding(
            padding:  EdgeInsets.only(top: parentHeight*0.03,right: parentWidth*0.04,left: parentWidth*0.04),
            child: Column(
                children: [
                  // give the tab bar a height [can change hheight to preferred height]
                  Container(
                    height: parentHeight*0.05,
                    decoration: BoxDecoration(
                      color: CommonColor.WHITE_COLOR,
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),  border: Border.all(color: CommonColor.REGISTRARTION_TRUSTEE, width: 0.7),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      // give the indicator a decoration (color and border radius)
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR]),

                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.green.shade800,
                      tabs: [
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
                        padding:  EdgeInsets.only(top:parentHeight*0.02),

                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Stack(
                              children: [

                                TabBar(
                                    controller: _tabController,
                                    unselectedLabelColor: Colors.redAccent,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.redAccent),
                                    tabs: [
                                      Tab(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              border: Border.all(color: Colors.redAccent, width: 1)),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("APPS"),
                                          ),
                                        ),


                                        /* child: DefaultTabController(

                      length: 3,
                      child: Column(

                        children: <Widget>[
                          Container(
                            height: parentHeight*0.05,
                            decoration: BoxDecoration(
                              color: CommonColor.WHITE_COLOR,
                              borderRadius: BorderRadius.circular(
                                25.0,
                              ),  border: Border.all(color: CommonColor.REGISTRARTION_TRUSTEE, width: 0.7),
                            ),
                            constraints: BoxConstraints.expand(height: 35,),
                            child: TabBar(
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    25.0,
                                  ),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR]),

                                ),
                                //indicatorColor: Colors.transparent,
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.grey,
                                tabs: [

                            Container(
                            height: parentHeight*0.05,
                              decoration: BoxDecoration(
                                color: CommonColor.WHITE_COLOR,
                                borderRadius: BorderRadius.circular(
                                  25.0,
                                ),  border: Border.all(color: CommonColor.REGISTRARTION_TRUSTEE, width: 0.7),
                              ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: parentWidth*0.0,top: parentHeight*0.0),

                                      child: Tab(
                                        child: Container(
                                          child:Text("Map",style: TextStyle(
                                            fontFamily: "Roboto_Regular",
                                            fontWeight: FontWeight.w500,
                                            fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                                            // color: CommonColor.WHITE_COLOR
                                          ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: parentWidth*0.0,top: parentHeight*0.02),

                                    child: Tab(
                                      child: Container(
                                        child:Text("Trustee",style: TextStyle(
                                          fontFamily: "Roboto_Regular",
                                          fontWeight: FontWeight.w500,
                                          fontSize: SizeConfig.blockSizeHorizontal * 3.5,

                                        ),),
                                      ),
                                    ),
                                  ),




                                  Padding(
                                    padding: EdgeInsets.only(left: parentWidth*0.0,top: parentHeight*0.02),

                                    child: Tab(
                                      child: Container(
                                        child:Text("Notice",style: TextStyle(
                                          fontFamily: "Roboto_Regular",
                                          fontWeight: FontWeight.w500,
                                          fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                          // color: CommonColor.WHITE_COLOR
                                        ),),
                                      ),
                                    ),
                                  ),

                                ]),
                          ),
                          Expanded(
                            child: Container(
                              child: TabBarView(children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.05),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(

                                            padding:  EdgeInsets.only(left: parentWidth*0.07,top: parentHeight*0.03),
                                            child: Text("AZAN",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.WHITE_COLOR,)),
                                          ),

                                          Row(
                                            children: [
                                              Padding(
                                                padding:EdgeInsets.only(right: parentWidth*0.07,top: parentHeight*0.03),
                                                child: Text("05:00",style: TextStyle(
                                                  fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                  fontFamily: 'Roboto_Bold',
                                                  fontWeight: FontWeight.w600,
                                                  color: CommonColor.WHITE_COLOR,)),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(top: parentHeight*0.03,right: parentWidth*0.03),
                                                child:
                                                Image(image: AssetImage("assets/images/editor.png"),height: parentHeight*0.03,),)
                                              // Icon(Icons.edit),
                                            ],
                                          )
                                        ],
                                      ),

                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.03),
                                      child: Row(
                                        children: [
                                          Container(
                                            color:CommonColor.BLACK,
                                            height: parentHeight*0.001,
                                            width: parentWidth,
                                            child:Text("hi",
                                              style: TextStyle(
                                                  color: Colors.transparent
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.013),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(

                                            padding:  EdgeInsets.only(left: parentWidth*0.07,top: parentHeight*0.03),
                                            child: Text("JAMA’AT",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.WHITE_COLOR,)),
                                          ),

                                          Row(
                                            children: [
                                              Padding(
                                                padding:EdgeInsets.only(right: parentWidth*0.06,top: parentHeight*0.03),
                                                child: Text("05:00",style: TextStyle(
                                                  fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                  fontFamily: 'Roboto_Bold',
                                                  fontWeight: FontWeight.w600,
                                                  color: CommonColor.WHITE_COLOR,)),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(top: parentHeight*0.03,right: parentWidth*0.03),
                                                child:
                                                Image(image: AssetImage("assets/images/editor.png"),height: parentHeight*0.03,),)
                                              // Icon(Icons.edit),
                                            ],
                                          )
                                        ],
                                      ),

                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.03),
                                      child: Row(
                                        children: [
                                          Container(
                                            color:CommonColor.BLACK,
                                            height: parentHeight*0.001,
                                            width: parentWidth,
                                            child:Text("hi",
                                              style: TextStyle(
                                                  color: Colors.transparent
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.05),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(

                                            padding:  EdgeInsets.only(left: parentWidth*0.07,top: parentHeight*0.03),
                                            child: Text("AZAN",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.WHITE_COLOR,)),
                                          ),

                                          Row(
                                            children: [
                                              Padding(
                                                padding:EdgeInsets.only(right: parentWidth*0.07,top: parentHeight*0.03),
                                                child: Text("05:00",style: TextStyle(
                                                  fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                  fontFamily: 'Roboto_Bold',
                                                  fontWeight: FontWeight.w600,
                                                  color: CommonColor.WHITE_COLOR,)),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(top: parentHeight*0.03,right: parentWidth*0.03),
                                                child:
                                                Image(image: AssetImage("assets/images/editor.png"),height: parentHeight*0.03,),)
                                              // Icon(Icons.edit),
                                            ],
                                          )
                                        ],
                                      ),

                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.03),
                                      child: Row(
                                        children: [
                                          Container(
                                            color:CommonColor.BLACK,
                                            height: parentHeight*0.001,
                                            width: parentWidth,
                                            child:Text("hi",
                                              style: TextStyle(
                                                  color: Colors.transparent
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.013),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(

                                            padding:  EdgeInsets.only(left: parentWidth*0.07,top: parentHeight*0.03),
                                            child: Text("JAMA’AT",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.WHITE_COLOR,)),
                                          ),

                                          Row(
                                            children: [
                                              Padding(
                                                padding:EdgeInsets.only(right: parentWidth*0.06,top: parentHeight*0.03),
                                                child: Text("05:00",style: TextStyle(
                                                  fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                  fontFamily: 'Roboto_Bold',
                                                  fontWeight: FontWeight.w600,
                                                  color: CommonColor.WHITE_COLOR,)),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(top: parentHeight*0.03,right: parentWidth*0.03),
                                                child:
                                                Image(image: AssetImage("assets/images/editor.png"),height: parentHeight*0.03,),)
                                              // Icon(Icons.edit),
                                            ],
                                          )
                                        ],
                                      ),

                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.03),
                                      child: Row(
                                        children: [
                                          Container(
                                            color:CommonColor.BLACK,
                                            height: parentHeight*0.001,
                                            width: parentWidth,
                                            child:Text("hi",
                                              style: TextStyle(
                                                  color: Colors.transparent
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.05),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(

                                            padding:  EdgeInsets.only(left: parentWidth*0.07,top: parentHeight*0.03),
                                            child: Text("AZAN",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.WHITE_COLOR,)),
                                          ),

                                          Row(
                                            children: [
                                              Padding(
                                                padding:EdgeInsets.only(right: parentWidth*0.07,top: parentHeight*0.03),
                                                child: Text("05:00",style: TextStyle(
                                                  fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                  fontFamily: 'Roboto_Bold',
                                                  fontWeight: FontWeight.w600,
                                                  color: CommonColor.WHITE_COLOR,)),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(top: parentHeight*0.03,right: parentWidth*0.03),
                                                child:
                                                Image(image: AssetImage("assets/images/editor.png"),height: parentHeight*0.03,),)
                                              // Icon(Icons.edit),
                                            ],
                                          )
                                        ],
                                      ),

                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.03),
                                      child: Row(
                                        children: [
                                          Container(
                                            color:CommonColor.BLACK,
                                            height: parentHeight*0.001,
                                            width: parentWidth,
                                            child:Text("hi",
                                              style: TextStyle(
                                                  color: Colors.transparent
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.013),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(

                                            padding:  EdgeInsets.only(left: parentWidth*0.07,top: parentHeight*0.03),
                                            child: Text("JAMA’AT",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.WHITE_COLOR,)),
                                          ),

                                          Row(
                                            children: [
                                              Padding(
                                                padding:EdgeInsets.only(right: parentWidth*0.06,top: parentHeight*0.03),
                                                child: Text("05:00",style: TextStyle(
                                                  fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                  fontFamily: 'Roboto_Bold',
                                                  fontWeight: FontWeight.w600,
                                                  color: CommonColor.WHITE_COLOR,)),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(top: parentHeight*0.03,right: parentWidth*0.03),
                                                child:
                                                Image(image: AssetImage("assets/images/editor.png"),height: parentHeight*0.03,),)
                                              // Icon(Icons.edit),
                                            ],
                                          )
                                        ],
                                      ),

                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.03),
                                      child: Row(
                                        children: [
                                          Container(
                                            color:CommonColor.BLACK,
                                            height: parentHeight*0.001,
                                            width: parentWidth,
                                            child:Text("hi",
                                              style: TextStyle(
                                                  color: Colors.transparent
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),

                              ]),
                            ),
                          )
                        ],
                      ),
                    ),*/
                                      ),
                                      Tab(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              border: Border.all(color: Colors.redAccent, width: 1)),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("APPS"),
                                          ),
                                        ),


                                        /* child: DefaultTabController(

                      length: 3,
                      child: Column(

                        children: <Widget>[
                          Container(
                            height: parentHeight*0.05,
                            decoration: BoxDecoration(
                              color: CommonColor.WHITE_COLOR,
                              borderRadius: BorderRadius.circular(
                                25.0,
                              ),  border: Border.all(color: CommonColor.REGISTRARTION_TRUSTEE, width: 0.7),
                            ),
                            constraints: BoxConstraints.expand(height: 35,),
                            child: TabBar(
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    25.0,
                                  ),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR]),

                                ),
                                //indicatorColor: Colors.transparent,
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.grey,
                                tabs: [

                            Container(
                            height: parentHeight*0.05,
                              decoration: BoxDecoration(
                                color: CommonColor.WHITE_COLOR,
                                borderRadius: BorderRadius.circular(
                                  25.0,
                                ),  border: Border.all(color: CommonColor.REGISTRARTION_TRUSTEE, width: 0.7),
                              ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: parentWidth*0.0,top: parentHeight*0.0),

                                      child: Tab(
                                        child: Container(
                                          child:Text("Map",style: TextStyle(
                                            fontFamily: "Roboto_Regular",
                                            fontWeight: FontWeight.w500,
                                            fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                                            // color: CommonColor.WHITE_COLOR
                                          ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: parentWidth*0.0,top: parentHeight*0.02),

                                    child: Tab(
                                      child: Container(
                                        child:Text("Trustee",style: TextStyle(
                                          fontFamily: "Roboto_Regular",
                                          fontWeight: FontWeight.w500,
                                          fontSize: SizeConfig.blockSizeHorizontal * 3.5,

                                        ),),
                                      ),
                                    ),
                                  ),




                                  Padding(
                                    padding: EdgeInsets.only(left: parentWidth*0.0,top: parentHeight*0.02),

                                    child: Tab(
                                      child: Container(
                                        child:Text("Notice",style: TextStyle(
                                          fontFamily: "Roboto_Regular",
                                          fontWeight: FontWeight.w500,
                                          fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                          // color: CommonColor.WHITE_COLOR
                                        ),),
                                      ),
                                    ),
                                  ),

                                ]),
                          ),
                          Expanded(
                            child: Container(
                              child: TabBarView(children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.05),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(

                                            padding:  EdgeInsets.only(left: parentWidth*0.07,top: parentHeight*0.03),
                                            child: Text("AZAN",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.WHITE_COLOR,)),
                                          ),

                                          Row(
                                            children: [
                                              Padding(
                                                padding:EdgeInsets.only(right: parentWidth*0.07,top: parentHeight*0.03),
                                                child: Text("05:00",style: TextStyle(
                                                  fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                  fontFamily: 'Roboto_Bold',
                                                  fontWeight: FontWeight.w600,
                                                  color: CommonColor.WHITE_COLOR,)),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(top: parentHeight*0.03,right: parentWidth*0.03),
                                                child:
                                                Image(image: AssetImage("assets/images/editor.png"),height: parentHeight*0.03,),)
                                              // Icon(Icons.edit),
                                            ],
                                          )
                                        ],
                                      ),

                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.03),
                                      child: Row(
                                        children: [
                                          Container(
                                            color:CommonColor.BLACK,
                                            height: parentHeight*0.001,
                                            width: parentWidth,
                                            child:Text("hi",
                                              style: TextStyle(
                                                  color: Colors.transparent
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.013),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(

                                            padding:  EdgeInsets.only(left: parentWidth*0.07,top: parentHeight*0.03),
                                            child: Text("JAMA’AT",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.WHITE_COLOR,)),
                                          ),

                                          Row(
                                            children: [
                                              Padding(
                                                padding:EdgeInsets.only(right: parentWidth*0.06,top: parentHeight*0.03),
                                                child: Text("05:00",style: TextStyle(
                                                  fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                  fontFamily: 'Roboto_Bold',
                                                  fontWeight: FontWeight.w600,
                                                  color: CommonColor.WHITE_COLOR,)),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(top: parentHeight*0.03,right: parentWidth*0.03),
                                                child:
                                                Image(image: AssetImage("assets/images/editor.png"),height: parentHeight*0.03,),)
                                              // Icon(Icons.edit),
                                            ],
                                          )
                                        ],
                                      ),

                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.03),
                                      child: Row(
                                        children: [
                                          Container(
                                            color:CommonColor.BLACK,
                                            height: parentHeight*0.001,
                                            width: parentWidth,
                                            child:Text("hi",
                                              style: TextStyle(
                                                  color: Colors.transparent
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.05),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(

                                            padding:  EdgeInsets.only(left: parentWidth*0.07,top: parentHeight*0.03),
                                            child: Text("AZAN",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.WHITE_COLOR,)),
                                          ),

                                          Row(
                                            children: [
                                              Padding(
                                                padding:EdgeInsets.only(right: parentWidth*0.07,top: parentHeight*0.03),
                                                child: Text("05:00",style: TextStyle(
                                                  fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                  fontFamily: 'Roboto_Bold',
                                                  fontWeight: FontWeight.w600,
                                                  color: CommonColor.WHITE_COLOR,)),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(top: parentHeight*0.03,right: parentWidth*0.03),
                                                child:
                                                Image(image: AssetImage("assets/images/editor.png"),height: parentHeight*0.03,),)
                                              // Icon(Icons.edit),
                                            ],
                                          )
                                        ],
                                      ),

                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.03),
                                      child: Row(
                                        children: [
                                          Container(
                                            color:CommonColor.BLACK,
                                            height: parentHeight*0.001,
                                            width: parentWidth,
                                            child:Text("hi",
                                              style: TextStyle(
                                                  color: Colors.transparent
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.013),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(

                                            padding:  EdgeInsets.only(left: parentWidth*0.07,top: parentHeight*0.03),
                                            child: Text("JAMA’AT",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.WHITE_COLOR,)),
                                          ),

                                          Row(
                                            children: [
                                              Padding(
                                                padding:EdgeInsets.only(right: parentWidth*0.06,top: parentHeight*0.03),
                                                child: Text("05:00",style: TextStyle(
                                                  fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                  fontFamily: 'Roboto_Bold',
                                                  fontWeight: FontWeight.w600,
                                                  color: CommonColor.WHITE_COLOR,)),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(top: parentHeight*0.03,right: parentWidth*0.03),
                                                child:
                                                Image(image: AssetImage("assets/images/editor.png"),height: parentHeight*0.03,),)
                                              // Icon(Icons.edit),
                                            ],
                                          )
                                        ],
                                      ),

                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.03),
                                      child: Row(
                                        children: [
                                          Container(
                                            color:CommonColor.BLACK,
                                            height: parentHeight*0.001,
                                            width: parentWidth,
                                            child:Text("hi",
                                              style: TextStyle(
                                                  color: Colors.transparent
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.05),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(

                                            padding:  EdgeInsets.only(left: parentWidth*0.07,top: parentHeight*0.03),
                                            child: Text("AZAN",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.WHITE_COLOR,)),
                                          ),

                                          Row(
                                            children: [
                                              Padding(
                                                padding:EdgeInsets.only(right: parentWidth*0.07,top: parentHeight*0.03),
                                                child: Text("05:00",style: TextStyle(
                                                  fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                  fontFamily: 'Roboto_Bold',
                                                  fontWeight: FontWeight.w600,
                                                  color: CommonColor.WHITE_COLOR,)),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(top: parentHeight*0.03,right: parentWidth*0.03),
                                                child:
                                                Image(image: AssetImage("assets/images/editor.png"),height: parentHeight*0.03,),)
                                              // Icon(Icons.edit),
                                            ],
                                          )
                                        ],
                                      ),

                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.03),
                                      child: Row(
                                        children: [
                                          Container(
                                            color:CommonColor.BLACK,
                                            height: parentHeight*0.001,
                                            width: parentWidth,
                                            child:Text("hi",
                                              style: TextStyle(
                                                  color: Colors.transparent
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.013),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(

                                            padding:  EdgeInsets.only(left: parentWidth*0.07,top: parentHeight*0.03),
                                            child: Text("JAMA’AT",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.WHITE_COLOR,)),
                                          ),

                                          Row(
                                            children: [
                                              Padding(
                                                padding:EdgeInsets.only(right: parentWidth*0.06,top: parentHeight*0.03),
                                                child: Text("05:00",style: TextStyle(
                                                  fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                  fontFamily: 'Roboto_Bold',
                                                  fontWeight: FontWeight.w600,
                                                  color: CommonColor.WHITE_COLOR,)),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(top: parentHeight*0.03,right: parentWidth*0.03),
                                                child:
                                                Image(image: AssetImage("assets/images/editor.png"),height: parentHeight*0.03,),)
                                              // Icon(Icons.edit),
                                            ],
                                          )
                                        ],
                                      ),

                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: parentHeight*0.03),
                                      child: Row(
                                        children: [
                                          Container(
                                            color:CommonColor.BLACK,
                                            height: parentHeight*0.001,
                                            width: parentWidth,
                                            child:Text("hi",
                                              style: TextStyle(
                                                  color: Colors.transparent
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),

                              ]),
                            ),
                          )
                        ],
                      ),
                    ),*/
                                      )] ),

                                /* GestureDetector(
                onTap: (){_tabController.animateTo(1);
            *//*Navigator.push(context,
            MaterialPageRoute(builder: (context) => TabBarScreen()));*/
                                /*
            },
                child: Center(
                  child: Padding(
                    padding:  EdgeInsets.only(top: parentHeight*0.0,left: parentWidth*0.25,right: parentWidth*0.25),
                    child: Container(
                        height: parentHeight*0.07,


                        decoration:  BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR]),
                          borderRadius: BorderRadius.circular(10),


                        ),
                        child:Center(
                          child: Text(" Join Masjid",style: TextStyle(
                              fontFamily: "Roboto_Regular",
                              fontWeight: FontWeight.w700,
                              fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                              color: CommonColor.WHITE_COLOR
                          ),),
                        )
                    ),
                  ),
                )
            )*/

                                /* Padding(
                  padding: EdgeInsets.only(
                      top: parentHeight * 0.0),
                  child: Container(
                    height: parentHeight,
                    child: ListView.builder(
                        itemCount: 7,
                        padding: const EdgeInsets.only(
                            bottom: 20,
                            top: 5
                        ),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: parentHeight*0.03),
                            child: Container(
                              height: parentHeight * 0.16,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 5),
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.shade50,
                                    offset: const Offset(-5, 0),
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.shade50,
                                    offset: const Offset(5, 0),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                                    child: Container(
                                      height: parentHeight*0.04,
                                      decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR])),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("FAJR",
                                            style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.WHITE_COLOR,

                                            ),

                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(left: parentWidth*0.1,top: parentHeight*0.02),
                                            child: Text("AZAN",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.BLACK_COLOR,)),
                                          ),
                                          Padding(
                                            padding:EdgeInsets.only(right: parentWidth*0.1,top: parentHeight*0.02),
                                            child: Text("05:00",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.BLACK_COLOR,)),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(left: parentHeight*0.05,top: parentHeight*0.03),
                                            child: Text("JAMA’AT",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.BLACK_COLOR,)),

                                          ),
                                          Padding(
                                            padding:EdgeInsets.only(right: parentWidth*0.1,top: parentHeight*0.02),
                                            child: Text("05:30",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.BLACK_COLOR,)),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),


                )*/
                              ],),


                            // first tab bar view widget


                            // second tab bar view widget
                            Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: parentHeight * 0.0),
                                  child: Container(
                                    height: parentHeight,
                                    child: ListView.builder(
                                        itemCount: 7,
                                        padding: const EdgeInsets.only(
                                            bottom: 20,
                                            top: 5
                                        ),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(top: parentHeight*0.03),
                                            child: Container(
                                              height: parentHeight * 0.23,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(20),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                    color: Colors.grey.shade300,
                                                    spreadRadius: 1,
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 5),
                                                  ),
                                                  BoxShadow(
                                                    color: Colors.grey.shade50,
                                                    offset: const Offset(-5, 0),
                                                  ),
                                                  BoxShadow(
                                                    color: Colors.grey.shade50,
                                                    offset: const Offset(5, 0),
                                                  )
                                                ],
                                              ),
                                              child: Row(

                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:EdgeInsets.only(left: parentWidth*0.01),
                                                    child: Container(
                                                        height: parentHeight*0.17,
                                                        width: parentWidth*0.30,

                                                        decoration: BoxDecoration(

                                                            image: DecorationImage(
                                                              image:  AssetImage("assets/images/logo.png"),
                                                              fit: BoxFit.cover,

                                                            ),
                                                            borderRadius: BorderRadius.circular(10)
                                                        )
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: EdgeInsets.only(left: parentHeight*0.01),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:  EdgeInsets.only(right: parentWidth*0.05,top: parentHeight*0.03),
                                                              child: Text("Masjit Name",style: TextStyle(
                                                                fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                                fontFamily: 'Roboto_Bold',
                                                                fontWeight: FontWeight.w500,
                                                                color: CommonColor.MASJIT_NAME,)),
                                                            ),
                                                            Padding(
                                                              padding:  EdgeInsets.only(top: parentHeight*0.03,left: parentWidth*0.04,right: parentWidth*0.0),
                                                              child: Container(
                                                                  height: parentHeight*0.04,
                                                                  width: parentHeight*0.12,


                                                                  decoration:  BoxDecoration(
                                                                    gradient: LinearGradient(
                                                                        begin: Alignment.centerLeft,
                                                                        end: Alignment.centerRight,
                                                                        colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR]),
                                                                    borderRadius: BorderRadius.circular(10),


                                                                  ),
                                                                  child:Center(
                                                                    child: Text("JOIN",style: TextStyle(
                                                                        fontFamily: "Roboto_Regular",
                                                                        fontWeight: FontWeight.w700,
                                                                        fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                                        color: CommonColor.WHITE_COLOR
                                                                    ),),
                                                                  )
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        Row(
                                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:  EdgeInsets.only(right: parentHeight*0.02,top: parentHeight*0.002),
                                                              child: Text("Location :",style: TextStyle(
                                                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                                                fontFamily: 'Roboto_Bold',
                                                                fontWeight: FontWeight.w400,
                                                                color: CommonColor.BLACK_COLOR,)),

                                                            ),
                                                            /* Padding(
                                                      padding:EdgeInsets.only(right: parentWidth*0.1,top: parentHeight*0.02),
                                                      child: Text("05:30",style: TextStyle(
                                                        fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                        fontFamily: 'Roboto_Bold',
                                                        fontWeight: FontWeight.w600,
                                                        color: CommonColor.BLACK_COLOR,)),
                                                    )*/
                                                          ],
                                                        ),
                                                        Row(
                                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:  EdgeInsets.only(right: parentHeight*0.02,top: parentHeight*0.01),
                                                              child: Text("FAZAR",style: TextStyle(
                                                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                                                fontFamily: 'Roboto_Bold',
                                                                fontWeight: FontWeight.w500,
                                                                color: CommonColor.BLACK_COLOR,)),

                                                            ),
                                                            /* Padding(
                                                      padding:EdgeInsets.only(right: parentWidth*0.1,top: parentHeight*0.02),
                                                      child: Text("05:30",style: TextStyle(
                                                        fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                        fontFamily: 'Roboto_Bold',
                                                        fontWeight: FontWeight.w600,
                                                        color: CommonColor.BLACK_COLOR,)),
                                                    )*/
                                                          ],
                                                        ),
                                                        Row(
                                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:  EdgeInsets.only(right: parentHeight*0.0,top: parentHeight*0.01),
                                                              child: Text("AZAN :",style: TextStyle(
                                                                fontSize: SizeConfig.blockSizeHorizontal *4.0,
                                                                fontFamily: 'Roboto_Bold',
                                                                fontWeight: FontWeight.w500,
                                                                color: CommonColor.BLACK_COLOR,)),

                                                            ),
                                                            Padding(
                                                              padding:EdgeInsets.only(right: parentWidth*0.02,top: parentHeight*0.01),
                                                              child: Text("05:30",style: TextStyle(
                                                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                                                fontFamily: 'Roboto_Bold',
                                                                fontWeight: FontWeight.w600,
                                                                color: CommonColor.BLACK_COLOR,)),
                                                            ),
                                                            Padding(
                                                              padding:  EdgeInsets.only(right: parentHeight*0.01,top: parentHeight*0.01),
                                                              child: Text("JAMA’AT :",style: TextStyle(
                                                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                                                fontFamily: 'Roboto_Bold',
                                                                fontWeight: FontWeight.w500,
                                                                color: CommonColor.BLACK_COLOR,)),

                                                            ),
                                                            Padding(
                                                              padding:EdgeInsets.only(right: parentWidth*0.0,top: parentHeight*0.01),
                                                              child: Text("05:30",style: TextStyle(
                                                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                                                fontFamily: 'Roboto_Bold',
                                                                fontWeight: FontWeight.w600,
                                                                color: CommonColor.BLACK_COLOR,)),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),


                                )
                              ],

                            ),
                          ],
                        ),
                      )
                  )
                ])
        )
    );

  }
}
