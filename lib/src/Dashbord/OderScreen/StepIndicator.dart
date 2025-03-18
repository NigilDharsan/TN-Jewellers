import 'package:flutter/material.dart';
import 'package:TNJewellers/utils/colors.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;

  const StepIndicator({Key? key, required this.currentStep}) : super(key: key);

  Widget stepCircle(int step) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: currentStep >= step ? brandPrimaryColor : Colors.grey,
      child: Text('$step', style: TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        stepCircle(1),
        Expanded(
          child: Container(
            height: 2,
            color: currentStep >= 2 ? brandPrimaryColor : Colors.grey,
          ),
        ),
        stepCircle(2),
        Expanded(
          child: Container(
            height: 2,
            color: currentStep >= 3 ? brandPrimaryColor : Colors.grey,
          ),
        ),
        stepCircle(3),
      ],
    );
  }
}
