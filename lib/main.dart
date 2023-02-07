

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/components/notifications.dart';
import 'package:todo/home.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';



void main() {



  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.initNotification();
  NotificationService.notificationDetails();



  // AwesomeNotifications().setListeners(onActionReceivedMethod: (receivedAction) {
  //   return Future.delayed(Duration( seconds: 3) );
  // },);
  // AwesomeNotifications().initialize
  //   (
  //     'resource://drawable/ic_stat_today',
  //   [
  //     NotificationChannel(channelKey: "Key", channelName: "ToDo", channelDescription: "your task is TIME-OUT check it now" ,
  //
  //         channelShowBadge: true,defaultColor: Color(0xFF9D50DD),ledColor: Colors.white )
  //
  //   ],
  //   debug: true ,
  // );


  runApp(ToDo()) ;

}

class ToDo extends StatelessWidget {
  @override


  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.deepPurpleAccent,

          )
        ),
        textTheme: TextTheme(

          bodyText2: TextStyle(color: Colors.purple)
        )
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
      splash: Image ( image: AssetImage('image/logo.png')),
      nextScreen: homepage(),
      splashTransition: SplashTransition.fadeTransition,
        splashIconSize: 150.0,




    )
    // homepage() ,
    );
  }
}