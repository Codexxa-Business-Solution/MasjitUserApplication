

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:masjiduserapp/enter_mobile_number.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/util/constant.dart';

import 'common.color.dart';


class MasjitVendorFrame extends StatefulWidget {
  const MasjitVendorFrame({Key? key}) : super(key: key);

  @override
  State<MasjitVendorFrame> createState() => _MasjitVendorFrameState();
}

class _MasjitVendorFrameState extends State<MasjitVendorFrame> with WidgetsBindingObserver{
  int currentIndex = 0;

final PageController _pageController = PageController();
  List<String> listPaths = [
    "https://muslimmatters.org/2014/12/20/reviving-the-role-of-the-masjid-part-1/",
    "images/nature2.jpg",
    "images/nature3.jpg",
  ];
  final List<String> Frame = [
    "Frame 1",
    "Frame 2",
    "Frame 3",
  ];
  final List<String> FrameText = [
    "Lorem Ipsum is simply dummy text of the \n printing and typesetting",
    "Lorem Ipsum is simply dummy text of the \n printing and typesetting",
    "Lorem Ipsum is simply dummy text of the \n printing and typesetting",
  ];
  bool? _isNotificationPolicyAccessGranted = false;
  void setInterruptionFilter(int filter) async {
    final bool? isNotificationPolicyAccessGranted =
    await FlutterDnd.isNotificationPolicyAccessGranted;
    if (isNotificationPolicyAccessGranted != null &&
        isNotificationPolicyAccessGranted) {
      await FlutterDnd.setInterruptionFilter(filter);
    //  updateUI();
    }
  }


  Complete(){

    var  box = Hive.box(kBoxName);

    box.put(kOnBorading,true);
    FlutterDnd.gotoPolicySettings();
    setState(() {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>EnterMobileNumber()));
    });


  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);



    return GestureDetector(
      onDoubleTap: () {},
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            Container(
                 height: SizeConfig.screenHeight*.74,
                width: SizeConfig.screenWidth,
                child:

                    Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeConfig.screenHeight * .0,
                      top: SizeConfig.screenHeight * .0),

                  child:  PageView.builder(

                      // carouselController: _controller,
                      itemCount: listPaths.length,
                      controller: _pageController,

                      //widget.getChatGroupInfoData.length,
                      onPageChanged: (index) {
                        setState(() {

                          currentIndex = index % listPaths.length;
                        });
                      },

                    /*  options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        initialPage: 1,
                        height: SizeConfig.screenHeight * .7,
                        // aspectRatio: 1.1,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        autoPlay: false,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                      ),*/
                      itemBuilder:
                          (context, index,) {
                        return  Padding(
                          padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.2),
                          child: Column(
                            children: [
                            //  for (var i = 0; i < listPaths.length; i++)
                              Container(

                                height: SizeConfig.screenHeight * .30,
                                width: SizeConfig.screenWidth * .70,
                                decoration: BoxDecoration(
                                    color: CommonColor.GRAY_COLOR,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Image.network(
                                  listPaths[index % listPaths.length],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.06),
                                child: Text(

                                  Frame[index % Frame.length],
                                  style: TextStyle(
                                      fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                                      color: CommonColor.FRAME_NAME,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Roboto_bold'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: SizeConfig.screenHeight * 0.02,
                                ),
                                child: Text(
                                  FrameText[index % FrameText.length],
                                  style: TextStyle(
                                      fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                                      color: CommonColor.BLACK,
                                      fontWeight: FontWeight.w500,
                                      height: 1.6,
                                      fontFamily: 'Roboto_Regular'),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                )),
            /* Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: listPaths.map((url) {
                int index = listPaths.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPos == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }).toList(),
            ),*/
            //getFirstImageFrame(SizeConfig.screenHeight, SizeConfig.screenWidth),
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var i = 0; i < listPaths.length; i++)
                  buildIndicator(currentIndex == i)
              ],
            ),
           /* Row(
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
            ),*/
         /* getFirstImageFrame(
              SizeConfig.screenHeight, SizeConfig.screenWidth),*/
            getBottomButton(SizeConfig.screenHeight, SizeConfig.screenWidth),
            getSkipText(SizeConfig.screenHeight, SizeConfig.screenWidth),
          ],
        ),
      ),
    );
  }
  Widget buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        height: isSelected ? 10 : 10,
        width: isSelected ? 10 : 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? CommonColor.REGISTRARTION_COLOR : Colors.grey,
        ),
      ),
    );
  }
  Widget getFirstImageFrame(double parentHeight, double parentWidth) {
    return  Center(

      child: Container(
        width: parentWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: parentHeight * .30,
              width: parentWidth * .70,
              decoration: BoxDecoration(
                  color: CommonColor.GRAY_COLOR,
                  borderRadius: BorderRadius.circular(30)),


              /* child: ClipRRect(
               borderRadius: BorderRadius.all(Radius.circular(20)),

              // borderRadius: BorderRadius.circular(8),
              child: const Image(
                  image: AssetImage("assets/images/frame_one.png"),
                  fit: BoxFit.cover,
                ),
             ),*/
            ),

            Padding(
              padding: EdgeInsets.only(top: parentHeight * 0.06),
              child: Text(
                "Frame 1",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                    color: CommonColor.FRAME_NAME,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Roboto_bold'),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: parentHeight * 0.02,
              ),
              child: Text(
                "Lorem Ipsum is simply dummy text of the \n printing and typesetting",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                    color: CommonColor.BLACK,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                    fontFamily: 'Roboto_Regular'),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getBottomButton(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
          top: parentHeight * 0.06,
          left: parentWidth * 0.1,
          right: parentHeight * 0.04),
      child: GestureDetector(
        onDoubleTap: () {},
        onTap: () {
         // currentIndex< (listPaths.length=3)? FlutterDnd.gotoPolicySettings() : "";

         // _pageController.jumpToPage(currentIndex - 1);
         currentIndex< (listPaths.length - 1)?
             _pageController.jumpToPage(currentIndex +1):
         Complete();
        },
        child: Container(
          height: parentHeight * 0.06,
          width: parentWidth * 0.8,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  CommonColor.GET_STARTED_LEFT_COLOR,
                  CommonColor.GET_STARTED_RIGHT_COLOR
                ]),
          ),
          child: Center(
            child: Text(
             currentIndex< (listPaths.length + 1)?  "Next" :"Continue",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto_Regular'),
            ),
          ),
        ),
      ),
    );
  }
 /* goToNext() {
    carouselSlider. nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.decelerate);
  }*/
  Widget getSkipText(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              Complete();
            },
            child: Text(
              "Skip",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                  color: CommonColor.FRAME_NAME,
                  fontFamily: 'Roboto_Regular'),
            ),
          ),
        ],
      ),
    );
  }
}
