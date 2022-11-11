import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:masjiduserapp/common.color.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/all_masjit_remove_list_response_model.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/showNotificationApi.dart';
import 'package:masjiduserapp/parent_masjit_location_name.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/user_parent_tab_bar.dart';
import 'package:masjiduserapp/util/constant.dart';

class EndFriendDialog extends StatefulWidget {
  final EndFriendDialogInterface mListener;
  final String masjitRemoveIdd;

  const EndFriendDialog(
      {required this.mListener,
      required this.masjitRemoveIdd,
      });

  @override
  _EndFriendDialogState createState() => _EndFriendDialogState();
}

late Box box;

class _EndFriendDialogState extends State<EndFriendDialog> {
  @override
  void initState() {
    box = Hive.box(kBoxName);
    //print("End friendship..${widget.msgId}");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.screenWidth * .13,
              right: SizeConfig.screenWidth * .13),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              //height: SizeConfig.screenHeight * .33,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                //color: CommonColor.RED_COLOR,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  getAddLogOutLayout(
                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                  getAddLogOutTextLayout(
                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                  getAddMainMessageLayout(
                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                  getAddCancelButtonLayout(
                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /* Main Delete Message Layout */
  Widget getAddLogOutLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * .02),
      child: Text(
        "Remove Masjid",
        //  ApplicationLocalizations.of(context)!.translate("end_friendship")!,
        style: TextStyle(
          color: CommonColor.BLACK_COLOR,
          fontSize: SizeConfig.blockSizeHorizontal * 4.5,
          fontWeight: FontWeight.w700,
          fontFamily: 'Roboto_Bold',
        ),
      ),
    );
  }

  /* Get Add Delete Game Text Layout */
  Widget getAddLogOutTextLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
          top: parentHeight * .015,
          left: parentWidth * .02,
          right: parentWidth * .02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              "Are you sure you want to Remove Masjid from your account? You can add the same Masjid again after you Remove it.",
              //ApplicationLocalizations.of(context)!.translate("end_friend_subtext")!,
              style: TextStyle(
                color: CommonColor.BLACK_COLOR,
                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto_Regular',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  /* Get Add Main Message Layout */
  Widget getAddMainMessageLayout(double parentHeight, double parentWidth) {
    return GestureDetector(
      onTap: () {


        print("AlreadyTimmeeeee $namazTimes");

        // NotificationService().scheduleNotifications(times: namazTimes);

        getRemoveMasjit(widget.masjitRemoveIdd);
      },
      onDoubleTap: () {},
      child: Padding(
        padding: EdgeInsets.only(top: parentHeight * .027),
        child: Container(
          height: parentHeight * .06,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: CommonColor.DIVIDER_COLOR),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "REMOVE MASJID",
                /* ApplicationLocalizations.of(context)!.translate("end_friendship_text")!,*/
                style: TextStyle(
                  color: CommonColor.RED_COLOR,
                  fontSize: SizeConfig.blockSizeHorizontal * 4.2,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto_Medium',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* Get Add Cancel Button Layout */
  Widget getAddCancelButtonLayout(double parentHeight, double parentWidth) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      onDoubleTap: () {},
      child: Padding(
        padding: EdgeInsets.only(top: parentHeight * .0),
        child: Container(
          height: parentHeight * .06,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: CommonColor.DIVIDER_COLOR),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "CANCEL",
                style: TextStyle(
                  color: CommonColor.DELETE_GAME_COLOR,
                  fontSize: SizeConfig.blockSizeHorizontal * 4.4,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto_Medium',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<UseRemoveResponceModel> getRemoveMasjit(
      masjitIdRemoved) async {
    var headersList = {'Authorization': 'Bearer ${box.get(kToken)}'};

    var response = await http.get(
        Uri.parse(
            'http://masjid.exportica.in/api/user/remove?masjid=$masjitIdRemoved'),
        headers: headersList);

    if (response.statusCode == 200) {
      //var removeId = box.get(kJoinedCommonId);
      print("removedId  ${box.get(kJoinedCommonId)}");

      /*namazTimes.clear();*/

      // for(int i = 0; i < namazTimes.length; i++){
      //   await AndroidAlarmManager.cancel(i);
      // }

      final file = File(
          '/data/data/com.azanforsalah.user/app_flutter/time.json');
      file.writeAsStringSync('');

      final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

      await notificationsPlugin.cancelAll();

      namazTimes.clear();

      print("Cleartrimmeeeee new $namazTimes");

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ParentTabBarScreen()));
      print("Yess.. ${response.body}");

      print("Hiii");

      return useRemoveResponceModelFromJson(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }
}

abstract class EndFriendDialogInterface {
  callUnFriendApi(String userId, String isConverted, int index, String msgId);
}
