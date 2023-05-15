import 'package:flutter/material.dart';

import '../../../core/core.dart';

class MenuSummary extends StatelessWidget {
  const MenuSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: ThemeAdapter(context).customColors.blackGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOTAL',
                  style: ThemeAdapter(context).titleMedium.copyWith(
                        color: ThemeAdapter(context).customColors.white,
                      ),
                ),
                Text(
                  'Julho',
                  style: ThemeAdapter(context).bodySmall,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Valor',
                  style: ThemeAdapter(context).bodySmall,
                ),
                Text(
                  'R\$ 3.589,35',
                  style: ThemeAdapter(context)
                      .headlineMedium
                      .copyWith(color: ThemeAdapter(context).customColors.white),
                ),
                SizedBox(
                  width: 50,
                  child: Divider(
                    height: 18,
                    color: ThemeAdapter(context).customColors.grey500,
                  ),
                ),
                Text(
                  'Pagar até ',
                  style: ThemeAdapter(context).bodySmall,
                ),
                Text(
                  'dia 10',
                  style: ThemeAdapter(context)
                      .headlineMedium
                      .copyWith(color: ThemeAdapter(context).customColors.white),
                ),
              ],
            ),
            SizedBox(
              height: 60,
              child: CustomRectangleButton(
                label: 'Pagar/Adiantar',
                background: ThemeAdapter(context).customColors.green,
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
