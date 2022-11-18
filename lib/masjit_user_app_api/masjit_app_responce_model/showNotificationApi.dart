/*
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/notice_response_model.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@pragma('vm:entry-point')
void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  if (notificationResponse.actionId == 'id_1') {
    FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALL);
  }
}

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static final NotificationService _notificationService =
  NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('logo');

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse:
      onDidReceiveNotificationResponse,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  static Future<List<WeeklyNamaz>> getNamazTimes() async {
    final file = File('/data/data/com.azanforsalah.user/app_flutter/time.json');

    final namazJson = jsonDecode(file.readAsStringSync());
    return List<WeeklyNamaz>.from(
        namazJson.map((x) => WeeklyNamaz.fromJson(x)));
  }

  static Future<void> scheduleNextNotification() async {
    log('FINAL DND next next');
    await scheduleNotifications();
  }

  static Future<void> callback() async {
    FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_NONE);
    NotificationService().notificationsPlugin.show(
      999999,
      'DND is Activated',
      'Turn off DND after Namaz Completed',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'Masjid',
          'notify about azan',
          ongoing: true,
          autoCancel: false,
          actions: <AndroidNotificationAction>[
            AndroidNotificationAction('id_1', 'Turn off'),
          ],
        ),
      ),
    );
  }

  static Future<void> scheduleNotifications() async {
    final namaz = await getNamazTimes();

    DateTime current = DateTime.now();
    DateTime nextScheduleTime = DateTime.now();

    await NotificationService().notificationsPlugin.cancelAll();

    tz.initializeTimeZones();
    int notificationId = 456;
    int schedule = 123;

    for (int i = 0; i < namaz.length; i++) {
      DateTime notificationTime = DateFormat.jm().parse(namaz[i].azan!);
      DateTime dndTime = DateFormat.jm().parse(namaz[i].jammat!);
      notificationTime = DateTime(
        current.year,
        current.month,
        current.day,
        notificationTime.hour,
        notificationTime.minute,
      );
      dndTime = DateTime(
        current.year,
        current.month,
        current.day,
        dndTime.hour,
        dndTime.minute,
      );

      if (i < 4) {
        DateTime nextNotificationTime = DateFormat.jm().parse(namaz[i + 1].azan!);
        nextScheduleTime = DateTime(
          current.year,
          current.month,
          current.day,
          nextNotificationTime.hour,
          nextNotificationTime.minute,
        ).subtract(Duration(minutes: 1));
      }

      bool shouldSchedule = notificationTime.isAfter(current);

      if (shouldSchedule) {
        log('FINAL DND: Notify on $notificationTime');
        await NotificationService().notificationsPlugin.zonedSchedule(
          notificationId++,
          'Azan Time',
          '',
          tz.TZDateTime.from(notificationTime, tz.local),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'Masjid',
              'notify about azan',
            ),
          ),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
        );

        log('FINAL DND: DND activate on $dndTime');

        await AndroidAlarmManager.oneShot(
          dndTime.difference(current),
          schedule++,
          callback,
          exact: true,
          allowWhileIdle: true,
        );

        log('FINAL DND: scheduleNextNotification on $nextScheduleTime');

        if(i == 4) {
          DateTime nextNotificationTime = DateFormat.jm().parse(namaz[1].azan!);
          current = current.add(Duration(minutes:1));
          nextScheduleTime = DateTime(
            current.year,
            current.month,
            current.day,
            nextNotificationTime.hour,
            nextNotificationTime.minute,
          );
        }

        await AndroidAlarmManager.oneShot(
          nextScheduleTime.difference(current),
          schedule,
          scheduleNextNotification,
          exact: true,
          allowWhileIdle: true,
        );

        break;
      }
    }
  }
}
*/
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/notice_response_model.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../SharePreferenceClass.dart';

@pragma('vm:entry-point')
void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  if (notificationResponse.actionId == 'id_1') {
    FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALL);
  }
}

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static final NotificationService _notificationService =
  NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('logo');

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse:
      onDidReceiveNotificationResponse,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  static Future<List<WeeklyNamaz>> getNamazTimes() async {
    final file = File('/data/data/com.azanforsalah.user/app_flutter/time.json');

    final string = file.readAsStringSync();


    if(string.isEmpty || string == '[]') {
      log('no time');
      return [];
    }

      final namazJson = jsonDecode(string);
      return List<WeeklyNamaz>.from(
          namazJson.map((x) => WeeklyNamaz.fromJson(x)));

  }

  static Future<void> scheduleNextNotification() async {
    log('FINAL DND next next');
    await scheduleNotifications();
  }

  static Future<void> callback() async {
    FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_NONE);
    NotificationService().notificationsPlugin.show(
      999999,
      'DND is Activated',
      'Turn off DND after Namaz Completed',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'Masjid',
          'notify about azan',
          ongoing: true,
          autoCancel: false,
          actions: <AndroidNotificationAction>[
            AndroidNotificationAction('id_1', 'Turn off'),
          ],
        ),
      ),
    );
  }

  static Future<void> scheduleNotifications() async {
    final namaz = await getNamazTimes();

    DateTime current = DateTime.now();
    DateTime nextScheduleTime = DateTime.now();

    await NotificationService().notificationsPlugin.cancelAll();


    int notificationId = 456;
    int schedule = 123;

    for (int i = 0; i < namaz.length; i++) {
      DateTime notificationTime = DateFormat.jm().parse(namaz[i].azan!);
      DateTime dndTime = DateFormat.jm().parse(namaz[i].jammat!);

      notificationTime = DateTime(
        current.year,
        current.month,
        current.day,
        notificationTime.hour,
        notificationTime.minute,
      );
      dndTime = DateTime(
        current.year,
        current.month,
        current.day,
        dndTime.hour,
        dndTime.minute,
      );

      bool shouldSchedule = notificationTime.isAfter(current);

      log('notification ${i+1}');
      log('FINAL DND: Notify on $notificationTime');

      log('FINAL DND: notificationTime.isAfter ${notificationTime.isAfter(current)}');

      tz.initializeTimeZones();
      if (shouldSchedule) {


        await NotificationService().notificationsPlugin.zonedSchedule(
          notificationId++,
          'Azan Time',
          '',
          tz.TZDateTime.from(notificationTime, tz.local),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'Masjid',
              'notify about azan',
            ),
          ),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
        );

        log('FINAL DND: DND activate on $dndTime');

        await AndroidAlarmManager.oneShot(
          dndTime.difference(current),
          schedule++,
          callback,
          exact: true,
          allowWhileIdle: true,
        );
        DateTime nextNotificationTime =
        DateFormat.jm().parse(namaz[(i + 1) % 5].azan!);

        final day = (i == 4) ? (current.day + 1) : current.day;

        log('FINAL DND: day $day');

        nextScheduleTime = DateTime(
          current.year,
          current.month,
          day,
          nextNotificationTime.hour,
          nextNotificationTime.minute,
        ).subtract(Duration(minutes: 1));

        AppPreferences.setSchedule(schedule);

        log('FINAL DND: scheduleNextNotification on $nextScheduleTime');

        await AndroidAlarmManager.oneShot(
          nextScheduleTime.difference(current),
          schedule,
          scheduleNextNotification,
          exact: true,
          allowWhileIdle: true,
        );

        break;
      }
    }
  }
}
