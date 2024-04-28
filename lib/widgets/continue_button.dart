// lib/widgets/continue_button

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ui/LoginUi.dart';

class BuildContinueButton extends StatelessWidget {
  late final int currpageindx;
  final PageController pageController;
  final void Function() onPressed;
  BuildContinueButton({
    Key? key,
    required this.currpageindx,
    required this.pageController,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: onPressed,
        /* onPressed: () {
          if (currpageindx == 0) {
            pageController.animateToPage(1,
                duration: Duration(microseconds: 300), curve: Curves.easeIn);
            currpageindx += 1;
          } else if (currpageindx == 1) {
            pageController.animateToPage(2,
                duration: Duration(microseconds: 300), curve: Curves.easeIn);
            currpageindx += 1;
          } else {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginUi()));
          }

          print(currpageindx);
        }, */
        child: Text(
          "Continue",
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }
}


// Widget BuildContinueButton(int currpageindx , PageController pageController) {
//   return
// }