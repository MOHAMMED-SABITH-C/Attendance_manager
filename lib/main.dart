// import 'dart:js';

import 'package:attendance/db_functions.dart';
import 'package:attendance/flrst.dart';
// import 'package:attendance/login.dart';
// import 'package:attendance/splash.dart';
// import 'package:attendance/todayClass.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initialize();
  runApp( attendance());
}

class attendance extends StatelessWidget {
   attendance({super.key});

    // Future<SharedPreferences> _shp= SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
        debugShowCheckedModeBanner:false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18))),
        backgroundColor: Colors.grey.withOpacity(0.8),
      ),
      ),
      home: const First(),
    );
  }
  
}
