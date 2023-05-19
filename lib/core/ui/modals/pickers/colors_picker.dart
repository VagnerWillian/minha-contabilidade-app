import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import '../../../core.dart';

class ColorsPickerDialog {
  static Future<Color> show(Color selectedColor) async {
    Color updatedColor = selectedColor;
    return await CustomDialog.show(
          borderRadius: 20,
          padding: EdgeInsets.zero,
          content: SizedBox(
            width: 300,
            child: IntrinsicHeight(
              child: Column(
                children: [
                  MaterialPicker(
                    enableLabel: true,
                    pickerColor: selectedColor,
                    onColorChanged: (Color? color) => updatedColor = color!,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: CustomRectangleButton(
                      background: Colors.transparent,
                      size: const Size(double.nan, 60),
                      onPressed: () {
                        print(updatedColor.value);
                        print(selectedColor.value);
                        Get.back(result: updatedColor);
                      },
                      label: 'CONFIRMAR',
                      labelStyle: ThemeAdapter(Get.context!).bodySmall.copyWith(
                        color: ThemeAdapter(Get.context!).customColors.black
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ) ??
        selectedColor;
  }
}
