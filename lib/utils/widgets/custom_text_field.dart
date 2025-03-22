import 'package:TNJewellers/utils/colors.dart';
import 'package:TNJewellers/utils/dimensions.dart';
import 'package:TNJewellers/utils/images.dart';
import 'package:TNJewellers/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool? isPassword;
  final bool? isVerify;
  final bool? isShowBorder;
  final bool? isAutoFocus;
  final Function(String)? onSubmit;
  final bool? isEnabled;
  final int? maxLines;
  final bool? isShowSuffixIcon;
  final TextCapitalization? capitalization;
  final Function(String text)? onChanged;
  final String? countryDialCode;
  final String? suffixIconUrl;
  final Widget? prefixIcon;
  final double? borderRadius;
  final Color? fillColor;
  final String? Function(String?)? onValidate;
  final bool? isVerifyEmail;
  final bool? isVerifyPhone;

  const CustomTextField({
    super.key,
    this.hintText = '',
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.isShowSuffixIcon = false,
    this.onSubmit,
    this.capitalization = TextCapitalization.none,
    this.isPassword = false,
    this.isShowBorder = false,
    this.isAutoFocus = false,
    this.countryDialCode,
    this.suffixIconUrl,
    this.onChanged,
    this.onValidate,
    this.prefixIcon,
    this.borderRadius = Dimensions.radiusSmall,
    this.fillColor,
    this.title,
    this.isVerify = false,
    this.isVerifyEmail = false,
    this.isVerifyPhone = false,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  _hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: JosefinSansRegular.copyWith(
          fontSize: Dimensions.fontSizeDefault,
          color: widget.isEnabled == false
              ? Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)
              : Theme.of(context).textTheme.bodyLarge!.color),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).hintColor,
      textCapitalization: widget.capitalization!,
      enabled: widget.isEnabled,
      autofocus: widget.isAutoFocus!,
      autofillHints: widget.inputType == TextInputType.name
          ? [AutofillHints.name]
          : widget.inputType == TextInputType.emailAddress
              ? [AutofillHints.email]
              : widget.inputType == TextInputType.phone
                  ? [AutofillHints.telephoneNumber]
                  : widget.inputType == TextInputType.streetAddress
                      ? [AutofillHints.fullStreetAddress]
                      : widget.inputType == TextInputType.url
                          ? [AutofillHints.url]
                          : widget.inputType == TextInputType.visiblePassword
                              ? [AutofillHints.password]
                              : null,
      obscureText: widget.isPassword! ? _obscureText : false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          borderSide: const BorderSide(style: BorderStyle.none, width: 0),
        ),
        isDense: true,
        filled: true,
        fillColor: widget.fillColor ?? Theme.of(context).cardColor,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        hintText: widget.hintText,
        hintStyle: JosefinSansRegular.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            color: brandPrimaryColor.withOpacity(0.5)
            //Theme.of(context).hintColor.withOpacity(Get.isDarkMode ? .5 : 1),
            ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword!
            ? IconButton(
                splashRadius: 20,
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: brandPrimaryColor),
                onPressed: _toggle,
              )
            : widget.isVerify!
                ? GestureDetector(
                    onTap: _verify,
                    child: Container(
                      width: 50,
                      height: 20,
                      margin: EdgeInsets.only(right: 5.0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Verify'.tr,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: buttonTextColor,
                        ),
                      ),
                    ),
                  )
                : null,
      ),
      onFieldSubmitted: (text) => widget.nextFocus != null
          ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : widget.onSubmit != null
              ? widget.onSubmit!(text)
              : null,
      onChanged: widget.onChanged,
      validator: widget.onValidate != null ? widget.onValidate! : null,
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _verify() {
    _hideKeyboard();
    if (widget.isVerifyEmail ?? false) {
      // Get.toNamed(RouteHelper.emailVerificationScreen);
    } else if (widget.isVerifyPhone ?? false) {
      // Get.toNamed(RouteHelper.verificationScreen);
    }
  }
}

