import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TNJewellers/src/auth/controller/auth_controller.dart';
import 'package:TNJewellers/src/auth/repository/auth_repo.dart';
import 'package:TNJewellers/utils/core/helper/route_helper.dart';

import '../../../utils/overlay_loader_with_app_icon.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  // late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    // bool firstTime = true;
    // _onConnectivityChanged = Connectivity()
    //     .onConnectivityChanged
    //     .listen((List<ConnectivityResult> results) {
    //   if (!firstTime) {
    //     bool isNotConnected = !results.contains(ConnectivityResult.wifi) &&
    //         !results.contains(ConnectivityResult.mobile);

    //     if (!isNotConnected) {
    //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //     }

    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         backgroundColor: isNotConnected ? Colors.red : Colors.green,
    //         duration: Duration(seconds: isNotConnected ? 6000 : 3),
    //         content: Text(
    //           isNotConnected ? 'no_connection' : 'connected',
    //           textAlign: TextAlign.center,
    //         ),
    //       ),
    //     );

    //     if (!isNotConnected) {
    //       _route();
    //     }
    //   }
    //   firstTime = false;
    // }) as StreamSubscription<ConnectivityResult>;

    // Get.find<SplashController>().initSharedData();
    _route();
  }

  @override
  void dispose() {
    super.dispose();
    // _onConnectivityChanged.cancel();
  }

  void _route() async {
    // Get.find<SplashController>().getConfigData().then((value) {
    Timer(const Duration(seconds: 2), () async {
      if (Get.find<AuthController>().isLoggedIn()) {
        Get.offAllNamed(RouteHelper.getSignInRoute());
        SingleTon().LoginType == 'supplier';
      } else {
        Get.offAllNamed(RouteHelper.getSignInRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OverlayLoaderWithAppIcon(
      isLoading: true,
      overlayOpacity: 0,
      child: Scaffold(
        key: _globalKey,
        backgroundColor: Theme.of(context).cardColor,
        body: Stack(
          children: [
            Container(),
            // Center(
            //   child: Padding(
            //     padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Image.asset(
            //           Images.logo, // Replace with your image asset path
            //           width: 200.0, // Set the width of the image
            //           height: 200.0, // Set the height of the image
            //         ),
            //         // SvgPicture.asset(
            //         //   Images.splash,
            //         //   // color: Colors.white,
            //         //   width: MediaQuery.of(context).size.width / 2.2,
            //         // ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class SplashCustomPainter extends CustomPainter {
  final BuildContext? context;

  SplashCustomPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Paint leftCorner = Paint();
    leftCorner.color = Theme.of(context!).primaryColor.withOpacity(.3);
    Path path = Path();
    path.lineTo(0, 170);
    //Added this line
    path.relativeQuadraticBezierTo(100, -20, 110, -170);
    canvas.drawPath(path, leftCorner);
    Paint paint = Paint();

    // Path number 3
    paint.color = Theme.of(context!).primaryColor.withOpacity(.3);
    path = Path();
    path.lineTo(size.width, size.height / 3);
    path.cubicTo(size.width * 1.8, size.height * 0.5, size.width / 2,
        size.height, size.width / .99, size.height);
    path.cubicTo(size.width, 10, size.width, size.height / 10, size.width,
        size.height / 3);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SplashCustomPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(SplashCustomPainter oldDelegate) => false;
}
