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

  Future<void> scheduleNotifications({
    required List<WeeklyNamaz> times,
  }) async {
    DateTime current = DateTime.now();

    await notificationsPlugin.cancelAll();

    tz.initializeTimeZones();
    int i = 1;
    for (WeeklyNamaz time in times) {
      DateTime notificationTime = DateFormat.jm().parse(time.azan!);
      DateTime dndTime = DateFormat.jm().parse(time.jammat!);
      notificationTime = DateTime(current.year, current.month, current.day,
          notificationTime.hour, notificationTime.minute);
      dndTime = DateTime(current.year, current.month, current.day, dndTime.hour,
          dndTime.minute);
      bool shouldSchedule = notificationTime.isAfter(current);

      if (shouldSchedule) {
        await notificationsPlugin.zonedSchedule(
          i++,
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
        await AndroidAlarmManager.oneShot(
          dndTime.difference(current),
          i,
          callback,
          exact: true,
          allowWhileIdle: true,
        );
      }
    }
  }
}

Future<void> callback() async {
  FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_NONE);
  NotificationService().notificationsPlugin.show(
        999999,
        'DND is Activated',
        'Turn of DND after Namaz Completed',
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
