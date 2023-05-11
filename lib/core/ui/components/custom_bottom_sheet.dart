import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../core.dart';

enum BottomSheetType { success, warning, error, network }

class NetworkDefines {
  final String? buttonLabel;
  final CustomAvatarIcon avatarIcon;
  final VoidCallback? onPressed;

  NetworkDefines(this.avatarIcon, {this.buttonLabel, this.onPressed});
}

class CustomBottomSheet<T> {
  static Future customContentBottomSheet<T>({
    required BuildContext context,
    required Widget content,
    Widget? header,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ThemeAdapter(context).dialogBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (_) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                children: [
                  header ??
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: _slider(),
                      ),
                  content,
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future customContentBottomSheetModule<T>({
    required BuildContext context,
    required WidgetModule module,
    Widget? header,
    bool enableDrag = true,
  }) {
    var defaultContent = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                header ??
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: _slider(),
                    ),
                module,
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );

    return Get.bottomSheet(
      WillPopScope(
        onWillPop: () async => enableDrag,
        child: defaultContent,
      ),
      isScrollControlled: true,
      enableDrag: enableDrag,
      backgroundColor: ThemeAdapter(context).dialogBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
    );
  }

  static void show({
    required BuildContext context,
    required BottomSheetType type,
    required String title,
    required String message,
    VoidCallback? onAction,
    VoidCallback? onBack,
    String actionMessage = 'OK',
    String backMessage = '',
    bool isDismissible = true,
    bool enableDrag = true,
  }) =>
      _baseBottomSheet(
        context: context,
        type: type,
        title: title,
        message: message,
        actionMessage: actionMessage,
        backMessage: backMessage,
        onAction: onAction,
        onBack: onBack,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
      );

  static Future<void> showNetwork({
    required BuildContext context,
    required String title,
    required FailureNetwork? failureNetwork,
    required String message,
    bool isDismissible = true,
    bool enableDrag = true,
  }) async =>
      await _baseNetworkBottomSheet(
        context: context,
        title: title,
        message: message,
        failureNetwork: failureNetwork,
        enableDrag: enableDrag,
        isDismissible: isDismissible,
      );

  static void showOptionsBottomSheet({
    required BuildContext context,
    required List<Widget> options,
  }) =>
      showModalBottomSheet(
        enableDrag: false,
        context: context,
        backgroundColor: ThemeAdapter(context).dialogBackgroundColor,
        builder: (_) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  child: ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => Divider(
                      height: 1.0,
                      color: Colors.black.withOpacity(0.1),
                    ),
                    itemCount: options.length,
                    itemBuilder: (_, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Center(child: options[index]),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  child: CustomTextButton(
                    onPressed: Navigator.of(context).pop,
                    label: 'Cancelar',
                    labelStyle: ThemeAdapter(context).titleSmall,
                  ),
                ),
                const SizedBox(height: 12.0),
              ],
            ),
          );
        },
      );
}

void _baseBottomSheet({
  required BuildContext context,
  required BottomSheetType type,
  required String title,
  required String message,
  required String actionMessage,
  required String backMessage,
  VoidCallback? onAction,
  required VoidCallback? onBack,
  required bool? isDismissible,
  required bool? enableDrag,
}) {
  showModalBottomSheet(
    isDismissible: isDismissible!,
    enableDrag: enableDrag!,
    backgroundColor: ThemeAdapter(context).dialogBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      ),
    ),
    context: context,
    builder: (_) {
      Color color = type == BottomSheetType.success
          ? AppColors.success
          : type == BottomSheetType.warning
              ? AppColors.warning
              : AppColors.error;

      CustomAvatarIcon icon = type == BottomSheetType.success
          ? CustomAvatarIcon(icon: UniconsLine.check, color: color)
          : type == BottomSheetType.warning
              ? CustomAvatarIcon(icon: UniconsLine.exclamation_triangle, color: color)
              : CustomAvatarIcon(icon: UniconsLine.times, color: color);

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(.3),
              blurRadius: 12,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            _slider(),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    icon,
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        title,
                        style: ThemeAdapter(context).displayMedium,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  message,
                  style: ThemeAdapter(context).bodyMedium,
                )
              ],
            ),
            const SizedBox(height: 16),
            CustomRectangleButton(
              label: actionMessage,
              size: const Size(double.infinity, 60),
              background: color,
              onPressed: onAction,
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: backMessage.isNotEmpty,
              child: CustomTextButton(
                label: backMessage,
                labelStyle: ThemeAdapter(context).bodyMedium,
                onPressed: onBack ?? () {},
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}

Future<void> _baseNetworkBottomSheet({
  required BuildContext context,
  required String title,
  required String message,
  bool enableDrag = true,
  bool isDismissible = true,
  FailureNetwork? failureNetwork,
}) async {
  FailureNetwork failure = failureNetwork ?? FailureNetwork();
  return await showModalBottomSheet(
    isDismissible: enableDrag,
    enableDrag: enableDrag,
    backgroundColor: ThemeAdapter(context).dialogBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      ),
    ),
    context: context,
    builder: (_) {
      return WillPopScope(
        onWillPop: () async => isDismissible,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.error.withOpacity(.3),
                blurRadius: 12,
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              _slider(),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _getNetworkDefines(failure.statusCode).avatarIcon,
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          '${failure.statusCode ?? ''} • $title',
                          style: ThemeAdapter(context).bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    message,
                    style: ThemeAdapter(context).bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomRectangleButton(
                      label: _getNetworkDefines(failure.statusCode).buttonLabel ?? 'Ok',
                      size: const Size(double.infinity, 60),
                      onPressed: _getNetworkDefines(failure.statusCode).onPressed ?? Get.back,
                      labelStyle: ThemeAdapter(context).bodyMedium.copyWith(color: AppColors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      );
    },
  );
}

NetworkDefines _getNetworkDefines(int? statusCode) {
  var defines = {
    null: NetworkDefines(
      const CustomAvatarIcon(
        icon: UniconsLine.wifi_slash,
        color: Colors.red,
      ),
    ),
    401: NetworkDefines(
      buttonLabel: 'Entrar novamente',
      const CustomAvatarIcon(
        icon: UniconsLine.lock,
      ),
      onPressed: () => Get.offAllNamed(AppRoutes.startRoute),
    ),
    404: NetworkDefines(
      const CustomAvatarIcon(
        icon: UniconsLine.times_circle,
        color: Colors.red,
      ),
    ),
  };

  return defines[statusCode] ??
      NetworkDefines(
        const CustomAvatarIcon(
          icon: UniconsLine.server,
        ),
      );
}

Container _slider() {
  return Container(
    height: 3,
    width: 26,
    decoration: BoxDecoration(
      color: AppColors.grey500,
      borderRadius: BorderRadius.circular(20),
    ),
  );
}
