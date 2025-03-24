import 'package:TNJewellers/src/auth/controller/auth_controller.dart';
import 'package:TNJewellers/utils/colors.dart';
import 'package:TNJewellers/utils/images.dart';
import 'package:TNJewellers/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 50),
                Image.asset(Images.logoPng, height: 100),
                SizedBox(height: 20),
                Text("REGISTER NOW",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800])),
                SizedBox(height: 30),
                Form(
                  key: controller.formKeySignUP,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInputField('Name', "Your Name *",
                          controller.nameController, "Please enter your name"),
                      SizedBox(height: 20),
                      buildInputField(
                          'Company',
                          "Company Name *",
                          controller.companyController,
                          "Please enter your company name"),
                      SizedBox(height: 20),
                      buildInputField(
                          'PAN',
                          "PAN NUMBER *",
                          controller.panController,
                          "Please enter your pan number"),
                      SizedBox(height: 20),
                      buildInputField(
                          'GST',
                          "GST NUMBER *",
                          controller.gstController,
                          "Please enter your gst number"),
                      SizedBox(height: 20),
                      buildInputField(
                          'Mobile',
                          "Your Mobile No *",
                          controller.mobileController,
                          "Please enter a valid mobile number",
                          isNumber: true),
                      SizedBox(height: 20),
                      buildInputField('Email', "Email",
                          controller.emailController, "Enter a valid email",
                          isEmail: true, isRequired: false),
                      SizedBox(height: 20),
                      buildInputField(
                          'Password',
                          "Password *",
                          controller.passwordController,
                          "Please enter your password"),
                      SizedBox(height: 20),
                      buildInputField(
                          'Password',
                          "Confirm Password *",
                          controller.confirmPasswordController,
                          "Please enter your confirm password"),
                      SizedBox(height: 30),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: brandPrimaryColor,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              if (controller.formKeySignUP.currentState!
                                  .validate()) {
                                // Perform register action
                                controller.signupVerification();
                              }
                            },
                            child: Text(
                              'REGISTER NOW',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
