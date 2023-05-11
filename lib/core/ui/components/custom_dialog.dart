import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  static Future show<T>({
    required Widget content,
    Size? size,
    double? borderRadius,
    EdgeInsets? padding,
    bool isDismissible = false
  }) async {
    return await showDialog(
      barrierDismissible: isDismissible,
      context: Get.context!,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
        ),
        child: Container(
          padding: padding ?? const EdgeInsets.all(18),
          width: size?.width,
          height: size?.height,
          child: content,
        ),
      ),
    );
  }
}
