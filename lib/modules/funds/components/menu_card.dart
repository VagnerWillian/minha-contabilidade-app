import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../core/core.dart';

class MenuCard extends StatelessWidget {
  final FundEntity fund;
  final double width;
  final double? height;

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
    return Obx(() {
      var name = fund.nameObs.value;
      var color = fund.colorObs.value.convertToColor ?? ThemeAdapter(context).customColors.grey500!;
      var brandUrl = fund.brandUrlObs.value;
      var logo = fund.logoUrlObs.value;

      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color,
              color.withOpacity(0.8)
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: LayoutBuilder(builder: (context, constraint) {
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
                        visible: logo.isNotEmpty,
                        replacement: Text(
                          'LOGO',
                          style: ThemeAdapter(context).displaySmall.copyWith(
                                color: ThemeAdapter(context).customColors.white,
                              ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: logo,
                          width: 50,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Align(
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
                                          name.toUpperCase(),
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
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Visibility(
                                visible: brandUrl.isNotEmpty,
                                replacement: Text(
                                  'BRAND',
                                  style: ThemeAdapter(context).displaySmall.copyWith(
                                        color: ThemeAdapter(context).customColors.white,
                                      ),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: brandUrl,
                                  width: 80,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}
