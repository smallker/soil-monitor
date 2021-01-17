import 'package:air_quality/ui/android/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'widgets/my_colors.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var initializationSettingsAndroid = AndroidInitializationSettings('icon');
  await flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(
      android: initializationSettingsAndroid,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pemadam Kebakaran',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: MyColors.embers,
      ),
      home: HomePage(),
    );
  }
}
