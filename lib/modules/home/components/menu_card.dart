import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../core/core.dart';

class MenuCard extends StatelessWidget {
  final double width;
  final double? height;
  final FundEntity fund;

  const MenuCard({
    required this.fund,
    required this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (fund.failure != null) {
      return Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LineAwesome.exclamation_triangle_solid,
              size: 100,
              color: ThemeAdapter(context).error,
            ),
            Text(
              AppConstants.listFundsEmpty,
              style: ThemeAdapter(context).bodySmall.copyWith(
                    color: ThemeAdapter(context).error,
                  ),
            )
          ],
        ),
      );
    }
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            fund.color.convertToColor!.withOpacity(0.8),
            fund.color.convertToColor!,
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            LayoutBuilder(
                builder: (context, constraint) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraint.maxHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Visibility(
                            visible: fund.logo.isNotEmpty,
                            replacement: Text(
                              'LOGO',
                              style: ThemeAdapter(context).displaySmall.copyWith(
                                color: ThemeAdapter(context).customColors.white,
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: fund.logo,
                              width: 80,
                            ),
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
                                  Container(
                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                    child: Chip(
                                      backgroundColor: ThemeAdapter(context).customColors.white,
                                      label: Text(
                                        fund.isCreditString,
                                        style: ThemeAdapter(context).bodySmall.copyWith(
                                          color: ThemeAdapter(context).customColors.black,
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
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
                                ],
                              ),
                            ),
                            const SizedBox(height: 18),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Visibility(
                                visible: fund.brandUrl.isNotEmpty,
                                replacement: Text(
                                  'BRAND',
                                  style: ThemeAdapter(context).displaySmall.copyWith(
                                    color: ThemeAdapter(context).customColors.white,
                                  ),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: fund.brandUrl,
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
            ),
            Visibility(
              visible: !fund.active,
              child: Center(
                child: FittedBox(
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(65 / 360),
                    child: Text('DESATIVADO', style: ThemeAdapter(context).headlineLarge.copyWith(
                      color: ThemeAdapter(context).customColors.red,
                    ),),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
