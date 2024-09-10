import 'package:e_shop/features/shop/controller/products/variation_controller.dart';
import 'package:e_shop/utils/network/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
  }
}
