import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/controllers/auth_controller.dart';

class GlobalMiddleware extends GetMiddleware {
  final authController = Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    return authController.isUserSignedIn.value ||
            route == '/signup' ||
            route == '/signin' ||
            route == '/confirm'
        ? null
        : const RouteSettings(name: '/signin');
  }

  // @override
  // GetPage? onPageCalled(GetPage? page) {
  //   print('>>> Page ${page?.name} called');
  //   print('>>> User ${authController.authUser.value.username} logged');
  //   return authController.authUser.value.username != null
  //       ? page
  //           ?.copy(parameters: {'user': authController.authUser.value.username})
  //       : page;
  // }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    // This function will be called right before the Bindings are initialize,
    // then bindings is null
    // bindings = [OtherBinding()];
    return bindings;
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    print('Bindings of ${page.toString()} are ready');
    return page;
  }

  @override
  Widget onPageBuilt(Widget page) {
    print('Widget ${page.toStringShort()} will be showed');
    return page;
  }

  @override
  void onPageDispose() {
    print('PageDisposed');
  }
}
