import 'package:calculatebmitest/Screens/resultat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Screens/main_page.dart';
import 'package:calculatebmitest/Controller/binding/BmiBinding.dart';

void main() async {
  await GetStorage.init();
  runApp(GetMaterialApp(
    initialRoute: "/mainPage",
    getPages: [
      GetPage(name: '/mainPage', page: () => MainPage()),
      GetPage(
          name: '/resultatPage',
          page: () => ResultatPage(),
          binding: BmiBinding())
    ],
  ));
}
