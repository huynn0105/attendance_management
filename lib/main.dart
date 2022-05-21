import 'package:attendance_management/provider/admin_provider.dart';
import 'package:attendance_management/provider/home_provider.dart';
import 'package:attendance_management/screens/admin/admin_attendance_screen/admin_attendance_screen.dart';
import 'package:attendance_management/screens/admin/admin_home_screen/admin_home_screen.dart';
import 'package:attendance_management/screens/home_screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'screens/admin/login_screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<AdminProvider>(create: (_) => AdminProvider()),
      ],
      child: MaterialApp(
        title: 'Attendance Management System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
