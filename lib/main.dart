import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/home.dart';
import 'repository/db_repository.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DBRepository.instance.init();
    return GetMaterialApp(
      title: 'Money Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Poppins",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MoneyHomePage(),
    );
  }
}
