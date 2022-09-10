import 'package:flutter/material.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/notice_response_model.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:http/http.dart' as http;

class NoticeUserTab extends StatefulWidget {
  const NoticeUserTab({Key? key}) : super(key: key);

  @override
  State<NoticeUserTab> createState() => _NoticeUserTabState();
}

class _NoticeUserTabState extends State<NoticeUserTab> {


  var getNotice;

  @override
  void initState() {
    super.initState();
   // getNotice = getNoticeSection();
    print(getNotice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        height: SizeConfig.screenHeight * 0.9,
       /* child: getAddTermsTextLayout(
            SizeConfig.screenHeight, SizeConfig.screenWidth),*/
      ),
    );
  }

  /*Widget getAddTermsTextLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding:
      EdgeInsets.only(top: parentHeight * 0.01, left: parentWidth * 0.02),
      child: FutureBuilder<AllMasjitDetailsResponceModel>(
          future: getNotice,
          builder: (context, snapshot) {
            return snapshot.data?.notices != null ?

            ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot
                    .data?.notices?.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder:
                    (context, index) {
                  return  Text("${snapshot.data?.notices?[index]}",
                    style: TextStyle(
                      // height: parentHeight*0.002,

                      fontFamily: "Roboto_Regular",

                      fontWeight: FontWeight.w400,

                      fontSize: SizeConfig.blockSizeHorizontal * 4.5,

                      color: Colors.black,

                      // letterSpacing: SizeConfig.screenWidth * 0.001,
                    ),

                    // textAlign: TextAlign.justify,
                  ) ;
                })
                : const Center(child: CircularProgressIndicator());
          }),




    );
  }

  Future<AllMasjitDetailsResponceModel> getNoticeSection() async {
    // print(" userId ${userId}");

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };

    // final msg = jsonEncode({
    //   "user_id": userId.toString(),
    // });

    var response = await http.post(
      Uri.parse("http://sangh.bizz-manager.com/?id=1"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      // circularLoader = false;

      print("Yess.. ${response.body}");

      print("Hiii");

      return allMasjitDetailsResponceModelFromJson(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }*/
}
