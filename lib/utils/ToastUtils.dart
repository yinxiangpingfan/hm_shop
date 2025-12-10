import 'package:flutter/material.dart';

//阀门控制
class Toastutils {
  static bool showToast = false;
  static void showTxt(BuildContext context, String message) {
    if (showToast) return;
    showToast = true;
    Future.delayed(Duration(seconds: 3), () {
      showToast = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 120,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        content: Text(message, textAlign: TextAlign.center),
      ),
    );
  }
}
