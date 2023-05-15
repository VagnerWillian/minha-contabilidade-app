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
    var varFund = fund;
    if (varFund is CreditFundEntity) {
      return _buildCreditTile(context, varFund);
    } else if (varFund is DebitFundEntity) {
      return _buildDebitTile(context, varFund);
    }

    return Container(
      width: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColors.grey500.withOpacity(0.9),
          AppColors.grey500,
        ]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          'erro!',
          style: ThemeAdapter(context).bodyMedium.copyWith(
                color: ThemeAdapter(context).customColors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  Widget _buildCreditTile(BuildContext context, CreditFundEntity creditFund) {
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
                imageUrl: creditFund.logo,
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
                          creditFund.type.toUpperCase(),
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
                    imageUrl: creditFund.brand,
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

  Widget _buildDebitTile(BuildContext context, DebitFundEntity debitFund) {
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: debitFund.logo,
                  width: 100,
                ),
                Text(
                  debitFund.type.toUpperCase(),
                  style: ThemeAdapter(context).bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                )
              ],
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
                        backgroundColor: ThemeAdapter(context).customColors.black,
                        label: Text(
                          debitFund.type.toUpperCase(),
                          style: ThemeAdapter(context).bodySmall.copyWith(
                                color: ThemeAdapter(context).customColors.white,
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
                                    color: ThemeAdapter(context).customColors.grey500,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 8,
                                  ),
                            ),
                            Text(
                              fund.name.toUpperCase(),
                              style: ThemeAdapter(context).bodyMedium.copyWith(
                                    color: ThemeAdapter(context).customColors.grey500,
                                    letterSpacing: 10,
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
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: ThemeAdapter(context).customColors.grey500,
                        borderRadius: BorderRadius.circular(10)),
                    child: CachedNetworkImage(
                      imageUrl: debitFund.brand,
                      width: 80,
                    ),
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
