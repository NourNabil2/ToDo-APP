import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';




class NotificationService {


  static Future initNotification() async {


    final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

     const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

     const String portName = 'notification_send_port';

    var initializationSettings = AndroidInitializationSettings('ic_stat_today');

    final setting = InitializationSettings(android: initializationSettings);
    await _notification.initialize(setting);
  }


  static final _notification = FlutterLocalNotificationsPlugin();




  static Future showNotification( id , title , body ,  mon ,  year , day , hour , min) async
  {

    _notification.schedule(id, title, body ,DateTime(year ,mon ,day ,hour ,min  ), await notificationDetails() ,androidAllowWhileIdle: true ,);
    //  _notification.show(id, title, body ,await notificationDetails());

  }
  static Future CanceleNotification( id ) async
  {
    _notification.cancel(id);

  }


  static notificationDetails() async {
    return NotificationDetails(android: AndroidNotificationDetails('channelId', 'channelName' , importance: Importance.max , color: Colors.deepPurple , enableVibration: true ,)  );
  }



}