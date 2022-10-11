// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/subjects.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
//
// /*
// class NotificationApi {
//
//   static final _notification = FlutterLocalNotificationsPlugin();
//   static final onNotification = BehaviorSubject<String?>();
//
//
//   static Future init({bool initSchedule = false}) async{
//
//     final android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     final iOS = IOSInitializationSettings();
//     final settings = InitializationSettings(android: android, iOS: iOS);
//
//     await _notification.initialize(
//       settings,
//       onSelectNotification: (payload) async{
//         onNotification.add(payload);
//     }
//     );
//   }
//
//
//   static Future _notificationDetails() async{
//     return const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'channel id',
//             'channel name',
//             channelDescription: 'channel description',
//             importance: Importance.max,
//           ),
//
//     );
//   }
//
//   static void showScheduleNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     required String payload,
//     required DateTime scheduledData,
//   }) async =>
//       _notification.zonedSchedule(
//           id,
//           title,
//           body,
//           tz.TZDateTime.from(scheduledData, tz.local),
//           await _notificationDetails(),
//           payload:payload, androidAllowWhileIdle: true,
//           uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
// }*/
//
// class LocalNotificationService {
//
//   LocalNotificationService();
//
//   final _localNotificationService = FlutterLocalNotificationsPlugin();
//   var time = Time(05, 0, 0);
//   final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();
//
//   Future<void> intialize() async {
//     tz.initializeTimeZones();
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     IOSInitializationSettings iosInitializationSettings =
//         IOSInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     );
//
//     final InitializationSettings settings = InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );
//
//     await _localNotificationService.initialize(
//       settings,
//       onSelectNotification: onSelectNotification,
//     );
//   }
//
//   Future<NotificationDetails> _notificationDetails() async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('channel_id', 'channel_name',
//             channelDescription: 'description',
//             importance: Importance.max,
//             priority: Priority.max,
//             color: Colors.red,
//             enableLights: true,
//             icon: '@mipmap/ic_launcher',
//             largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
//             playSound: true);
//
//     const IOSNotificationDetails iosNotificationDetails =
//         IOSNotificationDetails();
//
//     return const NotificationDetails(
//       android: androidNotificationDetails,
//       iOS: iosNotificationDetails,
//     );
//   }
//
//   Future<void> imageNotification() async {
//     var bigPicture = BigPictureStyleInformation(
//         DrawableResourceAndroidBitmap("ic_launcher"),
//         largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
//         contentTitle: "Demo image notification",
//         summaryText: "This is some text",
//         htmlFormatContent: true,
//         htmlFormatContentTitle: true);
//   }
//
//   Future<void> showNotification({
//     required int id,
//     required String title,
//     required String body,
//   }) async {
//     final details = await _notificationDetails();
//
//     await _localNotificationService.show(id, title, body, details);
//   }
//
//   Future<void> showScheduleNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     required String payload,
//     required DateTime scheduledData,
//   }) async =>
//      await _localNotificationService.schedule(
//           id,
//           title,
//           body,
//           scheduledData,
//           await _notificationDetails(),
//           payload:payload, androidAllowWhileIdle: true
//      );
//
//   Future<void> showNotificationWithPayload(
//       {required int id,
//       required String title,
//       required String body,
//       required String payload}) async {
//     final details = await _notificationDetails();
//     print("hhhhss ${_localNotificationService} ");
//     await _localNotificationService.show(id, title, body, details,
//         payload: payload);
//   }
//
//   void onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) {
//     print('id $id');
//   }
//
//   void onSelectNotification(String? payload) {
//     print('payload $payload');
//     if (payload != null && payload.isNotEmpty) {
//       onNotificationClick.add(payload);
//     }
//   }
// }
