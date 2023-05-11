import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class WidgetModule extends GetView {
  const WidgetModule({super.key});

  Widget get view;
  Bindings get bindings;

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _createBinding(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return view;
          }
          return const SizedBox();
        });
  }

  Future<void> _createBinding() async {
    bindings.dependencies();
  }
}
