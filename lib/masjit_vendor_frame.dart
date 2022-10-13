

import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/user_login_screen.dart';
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
    "https://cdn.pixabay.com/photo/2015/10/25/21/02/abu-1006336__340.jpg",
    "https://cdn.pixabay.com/photo/2015/10/25/21/02/abu-1006336__340.jpg",
"https://cdn.pixabay.com/photo/2015/01/28/23/10/mosque-615415_960_720.jpg"];
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
  final bool? _isNotificationPolicyAccessGranted = false;
  void setInterruptionFilter(int filter) async {
    final bool? isNotificationPolicyAccessGranted =
    await FlutterDnd.isNotificationPolicyAccessGranted;
    if (isNotificationPolicyAccessGranted != null &&
        isNotificationPolicyAccessGranted) {
      await FlutterDnd.setInterruptionFilter(filter);
    //  updateUI();
    }
  }


  complete(){

    var  box = Hive.box(kBoxName);
print("dndSetting $FlutterDnd");
    box.put(kOnBorading,true);
    FlutterDnd.gotoPolicySettings();
    setState(() {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const LoginScreen()));
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
            SizedBox(
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
                                child:ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child:Image.network(
                                    listPaths[index % listPaths.length],
                                    fit: BoxFit.cover,

                                  ),
                                )
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

            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var i = 0; i < listPaths.length; i++)
                  buildIndicator(currentIndex == i)
              ],
            ),


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

      child: SizedBox(
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

          currentIndex++;

          _pageController.jumpToPage(currentIndex);

          currentIndex == 3 ?

          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(

                title: const Center(child:  Text("DND Activation", style: TextStyle(
                  color: CommonColor.REGISTRARTION_COLOR,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  fontFamily: 'Roboto_Medium',
                ),)),
                content:  Padding(
                  padding:  EdgeInsets.only(left: SizeConfig.screenWidth*0.04),
                  child: const Text("DND Activation Mandatory for this Application",


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
                    padding:  EdgeInsets.only(bottom: SizeConfig.screenHeight*0.03),
                    child: Center(
                      child: Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          GestureDetector(
                            onTap: () {

                              complete();

                              //currentIndex == 3 ? complete() : Container();
                              //cityController.text.isEmpty ? validate = true : validate = false;

                            },
                            child:  Padding(
                              padding: EdgeInsets.only(

                                  left: SizeConfig.screenWidth * 0.14,
                                  right: SizeConfig.screenWidth * 0.11),
                              child: Container(
                                  height: SizeConfig.screenHeight * 0.05,

                                  child: Center(
                                    child: Text(
                                      "Allow",
                                      style: TextStyle(
                                          fontFamily: "Roboto_Regular",
                                          fontWeight: FontWeight.w400,
                                          fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                                          color: CommonColor.BLACK_COLOR),
                                    ),
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.0),
                              child: GestureDetector(

                                child:  Padding(
                                  padding: EdgeInsets.only(

                                      left: SizeConfig.screenWidth * 0.11,
                                      right: SizeConfig.screenWidth * 0.11),
                                  child: Container(
                                      height: SizeConfig.screenHeight * 0.05,

                                      child: Center(
                                        child: Text(
                                          "Cancle",
                                          style: TextStyle(
                                              fontFamily: "Roboto_Regular",
                                              fontWeight: FontWeight.w400,
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                                              color: CommonColor.BLACK_COLOR),
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
              )):Container();
          // currentIndex == 3 ?
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
              currentIndex == 2?  "Continue" :"Next",
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

  Widget getSkipText(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(

                    title: const Center(child:  Text("DND Activation", style: TextStyle(
                      color: CommonColor.REGISTRARTION_COLOR,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontFamily: 'Roboto_Medium',
                    ),)),
                    content:  Padding(
                      padding:  EdgeInsets.only(left: SizeConfig.screenWidth*0.04),
                      child: const Text("DND Activation Mandatory for this Application",


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
                        padding:  EdgeInsets.only(bottom: SizeConfig.screenHeight*0.03),
                        child: Center(
                          child: Row(
                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              GestureDetector(
                                onTap: () {

                                  complete();

                                  //currentIndex == 3 ? complete() : Container();
                                  //cityController.text.isEmpty ? validate = true : validate = false;

                                },
                                child:  Padding(
                                  padding: EdgeInsets.only(

                                      left: SizeConfig.screenWidth * 0.14,
                                      right: SizeConfig.screenWidth * 0.11),
                                  child: Container(
                                      height: SizeConfig.screenHeight * 0.05,

                                      child: Center(
                                        child: Text(
                                          "Allow",
                                          style: TextStyle(
                                              fontFamily: "Roboto_Regular",
                                              fontWeight: FontWeight.w400,
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                                              color: CommonColor.BLACK_COLOR),
                                        ),
                                      )),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.0),
                                  child: GestureDetector(

                                    child:  Padding(
                                      padding: EdgeInsets.only(

                                          left: SizeConfig.screenWidth * 0.11,
                                          right: SizeConfig.screenWidth * 0.11),
                                      child: Container(
                                          height: SizeConfig.screenHeight * 0.05,

                                          child: Center(
                                            child: Text(
                                              "Cancle",
                                              style: TextStyle(
                                                  fontFamily: "Roboto_Regular",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                                                  color: CommonColor.BLACK_COLOR),
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
              //complete();
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
