import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../core/core.dart';

class MenuSummary extends StatelessWidget {
  final double width;
  final double? height;
  final VoidCallback? reloadData;

  const MenuSummary({
    super.key,
    this.reloadData,
    this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: ThemeAdapter(context).customColors.blackGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: LayoutBuilder(
          builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: reloadData,
                        icon: const Icon(LineAwesome.redo_alt_solid),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        height: 60,
                        child: CustomRectangleButton(
                          label: 'Pagar/Adiantar',
                          background: ThemeAdapter(context).customColors.green,
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