//MARK LOCATION FIELD
Widget Mark_Location_Field(
    {TextEditingController? Controller,
    String? Function(String?)? validating,
    bool? isEnabled,
    void Function(String)? onChanged,
    required String hintText,
    List<TextInputFormatter>? inputFormatters,
    required TextInputType keyboardtype,
    FocusNode? focusNode}) {
  return Container(
    // height: 50,
    child: TextFormField(
      enabled: isEnabled,
      focusNode: focusNode,
      maxLength: 20,
      controller: Controller,
      textCapitalization: TextCapitalization.none,
      inputFormatters: inputFormatters,
      validator: validating,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        hintText: hintText,
        hintStyle: Mark_Hint_Style,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: textfieldFillColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: textfieldFillColor),
        ),
        fillColor: textfieldFillColor,
        filled: true,
        counterText: '',
      ),
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      style: Textfield_Style,
      keyboardType: keyboardtype,
    ),
  );
}

//COMMON TEXTFORM FIELD
Widget Common_TextForm_Field(
  context, {
  TextEditingController? Controller,
  String? Function(String?)? validating,
  bool? isEnabled,
  void Function(String)? onChanged,
  required String hintText,
  List<TextInputFormatter>? inputFormatters,
  required TextInputType keyboardtype,
  void Function()? onTapVerify,
  FocusNode? focusNode,
  required bool? isVerifyNeeded,
  bool? isDataVerified,
}) {
  return Container(
    child: TextFormField(
      enabled: isEnabled,
      focusNode: focusNode,
      controller: Controller,
      textCapitalization: TextCapitalization.none,
      inputFormatters: inputFormatters,
      validator: validating,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        hintText: hintText,
        hintStyle: Mark_Hint_Style,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: textfieldFillDisabledColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: textfieldFillDisabledColor),
        ),
        fillColor: textfieldFillColor,
        filled: true,
        suffixIcon: isVerifyNeeded == true
            ? GestureDetector(
                onTap: onTapVerify,
                child: Container(
                  width: 50,
                  height: 20,
                  margin: EdgeInsets.only(right: 5.0),
                  alignment: Alignment.centerRight,
                  child: isDataVerified == true
                      ? Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      : Text(
                          'verify'.tr,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: buttonTextColor,
                          ),
                        ),
                ),
              )
            : Container(
                width: 50,
                height: 20,
                margin: EdgeInsets.only(right: 5.0),
                alignment: Alignment.centerRight,
                child: isDataVerified == true
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : null,
              ),
      ),
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      style: Textfield_Style,
      keyboardType: keyboardtype,
    ),
  );
}

//TEXTFORMFIELD  WITH ICON

Widget Textfield_Icon(context,
    {required TextEditingController? controller, required IconData? icon}) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3), // Shadow color with opacity
          spreadRadius: 2.0, // The amount the shadow spreads
          blurRadius: 2.0, // The blur radius of the shadow
          offset: Offset(0, 2), // The position of the shadow
        ),
      ],
      border: Border.all(
        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.2),
      ),
      borderRadius:
          const BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall)),
    ),
    child: CustomTextField(
      // hintText: 'first_name'.tr,
      borderRadius: Dimensions.paddingSizeSmall,
      controller: controller,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault),
        child: Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.paddingSizeDefault,
            top: Dimensions.paddingSizeDefault,
            bottom: Dimensions.paddingSizeDefault,
          ),
          child: Icon(icon),
        ),
      ),
    ),
  );
}

