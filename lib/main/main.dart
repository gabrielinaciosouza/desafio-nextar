import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './factories/pages/pages.dart';

import '../ui/components/components.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return GetMaterialApp(
      title: 'Desafio Nextar',
      theme: makeAppTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: makeSplashPage, transition: Transition.fade),
        GetPage(
            name: '/login', page: makeLoginPage, transition: Transition.fadeIn),
        GetPage(
            name: '/home', page: makeHomePage, transition: Transition.fadeIn),
        GetPage(
            name: '/product/:productCode/edit',
            page: makeProductPage,
            transition: Transition.fadeIn),
        GetPage(
            name: '/product/new',
            page: makeProductPage,
            transition: Transition.fadeIn),
      ],
    );
  }
}
