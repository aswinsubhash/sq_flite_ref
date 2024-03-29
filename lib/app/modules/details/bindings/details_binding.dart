import 'package:get/get.dart';
import 'package:machine_test_norq/app/modules/details/controllers/details_controller.dart';

class DetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailsController>(
      () => DetailsController(),
    );
  }
}
