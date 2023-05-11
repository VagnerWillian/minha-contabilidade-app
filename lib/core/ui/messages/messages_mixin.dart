  import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core.dart';

mixin MessagesMixin on GetxController {
  void messageListener(Rxn<MessageModel> message) {
    ever<MessageModel?>(
      message,
      (model) {
        if (model != null) {
          BottomSheetType? type;
          switch (message.value?.type) {
            case MessageType.info:
              type = BottomSheetType.success;
              break;
            case MessageType.error:
              type = BottomSheetType.error;
              break;
            case MessageType.warning:
              type = BottomSheetType.warning;
              break;
            case MessageType.network:
              type = BottomSheetType.network;
              break;
            default:
              type = BottomSheetType.warning;
              break;
          }

          if (type != BottomSheetType.network) {
            CustomBottomSheet.show(
              context: Get.context!,
              type: type,
              title: message.value?.title ?? message.value?.type.title ?? '',
              message: message.value?.message ?? '',
              onAction: () => Navigator.pop(Get.context!),
            );
          } else if (type == BottomSheetType.network) {
            CustomBottomSheet.showNetwork(
              failureNetwork: message.value?.failureNetwork,
              context: Get.context!,
              title: message.value?.title ?? message.value?.type.title ?? '',
              message: message.value?.message ?? '',
              isDismissible: false,
              enableDrag: false,
            );
          }
        }
      },
    );
  }
}

class MessageModel {
  final String title;
  final String message;
  late final FailureNetwork failureNetwork;
  final MessageType type;

  MessageModel({
    required this.title,
    required this.message,
    required this.type,
  });

  MessageModel.error({
    required this.title,
    this.message = AppConstants.defaultErrorMessage,
  }) : type = MessageType.error;

  MessageModel.info({
    required this.title,
    required this.message,
  }) : type = MessageType.info;

  MessageModel.warning({
    required this.title,
    required this.message,
  }) : type = MessageType.warning;

  MessageModel.network({
    required this.title,
    required this.message,
    required this.failureNetwork,
  }) : type = MessageType.network;
}

enum MessageType {
  error(title: AppConstants.defaultErrorTitle),
  info(title: AppConstants.defaultSuccessTitle),
  warning(title: AppConstants.defaultWarningTitle),
  network;

  final String? title;

  const MessageType({this.title});
}

extension MessageTypeExtension on MessageType {
  Color color() {
    switch (this) {
      case MessageType.error:
        return AppColors.error;
      case MessageType.info:
        return AppColors.primary;
      case MessageType.warning:
        return AppColors.warning;
      case MessageType.network:
        return AppColors.grey500;

      default:
        return AppColors.grey500;
    }
  }
}
