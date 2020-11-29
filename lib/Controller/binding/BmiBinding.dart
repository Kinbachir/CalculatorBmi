import 'package:get/get.dart';

import '../BmiController.dart';

class BmiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BmiController>(() => BmiController());
  }
}
