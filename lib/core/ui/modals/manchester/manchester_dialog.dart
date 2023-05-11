import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../../core.dart';

class ManchesterDialog {
  static void show() {
    CustomDialog.show(
      borderRadius: 10,
      content: _buildManchester(),
    );
  }

  static Widget _buildManchester() {
    return const Rebuild();
  }
}

class Rebuild extends StatefulWidget {
  const Rebuild({Key? key}) : super(key: key);

  @override
  State<Rebuild> createState() => _RebuildState();
}

class _RebuildState extends State<Rebuild> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tempo de espera',
                    style: ThemeAdapter(context).titleMedium,
                  ),
                  Text(
                    'O tempo de espera para ser atedido depende da avaliação clínica do paciente',
                    style: ThemeAdapter(context).bodySmall,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 60,
              height: 60,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: ()=>Get.back(),
                icon: Center(
                  child: Icon(
                    UniconsLine.times,
                    size: 60,
                    color: ThemeAdapter(context).customColors.grey500,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),
        awaitTile(
          context,
          'Emergência',
          'Considerado grave com risco de morte.',
          0,
          Colors.red,
        ),
        awaitTile(
          context,
          'Muito Urgente',
          'Paciente com risco potencial',
          10,
          Colors.orange,
        ),
        awaitTile(
          context,
          'Urgente',
          'Paciente moderado com quadro instavel.',
          60,
          Colors.yellow.shade600,
        ),
        awaitTile(
          context,
          'Pouco Urgente',
          'Menor grau de urgência',
          120,
          Colors.green,
        ),
        awaitTile(
          context,
          'Não Urgente',
          'Paciente em condições não urgente.',
          240,
          Colors.blueAccent,
        ),
      ],
    );
  }

  static Widget awaitTile(BuildContext context, String title, String description, int time, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ThemeAdapter(context).displayMedium.copyWith(
                    color: ThemeAdapter(context).customColors.white
                  ),
                ),
                Text(
                  description,
                  style: ThemeAdapter(context).bodySmall.copyWith(
                      color: ThemeAdapter(context).customColors.white
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 12),
          IntrinsicWidth(
            child: Text(
              time == 0 ? 'Imediato' : '${time}min',
              style: ThemeAdapter(context).displayMedium.copyWith(
                  color: ThemeAdapter(context).customColors.white
              ),
            ),
          )
        ],
      ),
    );
  }
}
