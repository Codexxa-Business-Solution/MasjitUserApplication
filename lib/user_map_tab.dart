import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:masjiduserapp/size_config.dart';

import 'common.color.dart';
class UserMapLocation extends StatefulWidget {
  const UserMapLocation({Key? key}) : super(key: key);

  @override
  State<UserMapLocation> createState() => _UserMapLocationState();
}

class _UserMapLocationState extends State<UserMapLocation> {
  bool showDetails = true;



  bool mapScreen = false;
  bool trusteeScreen = false;
  bool noticeScreen = false;
  int currentIndex = 0;
  int currentPos = 0;
  List<String> listPaths = [
    "images/nature1.jpg",
    "images/nature2.jpg",
    "images/nature3.jpg",
    "images/nature4.jpg",
    "images/nature5.jpg",
    "images/nature6.jpg",
  ];

  @override
  void initState() {
    super.initState();
    if(mounted)
      setState(() {
        showDetails = true;
      });
   // _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
   // _tabController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          /*MasjitDetails(
              SizeConfig.screenHeight, SizeConfig.screenWidth),*/
          MapConsideration(SizeConfig.screenHeight,SizeConfig.screenWidth)
        ],
      ),
    );
  }
 /* Widget MasjitDetails(double parentHeight , double parentWidth){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,


      children: [
        Padding(
          padding: EdgeInsets.only(left: parentHeight * 0.00),
          child: Text(
            "Masjid Name",
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                color: CommonColor.BLACK,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto_bold'),

          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.003,left: parentHeight*0.00
          ),
          child: Text(
            "Location :",
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                color: CommonColor.BLACK,
                fontWeight: FontWeight.w500,
                height: 1.6,
                fontFamily: 'Roboto_Regular'),

          ),
        ),
        Container(
          // height: SizeConfig.screenHeight*.74,
            width: SizeConfig.screenWidth,
            color: Colors.yellow,
            child:

            Padding(
              padding: EdgeInsets.only(
                  bottom: SizeConfig.screenHeight * .0,
                  top: SizeConfig.screenHeight * .0),
              child: CarouselSlider.builder(
                // carouselController: _controller,
                  itemCount: listPaths.length,
                  //widget.getChatGroupInfoData.length,
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    initialPage: 1,
                    height: SizeConfig.screenHeight * .3,
                    // aspectRatio: 1.1,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    autoPlay: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                  itemBuilder:
                      (BuildContext context, int itemIndex, int index) {
                    return getFirstImageFrame(
                        SizeConfig.screenHeight, SizeConfig.screenWidth);
                  }),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < listPaths.length; i++)
              Container(
                width: 7,
                height: 7,
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: currentIndex == i
                      ? Colors.green
                      : Colors.grey.shade400,
                  shape: BoxShape.circle,
                ),
              )
          ],
        ),
        *//* Text("Masjid Name"),
                      Text ("Location :")*//*
      ],
    );

  }*/
 /* Widget getFirstImageFrame(double parentHeight, double parentWidth) {
    return
      Padding(
        padding: EdgeInsets.only(left: parentWidth*0.03),
        child: Container(
          width: parentWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding:  EdgeInsets.only(top: parentHeight*0.02),
                child: Container(
                  height: parentHeight * .23,
                  width: parentWidth * .94,
                  decoration: BoxDecoration(
                      color: CommonColor.GRAY_COLOR,
                      borderRadius: BorderRadius.circular(0)),

                  *//* child: ClipRRect(
                 borderRadius: BorderRadius.all(Radius.circular(20)),

                // borderRadius: BorderRadius.circular(8),
                child: const Image(
                    image: AssetImage("assets/images/frame_one.png"),
                    fit: BoxFit.cover,
                  ),
               ),*//*
                ),
              ),

            ],
          ),
        ),
      );
  }*/

  Widget MapConsideration(double parentHeight,double parentWidth){
    return Container(
     child: Center(child: Text("Map")),
    );
  }
}
