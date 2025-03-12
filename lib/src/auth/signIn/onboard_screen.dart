import 'package:TNJewellers/src/splash/controller/splash_controller.dart';
import 'package:TNJewellers/utils/colors.dart';
import 'package:TNJewellers/utils/core/helper/route_helper.dart';
import 'package:TNJewellers/utils/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void login() {
    if (_formKey.currentState!.validate()) {
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //       builder: (context) => MobileOtpPage()), // Ensure `MapPage` exists
      // );
      Get.toNamed(RouteHelper.getOtpVerifyRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //   isBackButtonExist: widget.fromPage == "splash" || widget.fromPage == "onboard" ? false : true,
      //   bgColor: Theme.of(context).cardColor,
      //   titleColor: Theme.of(context).textTheme.bodyLarge!.color,
      // ),
      body: GetBuilder<SplashController>(
        builder: (controller) {
          return Container(
            color: Theme.of(context).cardColor,
            child: Stack(
              children: [
                mainUI(context, controller),
                controller.isLoading
                    ? const LoadingIndicator()
                    : const SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget mainUI(BuildContext context, SplashController controller) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: Colors.indigo,
                    size: 24,
                  ),
                  hintText: 'Mobile Number',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  counterText: "",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mobile number';
                  } else if (value.length != 10) {
                    return 'Mobile number must be 10 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