//TEXTFORMFIELD WITH IMAGE
Widget Textfield_Img(
  BuildContext context, {
  TextEditingController? Controller,
  String? Function(String?)? validating,
  bool? isEnabled,
  void Function(String)? onChanged,
  required String hintText,
  List<TextInputFormatter>? inputFormatters,
  required TextInputType keyboardtype,
  void Function()? onTapVerify,
  FocusNode? focusNode,
  String? textFieldImg,
  bool? isSvg,
  bool? isIcon,
  IconData? icon,
  required bool? isVerifyNeeded,
  bool? isDataVerified,
  bool hasError = false, // Flag to track error state
}) {
  return Container(
    child: StatefulBuilder(builder: (context, setState) {
      return TextFormField(
        enabled: isEnabled,
        focusNode: focusNode,
        controller: Controller,
        textCapitalization: TextCapitalization.none,
        inputFormatters: inputFormatters,
        validator: (value) {
          if (validating != null) {
            return validating(value);
          } else if (value == "") {
            hasError = true; // No error, reset flag
          }

          return null;
        },
        autovalidateMode: AutovalidateMode
            .onUserInteraction, // Re-validate on user interaction
        decoration: InputDecoration(
          errorText:
              null, // Set errorText to an empty string to hide the message

          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          hintText: hintText,
          hintStyle: JosefinSansRegular.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            color: Theme.of(context)
                .hintColor
                .withOpacity(Get.isDarkMode ? .5 : 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: hasError ? Colors.red : textfieldFillDisabledColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: hasError ? Colors.red : textfieldFillDisabledColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: hasError ? Colors.red : textfieldFillDisabledColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: Colors.red), // Red border when there's an error
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: Colors.red), // Red border when there's an error
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color:
                    textfieldFillDisabledColor), // Normal border when focused
          ),
          fillColor: (isEnabled == null || isEnabled == true)
              ? textfieldFillColor
              : textfieldFillDisabledColor,
          filled: true,
          prefixIcon: isIcon == true
              ? Icon(icon)
              : Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.paddingSizeMint,
                    top: Dimensions.paddingSizeDefault,
                    bottom: Dimensions.paddingSizeDefault,
                  ),
                  child: isSvg == true
                      ? SvgPicture.asset(
                          textFieldImg ?? "",
                          color: Colors.black,
                        )
                      : Container(
                          height: 10,
                          width: 10,
                          child: Image.asset(
                            textFieldImg ?? "",
                          ),
                        ),
                ),
          suffixIcon: isVerifyNeeded == true
              ? GestureDetector(
                  onTap: onTapVerify,
                  child: Container(
                    width: 50,
                    height: 20,
                    margin: EdgeInsets.only(right: 5.0),
                    alignment: Alignment.centerRight,
                    child: isDataVerified == true
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              'verify'.tr,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            ),
                          ),
                  ),
                )
              : null,
        ),

        onChanged: (value) {
          // Trigger validation and UI changes when typing
          if (onChanged != null) onChanged(value);
          setState(() {}); // Refresh to update the border color when typing
        },
        textInputAction: TextInputAction.next,
        style: Textfield_Style,
        keyboardType: keyboardtype,
      );
    }),
  );
}

//POP UP FIELD
Widget POP_up_TextField(
  BuildContext context, {
  TextEditingController? Controller,
  String? Function(String?)? validating,
  bool? isEnabled,
  void Function(String)? onChanged,
  required String hintText,
  List<TextInputFormatter>? inputFormatters,
  required TextInputType keyboardtype,
  FocusNode? focusNode,
}) {
  return Container(
    height: 25,
    child: StatefulBuilder(builder: (context, setState) {
      return TextFormField(
        enabled: isEnabled,
        focusNode: focusNode,
        controller: Controller,
        textCapitalization: TextCapitalization.none,
        inputFormatters: inputFormatters,
        validator: (value) {
          if (validating != null) {
            return validating(value);
          }
          return null;
        },
        autovalidateMode: AutovalidateMode
            .onUserInteraction, // Re-validate on user interaction
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          hintText: hintText,
          hintStyle: Mark_Hint_Style,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color.fromRGBO(226, 219, 201, 1)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color.fromRGBO(226, 219, 201, 1)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
                color: Colors.red), // Red border when there's an error
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
                color: Colors.red), // Red border when focused on error
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
                color: Color.fromRGBO(
                    226, 219, 201, 1)), // Normal border when focused
          ),
          fillColor: Color.fromRGBO(226, 219, 201, 1),
          filled: true,
        ),
        onChanged: (value) {
          // Trigger validation and UI changes when typing
          if (onChanged != null) onChanged(value);
          setState(() {}); // Refresh to update the border color when typing
        },
        textInputAction: TextInputAction.next,
        style: Textfield_Style2,
        keyboardType: keyboardtype,
      );
    }),
  );
}

