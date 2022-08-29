import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masjiduserapp/size_config.dart';


import 'common.color.dart';
class JoinedMasjitThreeTabs extends StatefulWidget {
  const JoinedMasjitThreeTabs({Key? key}) : super(key: key);

  @override
  State<JoinedMasjitThreeTabs> createState() => _JoinedMasjitThreeTabsState();
}

class _JoinedMasjitThreeTabsState extends State<JoinedMasjitThreeTabs> with SingleTickerProviderStateMixin  {
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
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body:
       Container(
            height: SizeConfig.screenHeight * 088,
            child: getAddTermsTextLayout(
                SizeConfig.screenHeight, SizeConfig.screenWidth),
          ),
        );
  }

  Widget getAddTermsTextLayout(double parentHeight, double parentWidth) {

return  DefaultTabController(

    length: 3,

    child: Column(

        children: <Widget>[



          Container(

            child: TabBar(



                unselectedLabelColor: Colors.green.shade800,

                padding: EdgeInsets.zero,



                indicatorSize: TabBarIndicatorSize.label,

                indicator: BoxDecoration(

                  borderRadius: BorderRadius.circular(50),

                  gradient: LinearGradient(

                      begin: Alignment.centerLeft,

                      end: Alignment.centerRight,

                      colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR]),),

                tabs: [

                  Tab(

                    child: Container(

                      width: parentWidth*0.5,

                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(50),

                          border: Border.all(color: Colors.green.shade800, width: 0.7)),

                      child: Align(

                        alignment: Alignment.center,

                        child: Text("Map",style: TextStyle(

                          fontSize: SizeConfig.blockSizeHorizontal * 3.5,

                          fontFamily: 'Roboto_Bold',

                          fontWeight: FontWeight.w400,

                        )),

                      ),

                    ),

                  ),

                  Tab(

                    child: Container(

                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(50),

                          border: Border.all(color: Colors.green.shade800, width: 1)),

                      child: Align(

                        alignment: Alignment.center,



                        child: Text("Trustee"),

                      ),

                    ),

                  ),

                  Tab(

                    child: Container(

                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(50),

                          border: Border.all(color: Colors.green.shade800, width: 1)),

                      child: Align(

                        alignment: Alignment.center,

                        child: Text("Notice"),

                      ),

                    ),

                  ),

                ]),

          ),

          Expanded(

            child: Container(

              child: TabBarView(children: [

                Container(

                  child: Text("Map"),

                ),

                Stack(

                  children: [

                    Padding(

                        padding: EdgeInsets.only(

                            top: parentHeight * 0.0),

                        child: Container(

                          height: parentHeight,

                          child: ListView.builder(

                              itemCount: 4,

                              padding: const EdgeInsets.only(

                                  bottom: 20,

                                  top: 5

                              ),

                              itemBuilder: (context, index) {

                                return Padding(

                                  padding: EdgeInsets.only(top: parentHeight*0.03),

                                  child: Container(

                                    height: parentHeight * 0.12,

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

                                            height: parentHeight*0.06,

                                            decoration: const BoxDecoration(

                                                gradient: LinearGradient(

                                                    begin: Alignment.centerLeft,

                                                    end: Alignment.centerRight,

                                                    colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR])),

                                            child: Row(

                                              mainAxisAlignment: MainAxisAlignment.center,

                                              children: [

                                                Text("Chairman",

                                                  style: TextStyle(

                                                    fontSize: SizeConfig.blockSizeHorizontal * 4.9,

                                                    fontFamily: 'Roboto_Bold',

                                                    fontWeight: FontWeight.w500,

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

                                                  child: Text("Feroz",style: TextStyle(

                                                    fontSize: SizeConfig.blockSizeHorizontal * 4.3,

                                                    fontFamily: 'Roboto_Bold',

                                                    fontWeight: FontWeight.w600,

                                                    color: CommonColor.BLACK_COLOR,)),

                                                ),

                                                Padding(

                                                  padding:EdgeInsets.only(right: parentWidth*0.1,top: parentHeight*0.02),

                                                  child: Text("9168682309",style: TextStyle(

                                                    fontSize: SizeConfig.blockSizeHorizontal * 4.3,

                                                    fontFamily: 'Roboto_Bold',

                                                    fontWeight: FontWeight.w600,

                                                    color: CommonColor.BLACK_COLOR,)),

                                                ),

                                              ],

                                            ),





                                          ],

                                        )

                                      ],

                                    ),

                                  ),

                                );

                              }),

                        ),



                     /*   Container(

                          height: parentHeight * 0.11,

                          decoration: BoxDecoration(

                            color: Colors.white,

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

                              Row(

                                mainAxisAlignment: MainAxisAlignment.start,

                                children: [

                                  Padding(

                                    padding: EdgeInsets.only(

                                        left: parentWidth * 0.03, top: parentHeight * 0.007),

                                    child: Text("Email Id"),

                                  ),

                                ],

                              ),

                              Padding(

                                padding: EdgeInsets.only(

                                    left: parentWidth * 0.025, right: parentWidth * 0.025, top: parentHeight*0.007),

                                child: Container(

                                  height: parentHeight*.06,

                                  decoration: BoxDecoration(

                                      border: Border.all(color: Colors.green, width: 1.5),

                                      borderRadius: BorderRadius.circular(5)

                                  ),

                                  child: Column(

                                    children: [

                                      Row(



                                      )

                                    ],

                                  ),

                                ),

                              ),



                            ],

                          ),

                        )*/

                    )

                  ],

                ),

                Container(

                    child: Flexible(

                      child: Padding(

                        padding:  EdgeInsets.only(top: parentHeight*0.03),

                        child: Text(



                          "Lorem Ipsum is simply dummy text of printing and typesetting. Lorem Ipsum is simply dummy text  of printing and typesetting.Lorem Ipsum is simply dummy text of printing and typesetting. Lorem Ipsum is simply dummy text of printing and typesetting. Lorem Ipsum is simply dummy text  of printing and typesetting.Lorem Ipsum is simply dummy text of printing and typesetting. " ,

                          style:TextStyle(

                            height: parentHeight*0.003,

                            fontFamily: "Roboto_Regular",

                            fontWeight: FontWeight.w400,



                            fontSize: SizeConfig.blockSizeHorizontal * 4.5,

                            color: Colors.black,

                            // letterSpacing: SizeConfig.screenWidth * 0.001,

                          ),

                          // textAlign: TextAlign.justify,

                        ),

                      ),

                    )

                ),

              ]),

            ),

          ),



        ]));

  }
}
