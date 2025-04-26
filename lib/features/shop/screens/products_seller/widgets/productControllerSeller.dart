// product_controller.dart
import 'package:baakas_seller/features/shop/screens/products_seller/product_model.dart';
import 'package:get/get.dart';

class ProductControllerSeller extends GetxController {
  RxList<ProductModelSeller> products =
      <ProductModelSeller>[
        ProductModelSeller(
          id: '1',
          title: 'T-Shirt',
          images: ['assets/images/product1.png'],
          status: 'Active',
          stock: 10,
          variants: {'color': 'Blue', 'size': 'M'},
        ),
        ProductModelSeller(
          id: '2',
          title: 'Sneakers',
          images: ['assets/images/product2.png'],
          status: 'Out of Stock',
          stock: 0,
          variants: {'color': 'Black', 'size': '42'},
        ),
      ].obs;

  void addProduct(ProductModelSeller product) {
    products.add(product);
  }

  void removeProduct(ProductModelSeller product) {
    products.remove(product);
  }
}
