import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppPreferences {
  static SharedPreferences? prefs;

  static Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  /*set getUserId value in SharedPreferences*/
  static Future<int> getUserId() async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    return prefs.getInt("userId") ?? 0;
  }

/*get getUserId value form SharedPreferences*/
  static setUserId(int userId) async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    print("userId    $userId");
    prefs.setInt("userId", userId);
  }

  /*set deviceId value in SharedPreferences*/
  static Future<String> getDeviceId() async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    return prefs.getString("deviceId") ?? "";
  }

  /*get deviceId value form SharedPreferences*/
  static setDeviceId(String deviceId) async {
    SharedPreferences   prefs = await SharedPreferences.getInstance();
    print("deviceId   $deviceId");
    prefs.setString("deviceId", deviceId);
  }
  /*set latitude value in SharedPreferences*/
  static Future<double> getLatitude() async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    return prefs.getDouble("latitude") ?? 0.0;
  }

  /*get latitude value form SharedPreferences*/
  static setLatitude(double latitude) async {
    SharedPreferences   prefs = await SharedPreferences.getInstance();
    print("latitude   $latitude");
    prefs.setDouble("latitude", latitude);
  }

  /*set Longitude value in SharedPreferences*/
  static Future<double> getLongitude() async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    return prefs.getDouble("longitude") ?? 0.0;
  }

  /*get getLongitude value form SharedPreferences*/
  static setLongitude(double longitude) async {
    SharedPreferences   prefs = await SharedPreferences.getInstance();
    print("longitude   $longitude");
    prefs.setDouble("longitude", longitude);
  }
  /*set getDeviceType value in SharedPreferences*/
  static Future<String> getDeviceType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id= Platform.isAndroid?"2":"1";
    return prefs.getString("deviceType") ?? id;
  }

/*get setDeviceType value form SharedPreferences*/
  static setDeviceType(String deviceType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("deviceType", deviceType);
  }

  /*set getDeviceType value in SharedPreferences*/
  static Future<String> getPushKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("pushkey") ?? "";
  }

/*get setDeviceType value form SharedPreferences*/
  static setPushKey(String pushkey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("pushkey   $pushkey");
    prefs.setString("pushkey", pushkey);
  }

  /*set dob value in SharedPreferences*/
  static Future<String> getDOB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("dob") ?? "";
  }

/*get dob value form SharedPreferences*/
  static setDOB(String dob) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("dob", dob);
  }

  /*set getAppVersion value in SharedPreferences*/
  static Future<String> getAppVersion() async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    return prefs.getString("appVersion") ?? "1.0.0";
  }

/*get setUserEmail value form SharedPreferences*/
  static setAppVersion(String appVersion) async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    print("appVersion   $appVersion");
    prefs.setString("appVersion", appVersion);
  }

  /*set getAppVersion value in SharedPreferences*/
  static Future<String> getSessionToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("sessionToken") ?? "";
  }

/*get setUserEmail value form SharedPreferences*/
  static setSessionToken(String sessionToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("sessionToken", sessionToken);
  }
  /*set getTempSessionToken value in SharedPreferences*/
  static Future<String> getTempSessionToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("tempSessionToken") ?? "";
  }

/*get setTempSessionToken value form SharedPreferences*/
  static setTempSessionToken(String tempSessionToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("tempSessionToken   $tempSessionToken");

    prefs.setString("tempSessionToken", tempSessionToken);
  }

  /*set completeStatus value in SharedPreferences*/
  static Future<int> getCompleteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("completeStatus") ?? 0;
  }

/*get completeStatus value form SharedPreferences*/
  static setCompleteStatus(int completeStatus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("completeStatus", completeStatus);
  }

  /*set deviceId value in SharedPreferences*/
  static Future<String> getGenderId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("genderId") ?? "";
  }

  /*get deviceId value form SharedPreferences*/
  static setGenderId(String genderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("genderId", genderId);
  }

  /*set setUserName value in SharedPreferences*/
  static Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userName") ?? "";
  }

  /*get setUserName value form SharedPreferences*/
  static setUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userName", userName);
  }
  /*set setUserName value in SharedPreferences*/
  static Future<String> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userProfile") ?? "";
  }

  /*get setUserName value form SharedPreferences*/
  static setUserProfile(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userProfile", userName);
  }

  /*set getAppVersion value in SharedPreferences*/
  static Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("email") ?? "";
  }

