import 'package:flutter/material.dart';

import '../../core.dart';

class BusinessLogo extends StatelessWidget {
  const BusinessLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'C O N T A B I L I D A D E',
          style: ThemeAdapter(context).bodyMedium.copyWith(
            color: ThemeAdapter(context).accentColor,
            fontSize: 10,
          ),
        ),
        Text(
          'V A G N E R W I L L I A N',
          style: ThemeAdapter(context).headlineMedium.copyWith(
            color: ThemeAdapter(context).customColors.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
