import 'package:baakas_seller/features/personalization/controllers/settings_controller.dart';
import 'package:get/get.dart';
import '../features/personalization/controllers/address_controller.dart';
import '../features/shop/controllers/product/images_controller.dart';
import '../utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    // Ensure GetX is initialized
    if (!Get.testMode) {
      Get.testMode = false;
    }

    /// -- Core
    Get.put(NetworkManager(), permanent: true);

    /// -- Product

    Get.put(ImagesController(), permanent: true);

    /// -- Other
    Get.put(AddressController(), permanent: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
  }
}
