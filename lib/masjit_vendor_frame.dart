import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:masjiduserapp/size_config.dart';

import 'common.color.dart';
import 'enter_mobile_number.dart';


class MasjitVendorFrame extends StatefulWidget {
  const MasjitVendorFrame({Key? key}) : super(key: key);

  @override
  State<MasjitVendorFrame> createState() => _MasjitVendorFrameState();
}

class _MasjitVendorFrameState extends State<MasjitVendorFrame> {
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
                // height: SizeConfig.screenHeight*.74,
                width: SizeConfig.screenWidth,
                child: /* PageView.builder(
                 controller: viewPageControllerForSearch,
                 itemCount: _getChatGroupInfoData.length,
                 onPageChanged: onPageChanged,
                 itemBuilder:(context, index) {
                   GroupInfoMediaResponseModel model = _getChatGroupInfoData.elementAt(index);
                    return getAddGalleryImage(SizeConfig.screenHeight,SizeConfig.screenWidth,model);
                 }
             ),*/

                    Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeConfig.screenHeight * .0,
                      top: SizeConfig.screenHeight * .05),
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
                        height: SizeConfig.screenHeight * .7,
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

            getBottomButton(SizeConfig.screenHeight, SizeConfig.screenWidth),
            getSkipText(SizeConfig.screenHeight, SizeConfig.screenWidth),
          ],
        ),
      ),
    );
  }

  Widget getFirstImageFrame(double parentHeight, double parentWidth) {
    return Center(
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
    return GestureDetector(
      onDoubleTap: () {},
      onTap: () {
        //  Navigator.push(context, MaterialPageRoute(builder: (context)=> const DailyMotivation()));
      },
      child: Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.06,
            left: parentWidth * 0.1,
            right: parentHeight * 0.04),
        child: GestureDetector(
          onDoubleTap: () {},
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const EnterMobileNumber()));
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
                "Continue",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto_Regular'),
              ),
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
          Text(
            "Skip",
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                color: CommonColor.FRAME_NAME,
                fontFamily: 'Roboto_Regular'),
          ),
        ],
      ),
    );
  }
}
