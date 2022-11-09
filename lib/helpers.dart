import 'package:flutter/material.dart';

bool isNumeric(String s) => s.isNotEmpty && double.tryParse(s) != null;

Future generalDialog({required Widget child,required BuildContext context}) async{
  return await showGeneralDialog(
      barrierDismissible: false,
      barrierLabel: "Barrier",
      context: context,
      pageBuilder: (_, __, ___) {
        return child;
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      });
}
