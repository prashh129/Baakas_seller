import 'package:get/get.dart';
import '../controllers/order_controller.dart';

class ShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderController());
  }
}
