import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget wrapWithPopScope(Widget child) {
  return PopScope(
    canPop: false,
    onPopInvoked: (didPop) {
      if (didPop) {
        return;
      }
      SystemNavigator.pop();
    },
    child: child,
  );
}