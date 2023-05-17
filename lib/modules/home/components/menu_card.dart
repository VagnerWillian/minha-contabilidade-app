import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../core/domain/entities/entities.dart';

class MenuCard extends StatelessWidget {
  final FundEntity fund;

  const MenuCard({
    required this.fund,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            fund.color.convertToColor.withOpacity(0.9),
            fund.color.convertToColor,
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/chip.png',
              width: 45,
              height: 45,
            ),
            Center(
              child: CachedNetworkImage(
                imageUrl: fund.logo,
                width: 100,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Chip(
                        backgroundColor: ThemeAdapter(context).customColors.white,
                        label: Text(
                          fund.type.toUpperCase(),
                          style: ThemeAdapter(context).bodySmall.copyWith(
                            color: ThemeAdapter(context).customColors.black,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            fontSize: 8,
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'VAGNER W M FERREIRA',
                              style: ThemeAdapter(context).bodySmall.copyWith(
                                color: ThemeAdapter(context).customColors.white,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              fund.name.toUpperCase(),
                              style: ThemeAdapter(context).bodyMedium.copyWith(
                                color: ThemeAdapter(context).customColors.white,
                                letterSpacing: 5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerRight,
                  child: CachedNetworkImage(
                    imageUrl: fund.brand,
                    width: 80,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}