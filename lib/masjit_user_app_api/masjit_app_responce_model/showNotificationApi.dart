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
  final String? payload = notificationResponse.payload;
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');

  if (notificationResponse.actionId == 'id_1') {
    FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_NONE);
  }

  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
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
        print('helppp: ${dndTime.difference(current)}');
        await AndroidAlarmManager.oneShot(
          dndTime.difference(current),
          i,
          () {
            FlutterDnd.setInterruptionFilter(
                FlutterDnd.INTERRUPTION_FILTER_ALL);
            notificationsPlugin.show(
              999999,
              'DND is Activated',
              'afalfhalfhalsdflalf',
              const NotificationDetails(
                android: AndroidNotificationDetails(
                  'Masjid',
                  'notify about azan',
                  ongoing: true,
                  actions: <AndroidNotificationAction>[
                    AndroidNotificationAction('id_1', 'Turn off'),
                  ],
                ),
              ),
            );
          },
          exact: true,
          allowWhileIdle: true,
        );
      }
    }
  }
}
