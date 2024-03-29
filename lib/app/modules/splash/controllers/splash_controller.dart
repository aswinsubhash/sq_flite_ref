import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:machine_test_norq/app/routes/app_pages.dart';

class SplashController extends GetxController {
  String text = 'Welcome...';

  @override
  void onInit() {
    initialteSplash();
    super.onInit();
  }

  /// initiate splash
  Future<void> initialteSplash() async {
    final box = GetStorage();

    Future.delayed(const Duration(seconds: 3), () {
      if (box.read('loggedIn') == true) {
        Get.offAllNamed(Routes.home);
      } else {
        Get.offAllNamed(Routes.login);
      }
    });
  }
}