//PASSWORD TEXTFORMFIELD
Widget textFieldPassword(
    {TextEditingController? Controller,
    String? Function(String?)? validating,
    void Function(String)? onChanged,
    required bool obscure,
    required void Function()? onPressed,
    FocusNode? focusNode,
    required TextInputType keyboardtype}) {
  return Container(
    // height: 50,
    child: TextFormField(
      controller: Controller,
      obscureText: obscure,
      validator: validating,
      focusNode: focusNode,
      textCapitalization: TextCapitalization.words,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textfieldFillDisabledColor),
            borderRadius: BorderRadius.circular(25)),
        prefixIcon: Padding(
            padding: const EdgeInsets.only(
              left: Dimensions.paddingSizeMint,
            ),
            child: Image.asset(
              Images.keyPng,
            )),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey.shade800,
          ),
          onPressed: onPressed,
        ),
        fillColor: textfieldFillColor,
        filled: true,
      ),
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardtype,
      style: Textfield_Style,
    ),
  );
}

//SIGN IN TEXTFORM FIELD
Widget SignIn_TextForm_Field(
  context, {
  TextEditingController? Controller,
  String? Function(String?)? validating,
  bool? isEnabled,
  void Function(String)? onChanged,
  required String hintText,
  List<TextInputFormatter>? inputFormatters,
  required TextInputType keyboardtype,
  FocusNode? focusNode,
  String? textFieldImg,
}) {
  return Container(
    child: StatefulBuilder(builder: (context, setState) {
      return TextFormField(
        enabled: isEnabled,
        focusNode: focusNode,
        controller: Controller,
        textCapitalization: TextCapitalization.none,
        inputFormatters: inputFormatters,
        validator: (value) {
          if (validating != null) {
            return validating(value);
          }
          return null;
        },
        autovalidateMode: AutovalidateMode
            .onUserInteraction, // Re-validate on user interaction
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          hintText: hintText,
          hintStyle: JosefinSansRegular.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            color: brandPrimaryColor.withOpacity(0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: Colors.red), // Red border when there's an error
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: Colors.red), // Red border when focused on error
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: Colors.grey.shade200), // Normal border when focused
          ),
          fillColor: textfieldFillColor,
          filled: true,
          prefixIcon: Padding(
            padding:
                const EdgeInsets.only(right: Dimensions.paddingSizeDefault),
            child: Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.paddingSizeDefault,
                // top: 2.0,
                // bottom: 2.0,
              ),
              child: SvgPicture.asset(
                textFieldImg ?? "",
                color: brandPrimaryColor.withOpacity(0.5),
              ),
            ),
          ),
        ),
        onChanged: (value) {
          // Trigger validation and UI changes when typing
          if (onChanged != null) onChanged(value);
          setState(() {}); // Refresh to update the border color when typing
        },
        textInputAction: TextInputAction.next,
        style: Textfield_Style,
        keyboardType: keyboardtype,
      );
    }),
  );
}

Widget signInPassword(context,
    {TextEditingController? Controller,
    String? Function(String?)? validating,
    void Function(String)? onChanged,
    required bool obscure,
    required void Function()? onPressed,
    required String hintText,
    FocusNode? focusNode,
    required TextInputType keyboardtype}) {
  return Container(
    // height: 50,
    child: TextFormField(
      controller: Controller,
      obscureText: obscure,
      validator: validating,
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        hintText: hintText,
        hintStyle: JosefinSansRegular.copyWith(
          fontSize: Dimensions.fontSizeDefault,
          color: brandPrimaryColor.withOpacity(0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(25)),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault),
          child: Padding(
            padding: const EdgeInsets.only(
              left: Dimensions.paddingSizeDefault,
              top: Dimensions.paddingSizeSmall,
              bottom: Dimensions.paddingSizeSmall,
            ),
            child: Icon(
              Icons.key,
              color: brandPrimaryColor.withOpacity(0.5),
            ),
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: brandPrimaryColor.withOpacity(0.5),
          ),
          onPressed: onPressed,
        ),
        fillColor: textfieldFillColor,
        filled: true,
      ),
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardtype,
      style: Textfield_Style,
    ),
  );
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