/*get setUserEmail value form SharedPreferences*/
  static setEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
  }

  /*set getSocialMediaId value in SharedPreferences*/
  static Future<String> getSocialMediaId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("socialMediaId") ?? "";
  }

/*get setSocialMediaId value form SharedPreferences*/
  static setSocialMediaId(String socialMediaId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("socialMediaId", socialMediaId);
  }

  /*set getPhone value in SharedPreferences*/
  static Future<String> getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("phone") ?? "";
  }

/*get setPhone value form SharedPreferences*/
  static setPhone(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("phone", phone);
  }

  /*set fbpKey value in SharedPreferences*/
  static Future<String> getFBPKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString("fbpKey") ?? '0';
  }

/*get fbpKey value form SharedPreferences*/
  static setFBPKey(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("fbpKey", key);
  }

/*set showChatNotification value in SharedPreferences*/
  static Future<bool> getShowChatNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool("ShowChatNotification") ?? true;
  }

/*get showChatNotification value form SharedPreferences*/
  static setShowChatNotification(bool key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("ShowChatNotification", key);
  }
  /*get SocialMediaId in shared preferences*/
  static getContent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString("strShareMsgContent");
  }
  /*set SocialMediaId in shared preferences*/
  static setContent(String strShareMsgContent) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("strShareMsgContent",strShareMsgContent);
  }

/*set showTypingStatusChat value in SharedPreferences*/
  static Future<bool> getTypingStatusChat() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool("ShowTypingStatusChat") ?? true;
  }

/*get showTypingStatusChat value form SharedPreferences*/
  static setTypingStatusChat(bool key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("ShowTypingStatusChat", key);
  }

  /*get setUserEmail value form SharedPreferences*/
  static setLocalDate(String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("date", date);
  }
  /*set getAppVersion value in SharedPreferences*/
  static Future<String> getLocalDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("date") ?? "${DateTime.now()}";
  }
  /*get setUserEmail value form SharedPreferences*/
  static setLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("language", language);
  }
  /*set getAppVersion value in SharedPreferences*/
  static Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("language") ?? "en";

  }

  //  get session token in shared preferences
  static Future<bool> getIsShowTutorialDashboard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isShowTutorial") ?? false;
  }

//  set session token in shared preferences
  static Future<bool> setIsShowTutorialDashboard(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("isShowTutorial", value);
  }

  //  get session token in shared preferences
  static Future<bool> getIsShowTutorialForSearch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isShowTutorialForSearch") ?? false;
  }

//  set session token in shared preferences
  static Future<bool> setIsShowTutorialForSearch(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("isShowTutorialForSearch", value);
  }

  //  get session token in shared preferences
  static Future<bool> getIsShowTutorialForHome() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isShowTutorialForHome") ?? false;
  }

//  set session token in shared preferences
  static Future<bool> setIsShowTutorialForHome(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("isShowTutorialForHome", value);
  }
  /*set setShowWifiEnable value in SharedPreferences*/
  static Future<bool> getShowWifiEnable() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("ShowWifiEnable") ?? false;
  }

/*get setShowWifiEnable value form SharedPreferences*/
  static setShowWifiEnable(bool key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("ShowWifiEnable", key);
  }
/*
  void changeLanguage(BuildContext context, String selectedLanguageCode) async {
    var _locale = await setLanguage(selectedLanguageCode);
    MyApp.setLocale(context, _locale);
  }
*/


  static clearAppPreference() async {
    prefs = await getInstance();
    prefs!.remove("userId");
    prefs!.remove("date");
    prefs!.remove("sessionToken");
    prefs!.remove("tempSessionToken");
    prefs!.remove("email");
    prefs!.remove("genderId");
    prefs!.remove("completeStatus");
    prefs!.remove("dob");
    prefs!.remove("phone");
    prefs!.remove("userName");
    prefs!.remove("socialMediaId");
    prefs!.remove("ShowWifiEnable");
  }
}
