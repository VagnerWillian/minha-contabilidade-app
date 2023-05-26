import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';

class CustomQuestionModal {
  static Future<bool> show({
    String title = 'Tem certeza?',
    String subtitle = 'Tem certeza que deseja realizar esta ação?',
  }) async {
    return await CustomDialog.show(
      borderRadius: 10,
      content: CustomQuestion._(title, subtitle),
    )??false;
  }
}

class CustomQuestion extends StatefulWidget {
  final String title, subtitle;
  const CustomQuestion._(this.title, this.subtitle);

  @override
  State<CustomQuestion> createState() => _CustomQuestionState();
}

class _CustomQuestionState extends State<CustomQuestion> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: ThemeAdapter(context).displayLarge,
            ),
            Text(
              widget.subtitle,
              style: ThemeAdapter(context).bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomRectangleButton(
                    size: const Size(double.nan, 60),
                    onPressed: () => Get.back(result: true),
                    label: 'Sim'
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomRectangleButton(
                      size: const Size(double.nan, 60),
                      background: Colors.transparent,
                      labelStyle: ThemeAdapter(context).displaySmall,
                      onPressed: () => Get.back(result: false),
                      label: 'Não'
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
