
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:masjiduserapp/util/constant.dart';

import 'common.color.dart';
import 'masjit_user_app_api/masjit_app_responce_model/notice_response_model.dart';
class TrusteeUserTab extends StatefulWidget {

  final String masjitTrusteeId;

  const TrusteeUserTab({required this.masjitTrusteeId});


  @override
  State<TrusteeUserTab> createState() => _TrusteeUserTabState();
}

class _TrusteeUserTabState extends State<TrusteeUserTab> {
  late Box box;


  var getNotice;

  @override
  void initState() {
    box = Hive.box(kBoxName);
    super.initState();
   getNotice = getNoticeSection(widget.masjitTrusteeId);


  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SizedBox(
        height: SizeConfig.screenHeight*0.9,
        child: getAddTermsTextLayout(
            SizeConfig.screenHeight, SizeConfig.screenWidth),
      ),
    );
  }
  Widget getAddTermsTextLayout(double parentHeight, double parentWidth) {

    return FutureBuilder<AllMasjitDetailsResponceModel>(
        future:getNotice ,
        builder: (context, snapshot){
         return
           snapshot.data?.trustee?.length != null?
           ListView.builder(
              itemCount: snapshot.data?.trustee?.length,
              itemBuilder: (context, index) {
               // final data = snapshot.data!.notices?[index];


                return Padding(
                  padding: EdgeInsets.only(top: parentHeight * 0.03),
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
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          child: Container(
                            height: parentHeight * 0.06,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      CommonColor.LEFT_COLOR,
                                      CommonColor.RIGHT_COLOR
                                    ])),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${snapshot.data?.trustee?[index].designation}",
                                  style: TextStyle(
                                    fontSize: SizeConfig
                                        .blockSizeHorizontal * 4.9,
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
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: parentWidth * 0.1,
                                      top: parentHeight * 0.02),
                                  child: Text(
                                      "${snapshot.data?.trustee?[index].name}",
                                      style: TextStyle(
                                        fontSize: SizeConfig
                                            .blockSizeHorizontal * 4.3,
                                        fontFamily: 'Roboto_Bold',
                                        fontWeight: FontWeight.w600,
                                        color: CommonColor.BLACK_COLOR,)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: parentWidth * 0.1,
                                      top: parentHeight * 0.02),
                                  child: Text(
                                      "${snapshot.data?.trustee?[index].contact}",
                                      style: TextStyle(
                                        fontSize: SizeConfig
                                            .blockSizeHorizontal * 4.3,
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
              })
         :const Center(child: CircularProgressIndicator());

        });
  }


  Future<AllMasjitDetailsResponceModel> getNoticeSection(masjitTrusteeId) async {
    // print(" userId ${userId}");

    print(" tokennn ${box.get(kToken)}");

    var headersList = {
      'Authorization': 'Bearer ${box.get(kToken)}'
    };

    var response = await http.get(
        Uri.parse('http://admin.azan4salah.com/api/masjids/${widget.masjitTrusteeId}'),
        headers:headersList
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
  }
  }




