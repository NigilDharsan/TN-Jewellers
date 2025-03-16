import 'dart:io';
import 'dart:ui';

import 'package:TNJewellers/Utils/core/helper/route_helper.dart';
import 'package:TNJewellers/Utils/core/initial_binding/initial_binding.dart';
import 'package:TNJewellers/src/splash/controller/splash_controller.dart';
import 'package:TNJewellers/utils/app_constants.dart';
import 'package:TNJewellers/utils/core/theme/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'utils/core/theme/dark_theme.dart';
import 'utils/core/theme/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initControllers();

  await GetStorage.init();
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  // final String? bookingID;
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    print("object");
  }

  @override
  void dispose() {
    // Clean up lifecycle observer when widget is disposed
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<SplashController>(builder: (splashController) {
        return GetMaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
          ),
          initialBinding: InitialBinding(),
          theme: themeController.darkTheme ? dark : light,
          initialRoute: RouteHelper.getSplashRoute(),
          getPages: RouteHelper.routes,
          // defaultTransition: Transition.topLevel,
          // transitionDuration: const Duration(milliseconds: 500),
          builder: (context, child) {
            return Stack(
              children: [
                child!,
                // Loader(), // Add the Loader widget here
              ],
            );
          },
        );
      });
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
