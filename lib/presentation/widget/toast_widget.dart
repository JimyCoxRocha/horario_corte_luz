import 'package:flutter/material.dart';

class ToastWidget {
  final BuildContext context;
  ToastWidget(this.context);

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> toast({
    required String message,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 4500),
      width: 280.0, // Width of the SnackBar.
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 12,
        bottom: 12,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ));
  }
}
