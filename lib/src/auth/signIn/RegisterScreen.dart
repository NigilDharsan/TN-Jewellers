import 'package:TNJewellers/src/auth/controller/auth_controller.dart';
import 'package:TNJewellers/utils/colors.dart';
import 'package:TNJewellers/utils/images.dart';
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

  Widget buildInputField(String hintName, String label,
      TextEditingController controller, String errorMsg,
      {bool isNumber = false, bool isEmail = false, bool isRequired = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Text(label.toUpperCase(),
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700])),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: TextFormField(
              controller: controller,
              keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
              validator: (value) {
                if (isRequired && (value == null || value.isEmpty))
                  return errorMsg;
                if (isEmail &&
                    !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}')
                        .hasMatch(value!)) return "Enter a valid email";
                return null;
              },
              decoration: customInputDecoration(hintName),
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration customInputDecoration(String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: brandGoldLightColor,
      hintText: hintText,
      hintStyle: TextStyle(color: brandGreySoftColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.white, width: 2), // White border
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.transparent, width: 2),
      ),
    );
  }
}
