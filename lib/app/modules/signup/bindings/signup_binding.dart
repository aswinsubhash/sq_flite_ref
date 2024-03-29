import 'package:get/get.dart';
import 'package:machine_test_norq/app/modules/signup/controllers/signup_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(
      () => SignUpController(),
    );
  }
}
