// import '../../../routes/routes.dart';
// import '../../../utils/constants/enums.dart';
// import '../../../utils/constants/image_strings.dart';
// import '../../personalization/models/address_model.dart';
// import '../../personalization/models/user_model.dart';
// import '../models/banner_model.dart';
// import '../models/brand_category_model.dart';
// import '../models/brand_model.dart';
// import '../models/cart_item_model.dart';
// import '../models/cart_model.dart';
// import '../models/category_model.dart';
// import '../models/order_model.dart';
// import '../models/product_attribute_model.dart';
// import '../models/product_category_model.dart';
// import '../models/product_model.dart';
// import '../models/product_review_model.dart';
// import '../models/product_variation_model.dart';

// class BaakasDummyData {
//   /// -- Banners
//   static final List<BannerModel> banners = [
//     BannerModel(
//         imageUrl: BaakasImages.banner1,
//         targetScreen: BaakasRoutes.order,
//         active: false),
//     BannerModel(
//         imageUrl: BaakasImages.banner2,
//         targetScreen: BaakasRoutes.cart,
//         active: true),
//     BannerModel(
//         imageUrl: BaakasImages.banner3,
//         targetScreen: BaakasRoutes.favourites,
//         active: true),
//     BannerModel(
//         imageUrl: BaakasImages.banner4,
//         targetScreen: BaakasRoutes.search,
//         active: true),
//     BannerModel(
//         imageUrl: BaakasImages.banner5,
//         targetScreen: BaakasRoutes.settings,
//         active: true),
//     BannerModel(
//         imageUrl: BaakasImages.banner6,
//         targetScreen: BaakasRoutes.userAddress,
//         active: true),
//     BannerModel(
//         imageUrl: BaakasImages.banner8,
//         targetScreen: BaakasRoutes.checkout,
//         active: false),
//   ];

//   /// -- User
//   static final UserModel user = UserModel(
//     firstName: 'Dipesh',
//     lastName: 'Adhikari',
//     email: 'ceo.baakas@gmail.com',
//     phoneNumber: '9806565656',
//     profilePicture: BaakasImages.user,
//     addresses: [
//       AddressModel(
//         id: '1',
//         name: 'Dipes Adhikari',
//         phoneNumber: '9806346565',
//         street: 'Shikar chowk,tarahara',
//         city: 'Itahari',
//         state: 'Koshi',
//         postalCode: '87665',
//         country: 'Nepal',
//       ),
//       AddressModel(
//         id: '6',
//         name: 'John Doe',
//         phoneNumber: '+1234567890',
//         street: '123 Main Street',
//         city: 'New York',
//         state: 'New York',
//         postalCode: '10001',
//         country: 'United States',
//       ),
//       AddressModel(
//         id: '2',
//         name: 'Alice Smith',
//         phoneNumber: '+9876543210',
//         street: '456 Elm Avenue',
//         city: 'Los Angeles',
//         state: 'California',
//         postalCode: '90001',
//         country: 'United States',
//       ),
//       AddressModel(
//         id: '3',
//         name: 'Taimoor Sikander',
//         phoneNumber: '+923178059528',
//         street: 'Street 35',
//         city: 'Islamabad',
//         state: 'Federal',
//         postalCode: '48000',
//         country: 'Pakistan',
//       ),
//       AddressModel(
//         id: '4',
//         name: 'Maria Garcia',
//         phoneNumber: '+5412345678',
//         street: '789 Oak Road',
//         city: 'Buenos Aires',
//         state: 'Buenos Aires',
//         postalCode: '1001',
//         country: 'Argentina',
//       ),
//       AddressModel(
//         id: '5',
//         name: 'Liam Johnson',
//         phoneNumber: '+447890123456',
//         street: '10 Park Lane',
//         city: 'London',
//         state: 'England',
//         postalCode: 'SW1A 1AA',
//         country: 'United Kingdom',
//       )
//     ],
//     username: '',
//     id: '',
//   );

//   /// -- Cart
//   static final CartModel cart = CartModel(
//     cartId: '001',
//     items: [
//       CartItemModel(
//         productId: '001',
//         variationId: '1',
//         quantity: 1,
//         title: products[0].title,
//         image: products[0].thumbnail,
//         brandName: products[0].brand!.name,
//         price: products[0].productVariations![0].price,
//         selectedVariation: products[0].productVariations![0].attributeValues,
//       ),
//       CartItemModel(
//         productId: '002',
//         variationId: '',
//         quantity: 1,
//         title: products[1].title,
//         image: products[1].thumbnail,
//         brandName: products[1].brand!.name,
//         price: products[1].price,
//         selectedVariation: products[1].productVariations != null
//             ? products[1].productVariations![1].attributeValues
//             : {},
//       ),
//     ],
//   );

//   /// -- Order
//   static final List<OrderModel> orders = [
//     OrderModel(
//       id: 'CWT0012',
//       status: OrderStatus.processing,
//       items: cart.items,
//       totalAmount: 265,
//       orderDate: DateTime(2023, 09, 1),
//       deliveryDate: DateTime(2023, 09, 9),
//       shippingCost: 5,
//       taxCost: 0.05,
//     ),
//     OrderModel(
//       id: 'CWT0025',
//       status: OrderStatus.shipped,
//       items: cart.items,
//       totalAmount: 369,
//       orderDate: DateTime(2023, 10, 2),
//       deliveryDate: DateTime(2023, 10, 6),
//       shippingCost: 5,
//       taxCost: 0.05,
//     ),
//     OrderModel(
//       id: 'CWT0152',
//       status: OrderStatus.delivered,
//       items: cart.items,
//       totalAmount: 254,
//       orderDate: DateTime(2023, 11, 3),
//       deliveryDate: DateTime(2023, 11, 8),
//       shippingCost: 5,
//       taxCost: 0.05,
//     ),
//     OrderModel(
//       id: 'CWT0265',
//       status: OrderStatus.delivered,
//       items: cart.items,
//       totalAmount: 355,
//       orderDate: DateTime(2023, 12, 20),
//       deliveryDate: DateTime(2023, 12, 25),
//       shippingCost: 5,
//       taxCost: 0.05,
//     ),
//     OrderModel(
//       id: 'CWT1536',
//       status: OrderStatus.delivered,
//       items: cart.items,
//       totalAmount: 115,
//       orderDate: DateTime(2023, 12, 25),
//       deliveryDate: DateTime(2024, 01, 1),
//       shippingCost: 5,
//       taxCost: 0.05,
//     ),
//   ];

//   /// -- List of all Categories
//   static final List<CategoryModel> categories = [
//     CategoryModel(
//         id: '1',
//         image: BaakasImages.sportIcon,
//         name: 'Sports',
//         isFeatured: true),
//     CategoryModel(
//         id: '5',
//         image: BaakasImages.furnitureIcon,
//         name: 'Furniture',
//         isFeatured: true),
//     CategoryModel(
//         id: '2',
//         image: BaakasImages.electronicsIcon,
//         name: 'Electronics',
//         isFeatured: true),
//     CategoryModel(
//         id: '3',
//         image: BaakasImages.clothIcon,
//         name: 'Clothes',
//         isFeatured: true),
//     CategoryModel(
//         id: '4',
//         image: BaakasImages.animalIcon,
//         name: 'Animals',
//         isFeatured: true),
//     CategoryModel(
//         id: '6', image: BaakasImages.shoeIcon, name: 'Shoes', isFeatured: true),
//     CategoryModel(
//         id: '7',
//         image: BaakasImages.cosmeticsIcon,
//         name: 'Cosmetics',
//         isFeatured: true),
//     CategoryModel(
//         id: '14',
//         image: BaakasImages.jeweleryIcon,
//         name: 'Jewelery',
//         isFeatured: true),

//     ///subcategories
//     CategoryModel(
//         id: '8',
//         image: BaakasImages.sportIcon,
//         name: 'Sport Shoes',
//         parentId: '1',
//         isFeatured: false),
//     CategoryModel(
//         id: '9',
//         image: BaakasImages.sportIcon,
//         name: 'Track suits',
//         parentId: '1',
//         isFeatured: false),
//     CategoryModel(
//         id: '10',
//         image: BaakasImages.sportIcon,
//         name: 'Sports Equipments',
//         parentId: '1',
//         isFeatured: false),
//     //furniture
//     CategoryModel(
//         id: '11',
//         image: BaakasImages.furnitureIcon,
//         name: 'Bedroom furniture',
//         parentId: '5',
//         isFeatured: false),
//     CategoryModel(
//         id: '12',
//         image: BaakasImages.furnitureIcon,
//         name: 'Kitchen furniture',
//         parentId: '5',
//         isFeatured: false),
//     CategoryModel(
//         id: '13',
//         image: BaakasImages.furnitureIcon,
//         name: 'Office furniture',
//         parentId: '5',
//         isFeatured: false),
//     //electronics
//     CategoryModel(
//         id: '14',
//         image: BaakasImages.electronicsIcon,
//         name: 'Laptop',
//         parentId: '2',
//         isFeatured: false),
//     CategoryModel(
//         id: '15',
//         image: BaakasImages.electronicsIcon,
//         name: 'Mobile',
//         parentId: '2',
//         isFeatured: false),

//     CategoryModel(
//         id: '16',
//         image: BaakasImages.clothIcon,
//         name: 'Shirts',
//         parentId: '3',
//         isFeatured: false),
//   ];

//   /// -- List of all Brands
//   static final List<BrandModel> brands = [
//     BrandModel(
//         id: '1',
//         image: BaakasImages.nikeLogo,
//         name: 'Nike',
//         productsCount: 265,
//         isFeatured: true),
//     BrandModel(
//         id: '2',
//         image: BaakasImages.adidasLogo,
//         name: 'Adidas',
//         productsCount: 95,
//         isFeatured: true),
//     BrandModel(
//         id: '8',
//         image: BaakasImages.kenwoodLogo,
//         name: 'Kenwood',
//         productsCount: 36,
//         isFeatured: false),
//     BrandModel(
//         id: '9',
//         image: BaakasImages.ikeaLogo,
//         name: 'IKEA',
//         productsCount: 36,
//         isFeatured: false),
//     BrandModel(
//         id: '5',
//         image: BaakasImages.appleLogo,
//         name: 'Apple',
//         productsCount: 16,
//         isFeatured: true),
//     BrandModel(
//         id: '10',
//         image: BaakasImages.acerlogo,
//         name: 'Acer',
//         productsCount: 36,
//         isFeatured: false),
//     BrandModel(
//         id: '3',
//         image: BaakasImages.jordanLogo,
//         name: 'Jordan',
//         productsCount: 36,
//         isFeatured: true),
//     BrandModel(
//         id: '4',
//         image: BaakasImages.pumaLogo,
//         name: 'Puma',
//         productsCount: 65,
//         isFeatured: true),
//     BrandModel(
//         id: '6',
//         image: BaakasImages.zaraLogo,
//         name: 'ZARA',
//         productsCount: 36,
//         isFeatured: true),
//     BrandModel(
//         id: '7',
//         image: BaakasImages.electronicsIcon,
//         name: 'Samsung',
//         productsCount: 36,
//         isFeatured: false),
//   ];

//   /// -- List of all Brand Categories
//   static final List<BrandCategoryModel> brandCategory = [
//     BrandCategoryModel(brandId: '1', categoryId: '1'),
//     BrandCategoryModel(brandId: '1', categoryId: '8'),
//     BrandCategoryModel(brandId: '1', categoryId: '9'),
//     BrandCategoryModel(brandId: '1', categoryId: '10'),
//     BrandCategoryModel(brandId: '2', categoryId: '1'),
//     BrandCategoryModel(brandId: '2', categoryId: '8'),
//     BrandCategoryModel(brandId: '2', categoryId: '9'),
//     BrandCategoryModel(brandId: '2', categoryId: '10'),
//     BrandCategoryModel(brandId: '3', categoryId: '1'),
//     BrandCategoryModel(brandId: '3', categoryId: '8'),
//     BrandCategoryModel(brandId: '3', categoryId: '9'),
//     BrandCategoryModel(brandId: '3', categoryId: '10'),
//     BrandCategoryModel(brandId: '4', categoryId: '1'),
//     BrandCategoryModel(brandId: '4', categoryId: '8'),
//     BrandCategoryModel(brandId: '4', categoryId: '9'),
//     BrandCategoryModel(brandId: '4', categoryId: '10'),
//     BrandCategoryModel(brandId: '5', categoryId: '15'),
//     BrandCategoryModel(brandId: '5', categoryId: '2'),
//     BrandCategoryModel(brandId: '10', categoryId: '2'),
//     BrandCategoryModel(brandId: '10', categoryId: '14'),
//     BrandCategoryModel(brandId: '6', categoryId: '3'),
//     BrandCategoryModel(brandId: '6', categoryId: '16'),
//     BrandCategoryModel(brandId: '7', categoryId: '2'),
//     BrandCategoryModel(brandId: '8', categoryId: '5'),
//     BrandCategoryModel(brandId: '8', categoryId: '11'),
//     BrandCategoryModel(brandId: '8', categoryId: '12'),
//     BrandCategoryModel(brandId: '8', categoryId: '13'),
//     BrandCategoryModel(brandId: '9', categoryId: '5'),
//     BrandCategoryModel(brandId: '9', categoryId: '11'),
//     BrandCategoryModel(brandId: '9', categoryId: '12'),
//     BrandCategoryModel(brandId: '9', categoryId: '13'),
//   ];

//   /// -- List of all Product Categories
//   static final List<ProductCategoryModel> productCategories = [
//     ProductCategoryModel(productId: '001', categoryId: '1'),
//     ProductCategoryModel(productId: '001', categoryId: '8'),
//     ProductCategoryModel(productId: '004', categoryId: '3'),
//     ProductCategoryModel(productId: '002', categoryId: '3'),
//     ProductCategoryModel(productId: '002', categoryId: '16'),
//     ProductCategoryModel(productId: '003', categoryId: '3'),
//     ProductCategoryModel(productId: '005', categoryId: '1'),
//     ProductCategoryModel(productId: '005', categoryId: '8'),
//     ProductCategoryModel(productId: '040', categoryId: '2'),
//     ProductCategoryModel(productId: '040', categoryId: '15'),
//     ProductCategoryModel(productId: '006', categoryId: '2'),
//     ProductCategoryModel(productId: '007', categoryId: '4'),
//     ProductCategoryModel(productId: '009', categoryId: '1'),
//     ProductCategoryModel(productId: '009', categoryId: '8'),
//     ProductCategoryModel(productId: '010', categoryId: '1'),
//     ProductCategoryModel(productId: '010', categoryId: '8'),
//     ProductCategoryModel(productId: '011', categoryId: '1'),
//     ProductCategoryModel(productId: '011', categoryId: '8'),
//     ProductCategoryModel(productId: '012', categoryId: '1'),
//     ProductCategoryModel(productId: '012', categoryId: '8'),
//     ProductCategoryModel(productId: '013', categoryId: '1'),
//     ProductCategoryModel(productId: '013', categoryId: '8'),

//     ProductCategoryModel(productId: '014', categoryId: '1'),
//     ProductCategoryModel(productId: '014', categoryId: '9'),
//     ProductCategoryModel(productId: '015', categoryId: '1'),
//     ProductCategoryModel(productId: '015', categoryId: '9'),
//     ProductCategoryModel(productId: '016', categoryId: '1'),
//     ProductCategoryModel(productId: '016', categoryId: '9'),
//     ProductCategoryModel(productId: '017', categoryId: '1'),
//     ProductCategoryModel(productId: '017', categoryId: '9'),

//     ProductCategoryModel(productId: '018', categoryId: '1'),
//     ProductCategoryModel(productId: '018', categoryId: '10'),
//     ProductCategoryModel(productId: '019', categoryId: '1'),
//     ProductCategoryModel(productId: '019', categoryId: '10'),
//     ProductCategoryModel(productId: '020', categoryId: '1'),
//     ProductCategoryModel(productId: '020', categoryId: '10'),
//     ProductCategoryModel(productId: '021', categoryId: '1'),
//     ProductCategoryModel(productId: '021', categoryId: '10'),

//     ProductCategoryModel(productId: '022', categoryId: '5'),
//     ProductCategoryModel(productId: '022', categoryId: '11'),
//     ProductCategoryModel(productId: '023', categoryId: '5'),
//     ProductCategoryModel(productId: '023', categoryId: '11'),
//     ProductCategoryModel(productId: '024', categoryId: '5'),
//     ProductCategoryModel(productId: '024', categoryId: '11'),
//     ProductCategoryModel(productId: '025', categoryId: '5'),
//     ProductCategoryModel(productId: '025', categoryId: '11'),

//     ProductCategoryModel(productId: '026', categoryId: '5'),
//     ProductCategoryModel(productId: '026', categoryId: '12'),
//     ProductCategoryModel(productId: '027', categoryId: '5'),
//     ProductCategoryModel(productId: '027', categoryId: '12'),
//     ProductCategoryModel(productId: '028', categoryId: '5'),
//     ProductCategoryModel(productId: '028', categoryId: '12'),

//     ProductCategoryModel(productId: '029', categoryId: '5'),
//     ProductCategoryModel(productId: '029', categoryId: '13'),
//     ProductCategoryModel(productId: '030', categoryId: '5'),
//     ProductCategoryModel(productId: '030', categoryId: '13'),
//     ProductCategoryModel(productId: '031', categoryId: '5'),
//     ProductCategoryModel(productId: '031', categoryId: '13'),
//     ProductCategoryModel(productId: '032', categoryId: '5'),
//     ProductCategoryModel(productId: '032', categoryId: '13'),

//     ProductCategoryModel(productId: '033', categoryId: '2'),
//     ProductCategoryModel(productId: '033', categoryId: '14'),
//     ProductCategoryModel(productId: '034', categoryId: '2'),
//     ProductCategoryModel(productId: '034', categoryId: '14'),
//     ProductCategoryModel(productId: '035', categoryId: '2'),
//     ProductCategoryModel(productId: '035', categoryId: '14'),
//     ProductCategoryModel(productId: '036', categoryId: '2'),
//     ProductCategoryModel(productId: '036', categoryId: '14'),

//     ProductCategoryModel(productId: '037', categoryId: '2'),
//     ProductCategoryModel(productId: '037', categoryId: '15'),
//     ProductCategoryModel(productId: '038', categoryId: '2'),
//     ProductCategoryModel(productId: '038', categoryId: '15'),
//     ProductCategoryModel(productId: '039', categoryId: '2'),
//     ProductCategoryModel(productId: '039', categoryId: '15'),
//     //040 after product 005

//     ProductCategoryModel(productId: '008', categoryId: '2'),
//   ];

//   /// -- List of all Products
//   static final List<ProductModel> products = [
//     ProductModel(
//       id: '001',
//       title: 'Green Nike sports shoe',
//       stock: 15,
//       price: 135,
//       isFeatured: true,
//       thumbnail: BaakasImages.productImage1,
//       description: 'Green Nike sports shoe',
//       brand: BrandModel(
//           id: '1',
//           image: BaakasImages.nikeLogo,
//           name: 'Nike',
//           productsCount: 265,
//           isFeatured: true),
//       images: [
//         BaakasImages.productImage1,
//         BaakasImages.productImage23,
//         BaakasImages.productImage21,
//         BaakasImages.productImage9
//       ],
//       salePrice: 30,
//       sku: 'ABR4568',
//       categoryId: '1',
//       productAttributes: [
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'Red']),
//         ProductAttributeModel(
//             name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
//       ],
//       productVariations: [
//         ProductVariationModel(
//             id: '1',
//             stock: 34,
//             price: 134,
//             salePrice: 122.6,
//             image: BaakasImages.productImage1,
//             description:
//                 'This is a Product description for Green Nike sports shoe.',
//             attributeValues: {'Color': 'Green', 'Size': 'EU 34'}),
//         ProductVariationModel(
//             id: '2',
//             stock: 15,
//             price: 132,
//             image: BaakasImages.productImage23,
//             attributeValues: {'Color': 'Black', 'Size': 'EU 32'}),
//         ProductVariationModel(
//             id: '3',
//             stock: 0,
//             price: 234,
//             image: BaakasImages.productImage23,
//             attributeValues: {'Color': 'Black', 'Size': 'EU 34'}),
//         ProductVariationModel(
//             id: '4',
//             stock: 222,
//             price: 232,
//             image: BaakasImages.productImage1,
//             attributeValues: {'Color': 'Green', 'Size': 'EU 32'}),
//         ProductVariationModel(
//             id: '5',
//             stock: 0,
//             price: 334,
//             image: BaakasImages.productImage21,
//             attributeValues: {'Color': 'Red', 'Size': 'EU 34'}),
//         ProductVariationModel(
//             id: '6',
//             stock: 11,
//             price: 332,
//             image: BaakasImages.productImage21,
//             attributeValues: {'Color': 'Red', 'Size': 'EU 32'}),
//       ],
//       productType: ProductType.variable.toString(),
//     ),
//     ProductModel(
//       id: '002',
//       title: 'Blue T-shirt for all ages',
//       stock: 15,
//       price: 35,
//       isFeatured: true,
//       thumbnail: BaakasImages.productImage69,
//       description:
//           'This is a Product description for Blue Nike Sleeve less vest. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '6', image: BaakasImages.zaraLogo, name: 'ZARA'),
//       images: [
//         BaakasImages.productImage68,
//         BaakasImages.productImage69,
//         BaakasImages.productImage5
//       ],
//       salePrice: 30,
//       sku: 'ABR4568',
//       categoryId: '16',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '003',
//       title: 'Leather brown Jacket',
//       stock: 15,
//       price: 38000,
//       isFeatured: false,
//       thumbnail: BaakasImages.productImage64,
//       description:
//           'This is a Product description for Leather brown Jacket. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '6', image: BaakasImages.zaraLogo, name: 'ZARA'),
//       images: [
//         BaakasImages.productImage64,
//         BaakasImages.productImage65,
//         BaakasImages.productImage66,
//         BaakasImages.productImage67
//       ],
//       salePrice: 30,
//       sku: 'ABR4568',
//       categoryId: '16',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '004',
//       title: '4 Color collar t-shirt dry fit',
//       stock: 15,
//       price: 135,
//       isFeatured: false,
//       thumbnail: BaakasImages.productImage60,
//       description:
//           'This is a Product description for 4 Color collar t-shirt dry fit. There are more things that can be added but its just a demo and nothing else.',
//       brand: BrandModel(id: '6', image: BaakasImages.zaraLogo, name: 'ZARA'),
//       images: [
//         BaakasImages.productImage60,
//         BaakasImages.productImage61,
//         BaakasImages.productImage62,
//         BaakasImages.productImage63
//       ],
//       salePrice: 30,
//       sku: 'ABR4568',
//       categoryId: '16',
//       productAttributes: [
//         ProductAttributeModel(
//             name: 'Color', values: ['Red', 'Yellow', 'Green', 'Blue']),
//         ProductAttributeModel(
//             name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
//       ],
//       productVariations: [
//         ProductVariationModel(
//             id: '1',
//             stock: 34,
//             price: 134,
//             salePrice: 122.6,
//             image: BaakasImages.productImage60,
//             description:
//                 'This is a Product description for 4 Color collar t-shirt dry fit',
//             attributeValues: {'Color': 'Red', 'Size': 'EU 34'}),
//         ProductVariationModel(
//             id: '2',
//             stock: 15,
//             price: 132,
//             image: BaakasImages.productImage60,
//             attributeValues: {'Color': 'Red', 'Size': 'EU 32'}),
//         ProductVariationModel(
//             id: '3',
//             stock: 0,
//             price: 234,
//             image: BaakasImages.productImage61,
//             attributeValues: {'Color': 'Yellow', 'Size': 'EU 34'}),
//         ProductVariationModel(
//             id: '4',
//             stock: 222,
//             price: 232,
//             image: BaakasImages.productImage61,
//             attributeValues: {'Color': 'Yellow', 'Size': 'EU 32'}),
//         ProductVariationModel(
//             id: '5',
//             stock: 0,
//             price: 334,
//             image: BaakasImages.productImage62,
//             attributeValues: {'Color': 'Green', 'Size': 'EU 34'}),
//         ProductVariationModel(
//             id: '6',
//             stock: 11,
//             price: 332,
//             image: BaakasImages.productImage62,
//             attributeValues: {'Color': 'Green', 'Size': 'EU 30'}),
//         ProductVariationModel(
//             id: '7',
//             stock: 0,
//             price: 334,
//             image: BaakasImages.productImage63,
//             attributeValues: {'Color': 'Blue', 'Size': 'EU 30'}),
//         ProductVariationModel(
//             id: '8',
//             stock: 11,
//             price: 332,
//             image: BaakasImages.productImage63,
//             attributeValues: {'Color': 'Blue', 'Size': 'EU 34'}),
//       ],
//       productType: ProductType.variable.toString(),
//     ),

//     ///Products after banner
//     ProductModel(
//       id: '005',
//       title: 'Nike Air Jordon Shoes',
//       stock: 15,
//       price: 35,
//       isFeatured: false,
//       thumbnail: BaakasImages.productImage10,
//       description:
//           'Nike Air Jordon Shoes for running. Quality product, Long Lasting',
//       brand: BrandModel(
//           id: '1',
//           image: BaakasImages.nikeLogo,
//           name: 'Nike',
//           productsCount: 265,
//           isFeatured: true),
//       images: [
//         BaakasImages.productImage7,
//         BaakasImages.productImage8,
//         BaakasImages.productImage9,
//         BaakasImages.productImage10
//       ],
//       salePrice: 30,
//       sku: 'ABR4568',
//       categoryId: '8',
//       productAttributes: [
//         ProductAttributeModel(
//             name: 'Color', values: ['Orange', 'Black', 'Brown']),
//         ProductAttributeModel(
//             name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
//       ],
//       productVariations: [
//         ProductVariationModel(
//             id: '1',
//             stock: 16,
//             price: 36,
//             salePrice: 12.6,
//             image: BaakasImages.productImage8,
//             description:
//                 'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
//             attributeValues: {'Color': 'Orange', 'Size': 'EU 34'}),
//         ProductVariationModel(
//             id: '2',
//             stock: 15,
//             price: 35,
//             image: BaakasImages.productImage7,
//             attributeValues: {'Color': 'Black', 'Size': 'EU 32'}),
//         ProductVariationModel(
//             id: '3',
//             stock: 14,
//             price: 34,
//             image: BaakasImages.productImage9,
//             attributeValues: {'Color': 'Brown', 'Size': 'EU 34'}),
//         ProductVariationModel(
//             id: '4',
//             stock: 13,
//             price: 33,
//             image: BaakasImages.productImage7,
//             attributeValues: {'Color': 'Black', 'Size': 'EU 34'}),
//         ProductVariationModel(
//             id: '5',
//             stock: 12,
//             price: 32,
//             image: BaakasImages.productImage9,
//             attributeValues: {'Color': 'Brown', 'Size': 'EU 32'}),
//         ProductVariationModel(
//             id: '6',
//             stock: 11,
//             price: 31,
//             image: BaakasImages.productImage8,
//             attributeValues: {'Color': 'Orange', 'Size': 'EU 32'}),
//       ],
//       productType: ProductType.variable.toString(),
//     ),
//     ProductModel(
//       id: '006',
//       title: 'SAMSUNG Galaxy S9 (Pink, 64 GB)  (4 GB RAM)',
//       stock: 15,
//       price: 750,
//       isFeatured: false,
//       thumbnail: BaakasImages.productImage11,
//       description:
//           'SAMSUNG Galaxy S9 (Pink, 64 GB)  (4 GB RAM), Long Battery timing',
//       brand:
//           BrandModel(id: '7', image: BaakasImages.appleLogo, name: 'Samsung'),
//       images: [
//         BaakasImages.productImage11,
//         BaakasImages.productImage12,
//         BaakasImages.productImage13,
//         BaakasImages.productImage12
//       ],
//       salePrice: 650,
//       sku: 'ABR4568',
//       categoryId: '2',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '007',
//       title: 'TOMI Dog food',
//       stock: 15,
//       price: 20,
//       isFeatured: false,
//       thumbnail: BaakasImages.productImage18,
//       description:
//           'This is a Product description for TOMI Dog food. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '7', image: BaakasImages.appleLogo, name: 'Tomi'),
//       salePrice: 10,
//       sku: 'ABR4568',
//       categoryId: '4',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     //008 after 040
//     ProductModel(
//       id: '009',
//       title: 'Nike Air Jordon 19 Blue',
//       stock: 15,
//       price: 400,
//       isFeatured: false,
//       thumbnail: BaakasImages.productImage19,
//       description:
//           'This is a Product description for Nike Air Jordon. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '1', image: BaakasImages.nikeLogo, name: 'Nike'),
//       images: [
//         BaakasImages.productImage19,
//         BaakasImages.productImage20,
//         BaakasImages.productImage21,
//         BaakasImages.productImage22
//       ],
//       salePrice: 200,
//       sku: 'ABR4568',
//       categoryId: '8',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '010',
//       title: 'Nike Air Jordon 6 Orange',
//       stock: 15,
//       price: 400,
//       thumbnail: BaakasImages.productImage20,
//       description:
//           'This is a Product description for Nike Air Jordon. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '1', image: BaakasImages.nikeLogo, name: 'Nike'),
//       images: [
//         BaakasImages.productImage20,
//         BaakasImages.productImage23,
//         BaakasImages.productImage21,
//         BaakasImages.productImage22
//       ],
//       // salePrice: 200,
//       sku: 'ABR4568',
//       categoryId: '8',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '011',
//       title: 'Nike Air Max Red & Black',
//       stock: 15,
//       price: 600,
//       isFeatured: true,
//       thumbnail: BaakasImages.productImage21,
//       description:
//           'This is a Product description for Nike Air Max. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '1', image: BaakasImages.nikeLogo, name: 'Nike'),
//       images: [
//         BaakasImages.productImage21,
//         BaakasImages.productImage20,
//         BaakasImages.productImage19,
//         BaakasImages.productImage22
//       ],
//       salePrice: 400,
//       sku: 'ABR4568',
//       categoryId: '8',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '012',
//       title: 'Nike Basketball shoes Black & Green',
//       stock: 15,
//       price: 600,
//       isFeatured: false,
//       thumbnail: BaakasImages.productImage22,
//       description:
//           'This is a Product description for Nike Basketball shoes. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '1', image: BaakasImages.nikeLogo, name: 'Nike'),
//       images: [
//         BaakasImages.productImage22,
//         BaakasImages.productImage20,
//         BaakasImages.productImage21,
//         BaakasImages.productImage23
//       ],
//       salePrice: 400,
//       sku: 'ABR4568',
//       categoryId: '8',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '013',
//       title: 'Nike wild horse shoes',
//       stock: 15,
//       price: 600,
//       isFeatured: false,
//       thumbnail: BaakasImages.productImage23,
//       description:
//           'This is a Product description for Nike wild horse shoes. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '1', image: BaakasImages.nikeLogo, name: 'Nike'),
//       images: [
//         BaakasImages.productImage23,
//         BaakasImages.productImage20,
//         BaakasImages.productImage21,
//         BaakasImages.productImage22
//       ],
//       salePrice: 400,
//       sku: 'ABR4568',
//       categoryId: '8',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     //Track suits
//     ProductModel(
//       id: '014',
//       title: 'Nike Track suit red',
//       stock: 15,
//       price: 500,
//       isFeatured: true,
//       thumbnail: BaakasImages.productImage26,
//       description:
//           'This is a Product description for Nike Track suit red. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '1', image: BaakasImages.nikeLogo, name: 'Nike'),
//       images: [
//         BaakasImages.productImage26,
//         BaakasImages.productImage24,
//         BaakasImages.productImage25,
//         BaakasImages.productImage27
//       ],
//       // salePrice: 400,
//       sku: 'ABR4568',
//       categoryId: '9',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '015',
//       title: 'Nike Track suit Black',
//       stock: 15,
//       price: 200,
//       thumbnail: BaakasImages.productImage24,
//       description:
//           'This is a Product description for Nike Track suit Black. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '1', image: BaakasImages.nikeLogo, name: 'Nike'),
//       images: [
//         BaakasImages.productImage24,
//         BaakasImages.productImage26,
//         BaakasImages.productImage25,
//         BaakasImages.productImage27
//       ],
//       // salePrice: 400,
//       sku: 'ABR4568',
//       categoryId: '9',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '016',
//       title: 'Nike Track suit Blue',
//       stock: 15,
//       price: 100,
//       thumbnail: BaakasImages.productImage25,
//       description:
//           'This is a Product description for Nike Track suit Blue. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '1', image: BaakasImages.nikeLogo, name: 'Nike'),
//       images: [
//         BaakasImages.productImage25,
//         BaakasImages.productImage24,
//         BaakasImages.productImage26,
//         BaakasImages.productImage27
//       ],
//       // salePrice: 400,
//       sku: 'ABR4568',
//       categoryId: '9',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '017',
//       title: 'Nike Track suit Parrot Green',
//       stock: 15,
//       price: 350,
//       thumbnail: BaakasImages.productImage27,
//       description:
//           'This is a Product description for Nike Track suit Parrot Green. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '1', image: BaakasImages.nikeLogo, name: 'Nike'),
//       images: [
//         BaakasImages.productImage27,
//         BaakasImages.productImage24,
//         BaakasImages.productImage25,
//         BaakasImages.productImage26
//       ],
//       // salePrice: 400,
//       sku: 'ABR4568',
//       categoryId: '9',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     //Sports Equipments
//     ProductModel(
//       id: '018',
//       title: 'Adidas Football',
//       stock: 15,
//       price: 40,
//       isFeatured: true,
//       thumbnail: BaakasImages.productImage28,
//       description:
//           'This is a Product description for Football. There are more things that can be added but i am just practicing and nothing else.',
//       brand:
//           BrandModel(id: '2', image: BaakasImages.adidasLogo, name: 'Adidas'),
//       images: [
//         BaakasImages.productImage28,
//         BaakasImages.productImage29,
//         BaakasImages.productImage30,
//         BaakasImages.productImage31
//       ],
//       // salePrice: 400,
//       sku: 'ABR4568',
//       categoryId: '10',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '019',
//       title: 'Baseball Bat',
//       stock: 15,
//       price: 30,
//       thumbnail: BaakasImages.productImage29,
//       description:
//           'This is a Product description for Baseball Bat. There are more things that can be added but i am just practicing and nothing else.',
//       brand:
//           BrandModel(id: '2', image: BaakasImages.adidasLogo, name: 'Adidas'),
//       images: [
//         BaakasImages.productImage29,
//         BaakasImages.productImage28,
//         BaakasImages.productImage30,
//         BaakasImages.productImage31
//       ],
//       // salePrice: 400,
//       sku: 'ABR4568',
//       categoryId: '10',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '020',
//       title: 'Cricket Bat',
//       stock: 15,
//       price: 25,
//       thumbnail: BaakasImages.productImage30,
//       description:
//           'This is a Product description for Cricket Bat. There are more things that can be added but i am just practicing and nothing else.',
//       brand:
//           BrandModel(id: '2', image: BaakasImages.adidasLogo, name: 'Adidas'),
//       images: [
//         BaakasImages.productImage30,
//         BaakasImages.productImage29,
//         BaakasImages.productImage28,
//         BaakasImages.productImage31
//       ],
//       // salePrice: 400,
//       sku: 'ABR4568',
//       categoryId: '10',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '021',
//       title: 'Tennis Racket',
//       stock: 15,
//       price: 54,
//       thumbnail: BaakasImages.productImage31,
//       description:
//           'This is a Product description for Tennis Racket. There are more things that can be added but i am just practicing and nothing else.',
//       brand:
//           BrandModel(id: '2', image: BaakasImages.adidasLogo, name: 'Adidas'),
//       images: [
//         BaakasImages.productImage31,
//         BaakasImages.productImage29,
//         BaakasImages.productImage30,
//         BaakasImages.productImage28
//       ],
//       // salePrice: 400,1
//       sku: 'ABR4568',
//       categoryId: '10',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),

//     ///Furniture
//     //bedroom
//     ProductModel(
//       id: '022',
//       title: 'Pure Wooden Bed',
//       stock: 15,
//       price: 950,
//       isFeatured: true,
//       thumbnail: BaakasImages.productImage32,
//       description:
//           'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
//       brand:
//           BrandModel(id: '8', image: BaakasImages.kenwoodLogo, name: 'Kenwood'),
//       images: [
//         BaakasImages.productImage43,
//         BaakasImages.productImage44,
//         BaakasImages.productImage45,
//         BaakasImages.productImage46
//       ],
//       salePrice: 600,
//       sku: 'ABR4568',
//       categoryId: '11',
//       productAttributes: [
//         ProductAttributeModel(
//             name: 'Color', values: ['Black', 'Grey', 'Brown']),
//         ProductAttributeModel(
//             name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
//       ],
//       productVariations: [
//         ProductVariationModel(
//             id: '1',
//             stock: 16,
//             price: 36,
//             salePrice: 12.6,
//             image: BaakasImages.productImage32,
//             description:
//                 'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
//             attributeValues: {'Color': 'Brown', 'Size': 'EU 34'}),
//         ProductVariationModel(
//             id: '2',
//             stock: 15,
//             price: 35,
//             image: BaakasImages.productImage45,
//             attributeValues: {'Color': 'Brown', 'Size': 'EU 32'}),
//         ProductVariationModel(
//             id: '3',
//             stock: 14,
//             price: 34,
//             image: BaakasImages.productImage46,
//             attributeValues: {'Color': 'Brown', 'Size': 'EU 30'}),
//         ProductVariationModel(
//             id: '4',
//             stock: 13,
//             price: 33,
//             image: BaakasImages.productImage43,
//             attributeValues: {'Color': 'Black', 'Size': 'EU 32'}),
//         ProductVariationModel(
//             id: '5',
//             stock: 12,
//             price: 32,
//             image: BaakasImages.productImage43,
//             attributeValues: {'Color': 'Black', 'Size': 'EU 34'}),
//         ProductVariationModel(
//             id: '6',
//             stock: 11,
//             price: 31,
//             image: BaakasImages.productImage44,
//             attributeValues: {'Color': 'Grey', 'Size': 'EU 32'}),
//       ],
//       productType: ProductType.variable.toString(),
//     ),
//     ProductModel(
//       id: '023',
//       title: 'Side Table Lamp',
//       stock: 15,
//       price: 25,
//       thumbnail: BaakasImages.productImage33,
//       description:
//           'This is a Product description for Side Table Lamp. There are more things that can be added but i am just practicing and nothing else.',
//       brand:
//           BrandModel(id: '8', image: BaakasImages.kenwoodLogo, name: 'Kenwood'),
//       // salePrice: 400,1
//       sku: 'ABR4568',
//       categoryId: '11',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '024',
//       title: 'Bedroom Sofa',
//       stock: 15,
//       price: 25,
//       thumbnail: BaakasImages.productImage34,
//       description:
//           'This is a Product description for Bedroom Sofa. There are more things that can be added but i am just practicing and nothing else.',
//       brand:
//           BrandModel(id: '8', image: BaakasImages.kenwoodLogo, name: 'Kenwood'),
//       // salePrice: 400,1
//       sku: 'ABR4568',
//       categoryId: '11',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '025',
//       title: 'Wardrobe for Bedroom',
//       stock: 15,
//       price: 56,
//       thumbnail: BaakasImages.productImage35,
//       description:
//           'This is a Product description for Bedroom Wardrobe. There are more things that can be added but i am just practicing and nothing else.',
//       brand:
//           BrandModel(id: '8', image: BaakasImages.kenwoodLogo, name: 'Kenwood'),
//       // salePrice: 400,1
//       sku: 'ABR4568',
//       categoryId: '11',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     //Kitchen
//     ProductModel(
//       id: '026',
//       title: 'Kitchen Counter',
//       stock: 15,
//       price: 1012,
//       thumbnail: BaakasImages.productImage36,
//       description:
//           'This is a Product description for Kitchen Counter. There are more things that can be added but i am just practicing and nothing else.',
//       brand:
//           BrandModel(id: '2', image: BaakasImages.adidasLogo, name: 'Adidas'),
//       // salePrice: 400,1
//       sku: 'ABR4568',
//       categoryId: '12',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '027',
//       title: 'Dinning Table',
//       stock: 15,
//       price: 1012,
//       thumbnail: BaakasImages.productImage37,
//       description:
//           'This is a Product description for Dinning Table. There are more things that can be added but i am just practicing and nothing else.',
//       brand:
//           BrandModel(id: '2', image: BaakasImages.adidasLogo, name: 'Adidas'),
//       // salePrice: 400,1
//       sku: 'ABR4568',
//       categoryId: '12',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '028',
//       title: 'Refrigerator',
//       stock: 15,
//       price: 987,
//       thumbnail: BaakasImages.productImage38,
//       description:
//           'This is a Product description for Refrigerator. There are more things that can be added but i am just practicing and nothing else.',
//       brand:
//           BrandModel(id: '2', image: BaakasImages.adidasLogo, name: 'Adidas'),
//       // salePrice: 400,1
//       sku: 'ABR4568',
//       categoryId: '12',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     //Office
//     ProductModel(
//       id: '029',
//       title: 'Office Chair Red',
//       stock: 15,
//       price: 150,
//       thumbnail: BaakasImages.productImage39,
//       description:
//           'This is a Product description for Office Chair. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '9', image: BaakasImages.ikeaLogo, name: 'IKEA'),
//       // salePrice: 400,1
//       sku: 'ABR4568',
//       categoryId: '13',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '030',
//       title: 'Office Chair White',
//       stock: 15,
//       price: 140,
//       thumbnail: BaakasImages.productImage40,
//       description:
//           'This is a Product description for Office Chair. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '9', image: BaakasImages.ikeaLogo, name: 'IKEA'),
//       // salePrice: 400,1
//       sku: 'ABR4568',
//       categoryId: '13',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '031',
//       title: 'Office Desk Red',
//       stock: 15,
//       price: 360,
//       thumbnail: BaakasImages.productImage41,
//       description:
//           'This is a Product description for Office Desk. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '9', image: BaakasImages.ikeaLogo, name: 'IKEA'),
//       // salePrice: 400,1
//       sku: 'ABR4568',
//       categoryId: '13',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '032',
//       title: 'Office Desk brown',
//       stock: 15,
//       price: 400,
//       thumbnail: BaakasImages.productImage42,
//       description:
//           'This is a Product description for Office Desk. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '9', image: BaakasImages.ikeaLogo, name: 'IKEA'),
//       // salePrice: 400,1
//       sku: 'ABR4568',
//       categoryId: '13',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),

//     ///Electronics
//     //Laptops
//     ProductModel(
//       id: '033',
//       title: 'Acer Laptop RAM 8gb to 16gb 512gb to 2tb',
//       stock: 15,
//       price: 950,
//       isFeatured: true,
//       thumbnail: BaakasImages.productImage56,
//       description:
//           'This is a Product description for Acer Laptop. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '10', image: BaakasImages.acerlogo, name: 'Acer'),
//       images: [
//         BaakasImages.productImage56,
//         BaakasImages.productImage47,
//         BaakasImages.productImage57,
//         BaakasImages.productImage58
//       ],
//       salePrice: 800,
//       sku: 'ABR4568',
//       categoryId: '14',
//       productAttributes: [
//         ProductAttributeModel(name: 'Ram', values: ['6', '8', '16']),
//         ProductAttributeModel(name: 'SSD', values: ['512', '1 tb', '2 tb']),
//       ],
//       productVariations: [
//         ProductVariationModel(
//             id: '1',
//             stock: 16,
//             price: 400,
//             salePrice: 350,
//             image: BaakasImages.productImage56,
//             description:
//                 'This is a Product description for Acer Laptop. There are more things that can be added but i am just practicing and nothing else.',
//             attributeValues: {'Ram': '6', 'hard': '512'}),
//         ProductVariationModel(
//             id: '2',
//             stock: 15,
//             price: 450,
//             image: BaakasImages.productImage47,
//             attributeValues: {'Ram': '8', 'hard': '512'}),
//         ProductVariationModel(
//             id: '3',
//             stock: 14,
//             price: 470,
//             image: BaakasImages.productImage59,
//             attributeValues: {'Ram': '8', 'hard': '1 tb'}),
//         ProductVariationModel(
//             id: '4',
//             stock: 13,
//             price: 500,
//             image: BaakasImages.productImage58,
//             attributeValues: {'Ram': '16', 'hard': '512'}),
//         ProductVariationModel(
//             id: '5',
//             stock: 12,
//             price: 650,
//             image: BaakasImages.productImage57,
//             attributeValues: {'Ram': '16', 'hard': '1 tb'}),
//         ProductVariationModel(
//             id: '6',
//             stock: 11,
//             price: 800,
//             image: BaakasImages.productImage59,
//             attributeValues: {'Ram': '16', 'hard': '2 tb'}),
//       ],
//       productType: ProductType.variable.toString(),
//     ),
//     ProductModel(
//       id: '034',
//       title: 'Acer Laptop 6gb 1tb',
//       stock: 15,
//       price: 400,
//       thumbnail: BaakasImages.productImage48,
//       description:
//           'This is a Product description for Acer Laptop. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '10', image: BaakasImages.acerlogo, name: 'Acer'),
//       // salePrice: 400,1
//       sku: 'ABR4568',
//       categoryId: '14',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '035',
//       title: 'Acer Laptop 6gb 500Gb',
//       stock: 15,
//       price: 400,
//       thumbnail: BaakasImages.productImage49,
//       description:
//           'This is a Product description for Acer Laptop. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '10', image: BaakasImages.acerlogo, name: 'Acer'),
//       // salePrice: 400,1
//       sku: 'ABR4568',
//       categoryId: '14',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '036',
//       title: 'Acer Laptop 4gb 500Gb',
//       stock: 15,
//       price: 400,
//       thumbnail: BaakasImages.productImage50,
//       description:
//           'This is a Product description for Acer Laptop. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '10', image: BaakasImages.acerlogo, name: 'Acer'),
//       // salePrice: 400,1
//       sku: 'ABR4568',
//       categoryId: '14',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     //Mobiles
//     ProductModel(
//       id: '037',
//       title: 'Iphone 13 pro 512gb',
//       stock: 15,
//       price: 999,
//       thumbnail: BaakasImages.productImage51,
//       description:
//           'This is a Product description for Iphone. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '5', image: BaakasImages.appleLogo, name: 'Apple'),
//       // salePrice: 400,1
//       sku: 'ABR4568',
//       categoryId: '15',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '038',
//       title: 'Iphone 14 pro 512gb',
//       stock: 15,
//       price: 999,
//       thumbnail: BaakasImages.productImage52,
//       description:
//           'This is a Product description for Iphone. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '5', image: BaakasImages.appleLogo, name: 'Apple'),
//       // salePrice: 400,1
//       sku: 'ABR4568',
//       categoryId: '15',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '039',
//       title: 'Iphone 14 white 512gb',
//       stock: 15,
//       price: 999,
//       thumbnail: BaakasImages.productImage53,
//       description:
//           'This is a Product description for Iphone. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '5', image: BaakasImages.appleLogo, name: 'Apple'),
//       // salePrice: 400,1
//       sku: 'ABR4568',
//       categoryId: '15',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//     ProductModel(
//       id: '040',
//       title: 'Iphone 12, 4 Colors 128gb and 256gb',
//       stock: 15,
//       price: 950,
//       isFeatured: true,
//       thumbnail: BaakasImages.productImage70,
//       description:
//           'This is a Product description for Iphone 12. There are more things that can be added but i am just practicing and nothing else.',
//       brand: BrandModel(id: '5', image: BaakasImages.appleLogo, name: 'Apple'),
//       images: [
//         BaakasImages.productImage70,
//         BaakasImages.productImage71,
//         BaakasImages.productImage72,
//         BaakasImages.productImage73
//       ],
//       salePrice: 800,
//       sku: 'ABR4568',
//       categoryId: '15',
//       productAttributes: [
//         ProductAttributeModel(
//             name: 'Color', values: ['Green', 'Red', 'Blue', 'Black']),
//         ProductAttributeModel(name: 'Storage', values: ['128 gb', '256 gb']),
//       ],
//       productVariations: [
//         ProductVariationModel(
//             id: '1',
//             stock: 16,
//             price: 400,
//             salePrice: 350,
//             image: BaakasImages.productImage70,
//             description:
//                 'This is a Product description for Iphone 12. There are more things that can be added but i am just practicing and nothing else.',
//             attributeValues: {'Color': 'Red', 'Storage': '128 gb'}),
//         ProductVariationModel(
//             id: '2',
//             stock: 15,
//             price: 450,
//             image: BaakasImages.productImage70,
//             attributeValues: {'Color': 'Red', 'Storage': '256 gb'}),
//         ProductVariationModel(
//             id: '3',
//             stock: 14,
//             price: 470,
//             image: BaakasImages.productImage71,
//             attributeValues: {'Color': 'Blue', 'Storage': '128 gb'}),
//         ProductVariationModel(
//             id: '4',
//             stock: 13,
//             price: 500,
//             image: BaakasImages.productImage71,
//             attributeValues: {'Color': 'Blue', 'Storage': '256 gb'}),
//         ProductVariationModel(
//             id: '5',
//             stock: 12,
//             price: 650,
//             image: BaakasImages.productImage72,
//             attributeValues: {'Color': 'Green', 'Storage': '128 gb'}),
//         ProductVariationModel(
//             id: '5',
//             stock: 12,
//             price: 650,
//             image: BaakasImages.productImage72,
//             attributeValues: {'Color': 'Green', 'Storage': '256 gb'}),
//         ProductVariationModel(
//             id: '6',
//             stock: 11,
//             price: 800,
//             image: BaakasImages.productImage73,
//             attributeValues: {'Color': 'Black', 'Storage': '128 gb'}),
//         ProductVariationModel(
//             id: '6',
//             stock: 11,
//             price: 800,
//             image: BaakasImages.productImage73,
//             attributeValues: {'Color': 'Black', 'Storage': '256 gb'}),
//       ],
//       productType: ProductType.variable.toString(),
//     ),
//     ProductModel(
//       id: '008',
//       title: 'APPLE iPhone 8 (Black, 64 GB)',
//       stock: 15,
//       price: 480,
//       isFeatured: true,
//       thumbnail: BaakasImages.productImage14,
//       description:
//           'This is a Product description for iphone 8. There are more things that can be added but i am just practicing and nothing else.',
//       brand:
//           BrandModel(id: '5', image: BaakasImages.appleLogo, name: 'iphone 8'),
//       images: [
//         BaakasImages.productImage15,
//         BaakasImages.productImage16,
//         BaakasImages.productImage17,
//         BaakasImages.productImage14
//       ],
//       salePrice: 380,
//       sku: 'ABR4568',
//       categoryId: '4',
//       productAttributes: [
//         ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
//         ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
//       ],
//       productType: ProductType.single.toString(),
//     ),
//   ];

//   /// -- Sorting Filters for search
//   static final sortingFilters = [
//     SortFilterModel(id: '1', name: 'Name'),
//     SortFilterModel(id: '2', name: 'Lowest Price'),
//     SortFilterModel(id: '3', name: 'Most Popular'),
//     SortFilterModel(id: '4', name: 'Highest Price'),
//     SortFilterModel(id: '5', name: 'Newest'),
//     SortFilterModel(id: '6', name: 'Most Suitable'),
//   ];

//   /// -- Product Reviews
//   static final List<ProductReviewModel> productReviews = [
//     ProductReviewModel(
//       id: '01',
//       userId: '001',
//       userName: 'John Doe',
//       rating: 4.5,
//       timestamp: DateTime.now(),
//       companyTimestamp: DateTime.now(),
//       userImageUrl: BaakasImages.userProfileImage2,
//       comment:
//           'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
//       companyComment:
//           'Thank you for your kind words, John! We are delighted to hear about your smooth experience with the app. We always strive to offer an intuitive interface for our users. Stay tuned for more updates!',
//     ),
//     ProductReviewModel(
//       id: '02',
//       userId: '002',
//       userName: 'Sophia Wilson',
//       rating: 3.5,
//       timestamp: DateTime.now(),
//       companyTimestamp: DateTime.now(),
//       userImageUrl: BaakasImages.userProfileImage1,
//       comment:
//           'I am genuinely impressed with the app design and the variety of products available. The filter and sort features have made shopping so much easier for me!',
//       companyComment:
//           'Thank you so much, Sophia! We are thrilled to hear you are enjoying the app and finding the features useful. Our goal is to make your shopping experience as efficient and pleasant as possible. Keep exploring, and happy shopping!',
//     ),
//     ProductReviewModel(
//       id: '03',
//       userId: '003',
//       userName: 'Alex Brown',
//       rating: 5,
//       timestamp: DateTime.now(),
//       companyTimestamp: DateTime.now(),
//       userImageUrl: BaakasImages.userProfileImage3,
//       comment:
//           'The app is pretty fast, and the product recommendations are on point! I would love to see more features in the future.',
//       companyComment:
//           'Thanks for the feedback, Alex! We are thrilled to hear you enjoyed the speed and recommendations. We are constantly working on introducing new features, so keep an eye out for the next update!',
//     ),
//   ];
// }

// class SortFilterModel {
//   String id;
//   String name;

//   SortFilterModel({required this.id, required this.name});
// }

import '../../../routes/routes.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/image_strings.dart';
import '../../personalization/models/address_model.dart';
import '../../personalization/models/user_model.dart';
import '../models/banner_model.dart';
import '../models/brand_category_model.dart';
import '../models/brand_model.dart';
import '../models/cart_item_model.dart';
import '../models/cart_model.dart';
import '../models/category_model.dart';
import '../models/order_model.dart';
import '../models/product_attribute_model.dart';
import '../models/product_category_model.dart';
import '../models/product_model.dart';
import '../models/product_review_model.dart';
import '../models/product_variation_model.dart';

class BaakasDummyData {
  /// -- Banners
  static final List<BannerModel> banners = [
    BannerModel(
      imageUrl: BaakasImages.banner1,
      targetScreen: BaakasRoutes.order,
      active: false,
    ),
    BannerModel(
      imageUrl: BaakasImages.banner2,
      targetScreen: BaakasRoutes.cart,
      active: true,
    ),
    BannerModel(
      imageUrl: BaakasImages.banner3,
      targetScreen: BaakasRoutes.favourites,
      active: true,
    ),
    BannerModel(
      imageUrl: BaakasImages.banner4,
      targetScreen: BaakasRoutes.search,
      active: true,
    ),
    BannerModel(
      imageUrl: BaakasImages.banner5,
      targetScreen: BaakasRoutes.settings,
      active: true,
    ),
    BannerModel(
      imageUrl: BaakasImages.banner6,
      targetScreen: BaakasRoutes.userAddress,
      active: true,
    ),
    BannerModel(
      imageUrl: BaakasImages.banner8,
      targetScreen: BaakasRoutes.checkout,
      active: false,
    ),
  ];

  /// -- User
  static final UserModel user = UserModel(
    firstName: 'Dipesh',
    lastName: 'Adhikari',
    email: 'ceo.baakas@gmail.com',
    phoneNumber: '9806565656',
    profilePicture: BaakasImages.user,
    addresses: [
      AddressModel(
        id: '1',
        name: 'Dipesh Adhikari',
        phoneNumber: '9806346565',
        street: 'Shikar chowk,tarahara',
        city: 'Itahari',
        state: 'Koshi',
        postalCode: '87665',
        country: 'Nepal',
      ),
      AddressModel(
        id: '6',
        name: 'John Doe',
        phoneNumber: '+1234567890',
        street: '123 Main Street',
        city: 'New York',
        state: 'New York',
        postalCode: '10001',
        country: 'United States',
      ),
      AddressModel(
        id: '2',
        name: 'Alice Smith',
        phoneNumber: '+9876543210',
        street: '456 Elm Avenue',
        city: 'Los Angeles',
        state: 'California',
        postalCode: '90001',
        country: 'United States',
      ),
      AddressModel(
        id: '3',
        name: 'Taimoor Sikander',
        phoneNumber: '+923178059528',
        street: 'Street 35',
        city: 'Islamabad',
        state: 'Federal',
        postalCode: '48000',
        country: 'Pakistan',
      ),
      AddressModel(
        id: '4',
        name: 'Maria Garcia',
        phoneNumber: '+5412345678',
        street: '789 Oak Road',
        city: 'Buenos Aires',
        state: 'Buenos Aires',
        postalCode: '1001',
        country: 'Argentina',
      ),
      AddressModel(
        id: '5',
        name: 'Liam Johnson',
        phoneNumber: '+447890123456',
        street: '10 Park Lane',
        city: 'London',
        state: 'England',
        postalCode: 'SW1A 1AA',
        country: 'United Kingdom',
      ),
    ],
    username: '',
    id: '',
    gender: '',
    dateOfBirth: '',
  );

  /// -- Cart
  static final CartModel cart = CartModel(
    cartId: '001',
    items: [
      CartItemModel(
        productId: '001',
        variationId: '1',
        quantity: 1,
        title: products[0].title,
        image: products[0].thumbnail,
        brandName: products[0].brand!.name,
        price: products[0].productVariations![0].price,
        selectedVariation: products[0].productVariations![0].attributeValues,
      ),
      CartItemModel(
        productId: '002',
        variationId: '',
        quantity: 1,
        title: products[1].title,
        image: products[1].thumbnail,
        brandName: products[1].brand!.name,
        price: products[1].price,
        selectedVariation:
            products[1].productVariations != null
                ? products[1].productVariations![1].attributeValues
                : {},
      ),
    ],
  );

  /// -- Order
  static final List<OrderModel> orders = [
    OrderModel(
      id: 'CWT0012',
      status: OrderStatus.processing,
      items: cart.items,
      totalAmount: 265,
      orderDate: DateTime(2023, 09, 1),
      deliveryDate: DateTime(2023, 09, 9),
      shippingCost: 5,
      taxCost: 0.05,
      docId: '',
    ),
    OrderModel(
      id: 'CWT0025',
      status: OrderStatus.shipped,
      items: cart.items,
      totalAmount: 369,
      orderDate: DateTime(2023, 10, 2),
      deliveryDate: DateTime(2023, 10, 6),
      shippingCost: 5,
      taxCost: 0.05,
      docId: '',
    ),
    OrderModel(
      id: 'CWT0152',
      status: OrderStatus.delivered,
      items: cart.items,
      totalAmount: 254,
      orderDate: DateTime(2023, 11, 3),
      deliveryDate: DateTime(2023, 11, 8),
      shippingCost: 5,
      taxCost: 0.05,
      docId: '',
    ),
    OrderModel(
      id: 'CWT0265',
      status: OrderStatus.delivered,
      items: cart.items,
      totalAmount: 355,
      orderDate: DateTime(2023, 12, 20),
      deliveryDate: DateTime(2023, 12, 25),
      shippingCost: 5,
      taxCost: 0.05,
      docId: '',
    ),
    OrderModel(
      id: 'CWT1536',
      status: OrderStatus.delivered,
      items: cart.items,
      totalAmount: 115,
      orderDate: DateTime(2023, 12, 25),
      deliveryDate: DateTime(2024, 01, 1),
      shippingCost: 5,
      taxCost: 0.05,
      docId: '',
    ),
  ];

  /// -- List of all Categories
  static final List<CategoryModel> categories = [
    CategoryModel(
      id: '1',
      image: BaakasImages.sportIcon,
      name: 'Sports',
      isFeatured: true,
    ),
    CategoryModel(
      id: '5',
      image: BaakasImages.furnitureIcon,
      name: 'Furniture',
      isFeatured: true,
    ),
    CategoryModel(
      id: '2',
      image: BaakasImages.electronicsIcon,
      name: 'Electronics',
      isFeatured: true,
    ),
    CategoryModel(
      id: '3',
      image: BaakasImages.clothIcon,
      name: 'Clothes',
      isFeatured: true,
    ),
    CategoryModel(
      id: '4',
      image: BaakasImages.animalIcon,
      name: 'Animals',
      isFeatured: true,
    ),
    CategoryModel(
      id: '6',
      image: BaakasImages.shoeIcon,
      name: 'Shoes',
      isFeatured: true,
    ),
    CategoryModel(
      id: '7',
      image: BaakasImages.cosmeticsIcon,
      name: 'Cosmetics',
      isFeatured: true,
    ),
    CategoryModel(
      id: '14',
      image: BaakasImages.jeweleryIcon,
      name: 'Jewelery',
      isFeatured: true,
    ),

    ///subcategories
    CategoryModel(
      id: '8',
      image: BaakasImages.sportIcon,
      name: 'Sport Shoes',
      parentId: '1',
      isFeatured: false,
    ),
    CategoryModel(
      id: '9',
      image: BaakasImages.sportIcon,
      name: 'Track suits',
      parentId: '1',
      isFeatured: false,
    ),
    CategoryModel(
      id: '10',
      image: BaakasImages.sportIcon,
      name: 'Sports Equipments',
      parentId: '1',
      isFeatured: false,
    ),
    //furniture
    CategoryModel(
      id: '11',
      image: BaakasImages.furnitureIcon,
      name: 'Bedroom furniture',
      parentId: '5',
      isFeatured: false,
    ),
    CategoryModel(
      id: '12',
      image: BaakasImages.furnitureIcon,
      name: 'Kitchen furniture',
      parentId: '5',
      isFeatured: false,
    ),
    CategoryModel(
      id: '13',
      image: BaakasImages.furnitureIcon,
      name: 'Office furniture',
      parentId: '5',
      isFeatured: false,
    ),
    //electronics
    CategoryModel(
      id: '14',
      image: BaakasImages.electronicsIcon,
      name: 'Laptop',
      parentId: '2',
      isFeatured: false,
    ),
    CategoryModel(
      id: '15',
      image: BaakasImages.electronicsIcon,
      name: 'Mobile',
      parentId: '2',
      isFeatured: false,
    ),

    CategoryModel(
      id: '16',
      image: BaakasImages.clothIcon,
      name: 'Shirts',
      parentId: '3',
      isFeatured: false,
    ),
  ];

  /// -- List of all Brands
  static final List<BrandModel> brands = [
    BrandModel(
      id: '1',
      image: BaakasImages.nikeLogo,
      name: 'Nike',
      productsCount: 265,
      isFeatured: true,
    ),
    BrandModel(
      id: '2',
      image: BaakasImages.adidasLogo,
      name: 'Adidas',
      productsCount: 95,
      isFeatured: true,
    ),
    BrandModel(
      id: '8',
      image: BaakasImages.kenwoodLogo,
      name: 'Kenwood',
      productsCount: 36,
      isFeatured: false,
    ),
    BrandModel(
      id: '9',
      image: BaakasImages.ikeaLogo,
      name: 'IKEA',
      productsCount: 36,
      isFeatured: false,
    ),
    BrandModel(
      id: '5',
      image: BaakasImages.appleLogo,
      name: 'Apple',
      productsCount: 16,
      isFeatured: true,
    ),
    BrandModel(
      id: '10',
      image: BaakasImages.acerlogo,
      name: 'Acer',
      productsCount: 36,
      isFeatured: false,
    ),
    BrandModel(
      id: '3',
      image: BaakasImages.jordanLogo,
      name: 'Jordan',
      productsCount: 36,
      isFeatured: true,
    ),
    BrandModel(
      id: '4',
      image: BaakasImages.pumaLogo,
      name: 'Puma',
      productsCount: 65,
      isFeatured: true,
    ),
    BrandModel(
      id: '6',
      image: BaakasImages.zaraLogo,
      name: 'ZARA',
      productsCount: 36,
      isFeatured: true,
    ),
    BrandModel(
      id: '7',
      image: BaakasImages.electronicsIcon,
      name: 'Samsung',
      productsCount: 36,
      isFeatured: false,
    ),
  ];

  /// -- List of all Brand Categories
  static final List<BrandCategoryModel> brandCategory = [
    BrandCategoryModel(brandId: '1', categoryId: '1'),
    BrandCategoryModel(brandId: '1', categoryId: '8'),
    BrandCategoryModel(brandId: '1', categoryId: '9'),
    BrandCategoryModel(brandId: '1', categoryId: '10'),
    BrandCategoryModel(brandId: '2', categoryId: '1'),
    BrandCategoryModel(brandId: '2', categoryId: '8'),
    BrandCategoryModel(brandId: '2', categoryId: '9'),
    BrandCategoryModel(brandId: '2', categoryId: '10'),
    BrandCategoryModel(brandId: '3', categoryId: '1'),
    BrandCategoryModel(brandId: '3', categoryId: '8'),
    BrandCategoryModel(brandId: '3', categoryId: '9'),
    BrandCategoryModel(brandId: '3', categoryId: '10'),
    BrandCategoryModel(brandId: '4', categoryId: '1'),
    BrandCategoryModel(brandId: '4', categoryId: '8'),
    BrandCategoryModel(brandId: '4', categoryId: '9'),
    BrandCategoryModel(brandId: '4', categoryId: '10'),
    BrandCategoryModel(brandId: '5', categoryId: '15'),
    BrandCategoryModel(brandId: '5', categoryId: '2'),
    BrandCategoryModel(brandId: '10', categoryId: '2'),
    BrandCategoryModel(brandId: '10', categoryId: '14'),
    BrandCategoryModel(brandId: '6', categoryId: '3'),
    BrandCategoryModel(brandId: '6', categoryId: '16'),
    BrandCategoryModel(brandId: '7', categoryId: '2'),
    BrandCategoryModel(brandId: '8', categoryId: '5'),
    BrandCategoryModel(brandId: '8', categoryId: '11'),
    BrandCategoryModel(brandId: '8', categoryId: '12'),
    BrandCategoryModel(brandId: '8', categoryId: '13'),
    BrandCategoryModel(brandId: '9', categoryId: '5'),
    BrandCategoryModel(brandId: '9', categoryId: '11'),
    BrandCategoryModel(brandId: '9', categoryId: '12'),
    BrandCategoryModel(brandId: '9', categoryId: '13'),
  ];

  /// -- List of all Product Categories
  static final List<ProductCategoryModel> productCategories = [
    ProductCategoryModel(productId: '001', categoryId: '1'),
    ProductCategoryModel(productId: '001', categoryId: '8'),
    ProductCategoryModel(productId: '004', categoryId: '3'),
    ProductCategoryModel(productId: '002', categoryId: '3'),
    ProductCategoryModel(productId: '002', categoryId: '16'),
    ProductCategoryModel(productId: '003', categoryId: '3'),
    ProductCategoryModel(productId: '005', categoryId: '1'),
    ProductCategoryModel(productId: '005', categoryId: '8'),
    ProductCategoryModel(productId: '040', categoryId: '2'),
    ProductCategoryModel(productId: '040', categoryId: '15'),
    ProductCategoryModel(productId: '006', categoryId: '2'),
    ProductCategoryModel(productId: '007', categoryId: '4'),
    ProductCategoryModel(productId: '009', categoryId: '1'),
    ProductCategoryModel(productId: '009', categoryId: '8'),
    ProductCategoryModel(productId: '010', categoryId: '1'),
    ProductCategoryModel(productId: '010', categoryId: '8'),
    ProductCategoryModel(productId: '011', categoryId: '1'),
    ProductCategoryModel(productId: '011', categoryId: '8'),
    ProductCategoryModel(productId: '012', categoryId: '1'),
    ProductCategoryModel(productId: '012', categoryId: '8'),
    ProductCategoryModel(productId: '013', categoryId: '1'),
    ProductCategoryModel(productId: '013', categoryId: '8'),

    ProductCategoryModel(productId: '014', categoryId: '1'),
    ProductCategoryModel(productId: '014', categoryId: '9'),
    ProductCategoryModel(productId: '015', categoryId: '1'),
    ProductCategoryModel(productId: '015', categoryId: '9'),
    ProductCategoryModel(productId: '016', categoryId: '1'),
    ProductCategoryModel(productId: '016', categoryId: '9'),
    ProductCategoryModel(productId: '017', categoryId: '1'),
    ProductCategoryModel(productId: '017', categoryId: '9'),

    ProductCategoryModel(productId: '018', categoryId: '1'),
    ProductCategoryModel(productId: '018', categoryId: '10'),
    ProductCategoryModel(productId: '019', categoryId: '1'),
    ProductCategoryModel(productId: '019', categoryId: '10'),
    ProductCategoryModel(productId: '020', categoryId: '1'),
    ProductCategoryModel(productId: '020', categoryId: '10'),
    ProductCategoryModel(productId: '021', categoryId: '1'),
    ProductCategoryModel(productId: '021', categoryId: '10'),

    ProductCategoryModel(productId: '022', categoryId: '5'),
    ProductCategoryModel(productId: '022', categoryId: '11'),
    ProductCategoryModel(productId: '023', categoryId: '5'),
    ProductCategoryModel(productId: '023', categoryId: '11'),
    ProductCategoryModel(productId: '024', categoryId: '5'),
    ProductCategoryModel(productId: '024', categoryId: '11'),
    ProductCategoryModel(productId: '025', categoryId: '5'),
    ProductCategoryModel(productId: '025', categoryId: '11'),

    ProductCategoryModel(productId: '026', categoryId: '5'),
    ProductCategoryModel(productId: '026', categoryId: '12'),
    ProductCategoryModel(productId: '027', categoryId: '5'),
    ProductCategoryModel(productId: '027', categoryId: '12'),
    ProductCategoryModel(productId: '028', categoryId: '5'),
    ProductCategoryModel(productId: '028', categoryId: '12'),

    ProductCategoryModel(productId: '029', categoryId: '5'),
    ProductCategoryModel(productId: '029', categoryId: '13'),
    ProductCategoryModel(productId: '030', categoryId: '5'),
    ProductCategoryModel(productId: '030', categoryId: '13'),
    ProductCategoryModel(productId: '031', categoryId: '5'),
    ProductCategoryModel(productId: '031', categoryId: '13'),
    ProductCategoryModel(productId: '032', categoryId: '5'),
    ProductCategoryModel(productId: '032', categoryId: '13'),

    ProductCategoryModel(productId: '033', categoryId: '2'),
    ProductCategoryModel(productId: '033', categoryId: '14'),
    ProductCategoryModel(productId: '034', categoryId: '2'),
    ProductCategoryModel(productId: '034', categoryId: '14'),
    ProductCategoryModel(productId: '035', categoryId: '2'),
    ProductCategoryModel(productId: '035', categoryId: '14'),
    ProductCategoryModel(productId: '036', categoryId: '2'),
    ProductCategoryModel(productId: '036', categoryId: '14'),

    ProductCategoryModel(productId: '037', categoryId: '2'),
    ProductCategoryModel(productId: '037', categoryId: '15'),
    ProductCategoryModel(productId: '038', categoryId: '2'),
    ProductCategoryModel(productId: '038', categoryId: '15'),
    ProductCategoryModel(productId: '039', categoryId: '2'),
    ProductCategoryModel(productId: '039', categoryId: '15'),

    //040 after product 005
    ProductCategoryModel(productId: '008', categoryId: '2'),
  ];

  /// -- List of all Products
  static final List<ProductModel> products = [
    ProductModel(
      id: '001',
      title: 'Green Nike sports shoe',
      stock: 15,
      price: 135,
      isFeatured: true,
      thumbnail: BaakasImages.productImage1,
      description: 'Green Nike sports shoe',
      brand: BrandModel(
        id: '1',
        image: BaakasImages.nikeLogo,
        name: 'Nike',
        productsCount: 265,
        isFeatured: true,
      ),
      images: [
        BaakasImages.productImage1,
        BaakasImages.productImage23,
        BaakasImages.productImage21,
        BaakasImages.productImage9,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '1',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'Red']),
        ProductAttributeModel(
          name: 'Size',
          values: ['EU 30', 'EU 32', 'EU 34'],
        ),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 34,
          price: 134,
          salePrice: 122.6,
          image: BaakasImages.productImage1,
          description:
              'This is a Product description for Green Nike sports shoe.',
          attributeValues: {'Color': 'Green', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
          id: '2',
          stock: 15,
          price: 132,
          image: BaakasImages.productImage23,
          attributeValues: {'Color': 'Black', 'Size': 'EU 32'},
        ),
        ProductVariationModel(
          id: '3',
          stock: 0,
          price: 234,
          image: BaakasImages.productImage23,
          attributeValues: {'Color': 'Black', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
          id: '4',
          stock: 222,
          price: 232,
          image: BaakasImages.productImage1,
          attributeValues: {'Color': 'Green', 'Size': 'EU 32'},
        ),
        ProductVariationModel(
          id: '5',
          stock: 0,
          price: 334,
          image: BaakasImages.productImage21,
          attributeValues: {'Color': 'Red', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
          id: '6',
          stock: 11,
          price: 332,
          image: BaakasImages.productImage21,
          attributeValues: {'Color': 'Red', 'Size': 'EU 32'},
        ),
      ],
      productType: ProductType.variable.toString(),
    ),
    ProductModel(
      id: '002',
      title: 'Blue T-shirt for all ages',
      stock: 15,
      price: 35,
      isFeatured: true,
      thumbnail: BaakasImages.productImage69,
      description:
          'This is a Product description for Blue Nike Sleeve less vest. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '6', image: BaakasImages.zaraLogo, name: 'ZARA'),
      images: [
        BaakasImages.productImage68,
        BaakasImages.productImage69,
        BaakasImages.productImage5,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '003',
      title: 'Leather brown Jacket',
      stock: 15,
      price: 38000,
      isFeatured: false,
      thumbnail: BaakasImages.productImage64,
      description:
          'This is a Product description for Leather brown Jacket. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '6', image: BaakasImages.zaraLogo, name: 'ZARA'),
      images: [
        BaakasImages.productImage64,
        BaakasImages.productImage65,
        BaakasImages.productImage66,
        BaakasImages.productImage67,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '004',
      title: '4 Color collar t-shirt dry fit',
      stock: 15,
      price: 135,
      isFeatured: false,
      thumbnail: BaakasImages.productImage60,
      description:
          'This is a Product description for 4 Color collar t-shirt dry fit. There are more things that can be added but its just a demo and nothing else.',
      brand: BrandModel(id: '6', image: BaakasImages.zaraLogo, name: 'ZARA'),
      images: [
        BaakasImages.productImage60,
        BaakasImages.productImage61,
        BaakasImages.productImage62,
        BaakasImages.productImage63,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(
          name: 'Color',
          values: ['Red', 'Yellow', 'Green', 'Blue'],
        ),
        ProductAttributeModel(
          name: 'Size',
          values: ['EU 30', 'EU 32', 'EU 34'],
        ),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 34,
          price: 134,
          salePrice: 122.6,
          image: BaakasImages.productImage60,
          description:
              'This is a Product description for 4 Color collar t-shirt dry fit',
          attributeValues: {'Color': 'Red', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
          id: '2',
          stock: 15,
          price: 132,
          image: BaakasImages.productImage60,
          attributeValues: {'Color': 'Red', 'Size': 'EU 32'},
        ),
        ProductVariationModel(
          id: '3',
          stock: 0,
          price: 234,
          image: BaakasImages.productImage61,
          attributeValues: {'Color': 'Yellow', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
          id: '4',
          stock: 222,
          price: 232,
          image: BaakasImages.productImage61,
          attributeValues: {'Color': 'Yellow', 'Size': 'EU 32'},
        ),
        ProductVariationModel(
          id: '5',
          stock: 0,
          price: 334,
          image: BaakasImages.productImage62,
          attributeValues: {'Color': 'Green', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
          id: '6',
          stock: 11,
          price: 332,
          image: BaakasImages.productImage62,
          attributeValues: {'Color': 'Green', 'Size': 'EU 30'},
        ),
        ProductVariationModel(
          id: '7',
          stock: 0,
          price: 334,
          image: BaakasImages.productImage63,
          attributeValues: {'Color': 'Blue', 'Size': 'EU 30'},
        ),
        ProductVariationModel(
          id: '8',
          stock: 11,
          price: 332,
          image: BaakasImages.productImage63,
          attributeValues: {'Color': 'Blue', 'Size': 'EU 34'},
        ),
      ],
      productType: ProductType.variable.toString(),
    ),

    ///Products after banner
    ProductModel(
      id: '005',
      title: 'Nike Air Jordon Shoes',
      stock: 15,
      price: 35,
      isFeatured: false,
      thumbnail: BaakasImages.productImage10,
      description:
          'Nike Air Jordon Shoes for running. Quality product, Long Lasting',
      brand: BrandModel(
        id: '1',
        image: BaakasImages.nikeLogo,
        name: 'Nike',
        productsCount: 265,
        isFeatured: true,
      ),
      images: [
        BaakasImages.productImage7,
        BaakasImages.productImage8,
        BaakasImages.productImage9,
        BaakasImages.productImage10,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '8',
      productAttributes: [
        ProductAttributeModel(
          name: 'Color',
          values: ['Orange', 'Black', 'Brown'],
        ),
        ProductAttributeModel(
          name: 'Size',
          values: ['EU 30', 'EU 32', 'EU 34'],
        ),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 16,
          price: 36,
          salePrice: 12.6,
          image: BaakasImages.productImage8,
          description:
              'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
          attributeValues: {'Color': 'Orange', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
          id: '2',
          stock: 15,
          price: 35,
          image: BaakasImages.productImage7,
          attributeValues: {'Color': 'Black', 'Size': 'EU 32'},
        ),
        ProductVariationModel(
          id: '3',
          stock: 14,
          price: 34,
          image: BaakasImages.productImage9,
          attributeValues: {'Color': 'Brown', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
          id: '4',
          stock: 13,
          price: 33,
          image: BaakasImages.productImage7,
          attributeValues: {'Color': 'Black', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
          id: '5',
          stock: 12,
          price: 32,
          image: BaakasImages.productImage9,
          attributeValues: {'Color': 'Brown', 'Size': 'EU 32'},
        ),
        ProductVariationModel(
          id: '6',
          stock: 11,
          price: 31,
          image: BaakasImages.productImage8,
          attributeValues: {'Color': 'Orange', 'Size': 'EU 32'},
        ),
      ],
      productType: ProductType.variable.toString(),
    ),
    ProductModel(
      id: '006',
      title: 'SAMSUNG Galaxy S9 (Pink, 64 GB)  (4 GB RAM)',
      stock: 15,
      price: 750,
      isFeatured: false,
      thumbnail: BaakasImages.productImage11,
      description:
          'SAMSUNG Galaxy S9 (Pink, 64 GB)  (4 GB RAM), Long Battery timing',
      brand: BrandModel(
        id: '7',
        image: BaakasImages.appleLogo,
        name: 'Samsung',
      ),
      images: [
        BaakasImages.productImage11,
        BaakasImages.productImage12,
        BaakasImages.productImage13,
        BaakasImages.productImage12,
      ],
      salePrice: 650,
      sku: 'ABR4568',
      categoryId: '2',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '007',
      title: 'TOMI Dog food',
      stock: 15,
      price: 20,
      isFeatured: false,
      thumbnail: BaakasImages.productImage18,
      description:
          'This is a Product description for TOMI Dog food. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '7', image: BaakasImages.appleLogo, name: 'Tomi'),
      salePrice: 10,
      sku: 'ABR4568',
      categoryId: '4',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    //008 after 040
    ProductModel(
      id: '009',
      title: 'Nike Air Jordon 19 Blue',
      stock: 15,
      price: 400,
      isFeatured: false,
      thumbnail: BaakasImages.productImage19,
      description:
          'This is a Product description for Nike Air Jordon. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '1', image: BaakasImages.nikeLogo, name: 'Nike'),
      images: [
        BaakasImages.productImage19,
        BaakasImages.productImage20,
        BaakasImages.productImage21,
        BaakasImages.productImage22,
      ],
      salePrice: 200,
      sku: 'ABR4568',
      categoryId: '8',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '010',
      title: 'Nike Air Jordon 6 Orange',
      stock: 15,
      price: 400,
      thumbnail: BaakasImages.productImage20,
      description:
          'This is a Product description for Nike Air Jordon. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '1', image: BaakasImages.nikeLogo, name: 'Nike'),
      images: [
        BaakasImages.productImage20,
        BaakasImages.productImage23,
        BaakasImages.productImage21,
        BaakasImages.productImage22,
      ],
      // salePrice: 200,
      sku: 'ABR4568',
      categoryId: '8',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '011',
      title: 'Nike Air Max Red & Black',
      stock: 15,
      price: 600,
      isFeatured: true,
      thumbnail: BaakasImages.productImage21,
      description:
          'This is a Product description for Nike Air Max. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '1', image: BaakasImages.nikeLogo, name: 'Nike'),
      images: [
        BaakasImages.productImage21,
        BaakasImages.productImage20,
        BaakasImages.productImage19,
        BaakasImages.productImage22,
      ],
      salePrice: 400,
      sku: 'ABR4568',
      categoryId: '8',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '012',
      title: 'Nike Basketball shoes Black & Green',
      stock: 15,
      price: 600,
      isFeatured: false,
      thumbnail: BaakasImages.productImage22,
      description:
          'This is a Product description for Nike Basketball shoes. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '1', image: BaakasImages.nikeLogo, name: 'Nike'),
      images: [
        BaakasImages.productImage22,
        BaakasImages.productImage20,
        BaakasImages.productImage21,
        BaakasImages.productImage23,
      ],
      salePrice: 400,
      sku: 'ABR4568',
      categoryId: '8',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '013',
      title: 'Nike wild horse shoes',
      stock: 15,
      price: 600,
      isFeatured: false,
      thumbnail: BaakasImages.productImage23,
      description:
          'This is a Product description for Nike wild horse shoes. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '1', image: BaakasImages.nikeLogo, name: 'Nike'),
      images: [
        BaakasImages.productImage23,
        BaakasImages.productImage20,
        BaakasImages.productImage21,
        BaakasImages.productImage22,
      ],
      salePrice: 400,
      sku: 'ABR4568',
      categoryId: '8',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    //Track suits
    ProductModel(
      id: '014',
      title: 'Nike Track suit red',
      stock: 15,
      price: 500,
      isFeatured: true,
      thumbnail: BaakasImages.productImage26,
      description:
          'This is a Product description for Nike Track suit red. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '1', image: BaakasImages.nikeLogo, name: 'Nike'),
      images: [
        BaakasImages.productImage26,
        BaakasImages.productImage24,
        BaakasImages.productImage25,
        BaakasImages.productImage27,
      ],
      // salePrice: 400,
      sku: 'ABR4568',
      categoryId: '9',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '015',
      title: 'Nike Track suit Black',
      stock: 15,
      price: 200,
      thumbnail: BaakasImages.productImage24,
      description:
          'This is a Product description for Nike Track suit Black. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '1', image: BaakasImages.nikeLogo, name: 'Nike'),
      images: [
        BaakasImages.productImage24,
        BaakasImages.productImage26,
        BaakasImages.productImage25,
        BaakasImages.productImage27,
      ],
      // salePrice: 400,
      sku: 'ABR4568',
      categoryId: '9',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '016',
      title: 'Nike Track suit Blue',
      stock: 15,
      price: 100,
      thumbnail: BaakasImages.productImage25,
      description:
          'This is a Product description for Nike Track suit Blue. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '1', image: BaakasImages.nikeLogo, name: 'Nike'),
      images: [
        BaakasImages.productImage25,
        BaakasImages.productImage24,
        BaakasImages.productImage26,
        BaakasImages.productImage27,
      ],
      // salePrice: 400,
      sku: 'ABR4568',
      categoryId: '9',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '017',
      title: 'Nike Track suit Parrot Green',
      stock: 15,
      price: 350,
      thumbnail: BaakasImages.productImage27,
      description:
          'This is a Product description for Nike Track suit Parrot Green. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '1', image: BaakasImages.nikeLogo, name: 'Nike'),
      images: [
        BaakasImages.productImage27,
        BaakasImages.productImage24,
        BaakasImages.productImage25,
        BaakasImages.productImage26,
      ],
      // salePrice: 400,
      sku: 'ABR4568',
      categoryId: '9',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    //Sports Equipments
    ProductModel(
      id: '018',
      title: 'Adidas Football',
      stock: 15,
      price: 40,
      isFeatured: true,
      thumbnail: BaakasImages.productImage28,
      description:
          'This is a Product description for Football. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(
        id: '2',
        image: BaakasImages.adidasLogo,
        name: 'Adidas',
      ),
      images: [
        BaakasImages.productImage28,
        BaakasImages.productImage29,
        BaakasImages.productImage30,
        BaakasImages.productImage31,
      ],
      // salePrice: 400,
      sku: 'ABR4568',
      categoryId: '10',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '019',
      title: 'Baseball Bat',
      stock: 15,
      price: 30,
      thumbnail: BaakasImages.productImage29,
      description:
          'This is a Product description for Baseball Bat. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(
        id: '2',
        image: BaakasImages.adidasLogo,
        name: 'Adidas',
      ),
      images: [
        BaakasImages.productImage29,
        BaakasImages.productImage28,
        BaakasImages.productImage30,
        BaakasImages.productImage31,
      ],
      // salePrice: 400,
      sku: 'ABR4568',
      categoryId: '10',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '020',
      title: 'Cricket Bat',
      stock: 15,
      price: 25,
      thumbnail: BaakasImages.productImage30,
      description:
          'This is a Product description for Cricket Bat. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(
        id: '2',
        image: BaakasImages.adidasLogo,
        name: 'Adidas',
      ),
      images: [
        BaakasImages.productImage30,
        BaakasImages.productImage29,
        BaakasImages.productImage28,
        BaakasImages.productImage31,
      ],
      // salePrice: 400,
      sku: 'ABR4568',
      categoryId: '10',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '021',
      title: 'Tennis Racket',
      stock: 15,
      price: 54,
      thumbnail: BaakasImages.productImage31,
      description:
          'This is a Product description for Tennis Racket. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(
        id: '2',
        image: BaakasImages.adidasLogo,
        name: 'Adidas',
      ),
      images: [
        BaakasImages.productImage31,
        BaakasImages.productImage29,
        BaakasImages.productImage30,
        BaakasImages.productImage28,
      ],
      // salePrice: 400,1
      sku: 'ABR4568',
      categoryId: '10',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),

    ///Furniture
    //bedroom
    ProductModel(
      id: '022',
      title: 'Pure Wooden Bed',
      stock: 15,
      price: 950,
      isFeatured: true,
      thumbnail: BaakasImages.productImage32,
      description:
          'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
      brand: BrandModel(
        id: '8',
        image: BaakasImages.kenwoodLogo,
        name: 'Kenwood',
      ),
      images: [
        BaakasImages.productImage43,
        BaakasImages.productImage44,
        BaakasImages.productImage45,
        BaakasImages.productImage46,
      ],
      salePrice: 600,
      sku: 'ABR4568',
      categoryId: '11',
      productAttributes: [
        ProductAttributeModel(
          name: 'Color',
          values: ['Black', 'Grey', 'Brown'],
        ),
        ProductAttributeModel(
          name: 'Size',
          values: ['EU 30', 'EU 32', 'EU 34'],
        ),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 16,
          price: 36,
          salePrice: 12.6,
          image: BaakasImages.productImage32,
          description:
              'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
          attributeValues: {'Color': 'Brown', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
          id: '2',
          stock: 15,
          price: 35,
          image: BaakasImages.productImage45,
          attributeValues: {'Color': 'Brown', 'Size': 'EU 32'},
        ),
        ProductVariationModel(
          id: '3',
          stock: 14,
          price: 34,
          image: BaakasImages.productImage46,
          attributeValues: {'Color': 'Brown', 'Size': 'EU 30'},
        ),
        ProductVariationModel(
          id: '4',
          stock: 13,
          price: 33,
          image: BaakasImages.productImage43,
          attributeValues: {'Color': 'Black', 'Size': 'EU 32'},
        ),
        ProductVariationModel(
          id: '5',
          stock: 12,
          price: 32,
          image: BaakasImages.productImage43,
          attributeValues: {'Color': 'Black', 'Size': 'EU 34'},
        ),
        ProductVariationModel(
          id: '6',
          stock: 11,
          price: 31,
          image: BaakasImages.productImage44,
          attributeValues: {'Color': 'Grey', 'Size': 'EU 32'},
        ),
      ],
      productType: ProductType.variable.toString(),
    ),
    ProductModel(
      id: '023',
      title: 'Side Table Lamp',
      stock: 15,
      price: 25,
      thumbnail: BaakasImages.productImage33,
      description:
          'This is a Product description for Side Table Lamp. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(
        id: '8',
        image: BaakasImages.kenwoodLogo,
        name: 'Kenwood',
      ),
      // salePrice: 400,1
      sku: 'ABR4568',
      categoryId: '11',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '024',
      title: 'Bedroom Sofa',
      stock: 15,
      price: 25,
      thumbnail: BaakasImages.productImage34,
      description:
          'This is a Product description for Bedroom Sofa. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(
        id: '8',
        image: BaakasImages.kenwoodLogo,
        name: 'Kenwood',
      ),
      // salePrice: 400,1
      sku: 'ABR4568',
      categoryId: '11',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '025',
      title: 'Wardrobe for Bedroom',
      stock: 15,
      price: 56,
      thumbnail: BaakasImages.productImage35,
      description:
          'This is a Product description for Bedroom Wardrobe. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(
        id: '8',
        image: BaakasImages.kenwoodLogo,
        name: 'Kenwood',
      ),
      // salePrice: 400,1
      sku: 'ABR4568',
      categoryId: '11',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    //Kitchen
    ProductModel(
      id: '026',
      title: 'Kitchen Counter',
      stock: 15,
      price: 1012,
      thumbnail: BaakasImages.productImage36,
      description:
          'This is a Product description for Kitchen Counter. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(
        id: '2',
        image: BaakasImages.adidasLogo,
        name: 'Adidas',
      ),
      // salePrice: 400,1
      sku: 'ABR4568',
      categoryId: '12',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '027',
      title: 'Dinning Table',
      stock: 15,
      price: 1012,
      thumbnail: BaakasImages.productImage37,
      description:
          'This is a Product description for Dinning Table. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(
        id: '2',
        image: BaakasImages.adidasLogo,
        name: 'Adidas',
      ),
      // salePrice: 400,1
      sku: 'ABR4568',
      categoryId: '12',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '028',
      title: 'Refrigerator',
      stock: 15,
      price: 987,
      thumbnail: BaakasImages.productImage38,
      description:
          'This is a Product description for Refrigerator. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(
        id: '2',
        image: BaakasImages.adidasLogo,
        name: 'Adidas',
      ),
      // salePrice: 400,1
      sku: 'ABR4568',
      categoryId: '12',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    //Office
    ProductModel(
      id: '029',
      title: 'Office Chair Red',
      stock: 15,
      price: 150,
      thumbnail: BaakasImages.productImage39,
      description:
          'This is a Product description for Office Chair. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '9', image: BaakasImages.ikeaLogo, name: 'IKEA'),
      // salePrice: 400,1
      sku: 'ABR4568',
      categoryId: '13',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '030',
      title: 'Office Chair White',
      stock: 15,
      price: 140,
      thumbnail: BaakasImages.productImage40,
      description:
          'This is a Product description for Office Chair. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '9', image: BaakasImages.ikeaLogo, name: 'IKEA'),
      // salePrice: 400,1
      sku: 'ABR4568',
      categoryId: '13',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '031',
      title: 'Office Desk Red',
      stock: 15,
      price: 360,
      thumbnail: BaakasImages.productImage41,
      description:
          'This is a Product description for Office Desk. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '9', image: BaakasImages.ikeaLogo, name: 'IKEA'),
      // salePrice: 400,1
      sku: 'ABR4568',
      categoryId: '13',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '032',
      title: 'Office Desk brown',
      stock: 15,
      price: 400,
      thumbnail: BaakasImages.productImage42,
      description:
          'This is a Product description for Office Desk. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '9', image: BaakasImages.ikeaLogo, name: 'IKEA'),
      // salePrice: 400,1
      sku: 'ABR4568',
      categoryId: '13',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),

    ///Electronics
    //Laptops
    ProductModel(
      id: '033',
      title: 'Acer Laptop RAM 8gb to 16gb 512gb to 2tb',
      stock: 15,
      price: 950,
      isFeatured: true,
      thumbnail: BaakasImages.productImage56,
      description:
          'This is a Product description for Acer Laptop. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '10', image: BaakasImages.acerlogo, name: 'Acer'),
      images: [
        BaakasImages.productImage56,
        BaakasImages.productImage47,
        BaakasImages.productImage57,
        BaakasImages.productImage58,
      ],
      salePrice: 800,
      sku: 'ABR4568',
      categoryId: '14',
      productAttributes: [
        ProductAttributeModel(name: 'Ram', values: ['6', '8', '16']),
        ProductAttributeModel(name: 'SSD', values: ['512', '1 tb', '2 tb']),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 16,
          price: 400,
          salePrice: 350,
          image: BaakasImages.productImage56,
          description:
              'This is a Product description for Acer Laptop. There are more things that can be added but i am just practicing and nothing else.',
          attributeValues: {'Ram': '6', 'hard': '512'},
        ),
        ProductVariationModel(
          id: '2',
          stock: 15,
          price: 450,
          image: BaakasImages.productImage47,
          attributeValues: {'Ram': '8', 'hard': '512'},
        ),
        ProductVariationModel(
          id: '3',
          stock: 14,
          price: 470,
          image: BaakasImages.productImage59,
          attributeValues: {'Ram': '8', 'hard': '1 tb'},
        ),
        ProductVariationModel(
          id: '4',
          stock: 13,
          price: 500,
          image: BaakasImages.productImage58,
          attributeValues: {'Ram': '16', 'hard': '512'},
        ),
        ProductVariationModel(
          id: '5',
          stock: 12,
          price: 650,
          image: BaakasImages.productImage57,
          attributeValues: {'Ram': '16', 'hard': '1 tb'},
        ),
        ProductVariationModel(
          id: '6',
          stock: 11,
          price: 800,
          image: BaakasImages.productImage59,
          attributeValues: {'Ram': '16', 'hard': '2 tb'},
        ),
      ],
      productType: ProductType.variable.toString(),
    ),
    ProductModel(
      id: '034',
      title: 'Acer Laptop 6gb 1tb',
      stock: 15,
      price: 400,
      thumbnail: BaakasImages.productImage48,
      description:
          'This is a Product description for Acer Laptop. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '10', image: BaakasImages.acerlogo, name: 'Acer'),
      // salePrice: 400,1
      sku: 'ABR4568',
      categoryId: '14',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '035',
      title: 'Acer Laptop 6gb 500Gb',
      stock: 15,
      price: 400,
      thumbnail: BaakasImages.productImage49,
      description:
          'This is a Product description for Acer Laptop. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '10', image: BaakasImages.acerlogo, name: 'Acer'),
      // salePrice: 400,1
      sku: 'ABR4568',
      categoryId: '14',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '036',
      title: 'Acer Laptop 4gb 500Gb',
      stock: 15,
      price: 400,
      thumbnail: BaakasImages.productImage50,
      description:
          'This is a Product description for Acer Laptop. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '10', image: BaakasImages.acerlogo, name: 'Acer'),
      // salePrice: 400,1
      sku: 'ABR4568',
      categoryId: '14',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    //Mobiles
    ProductModel(
      id: '037',
      title: 'Iphone 13 pro 512gb',
      stock: 15,
      price: 999,
      thumbnail: BaakasImages.productImage51,
      description:
          'This is a Product description for Iphone. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '5', image: BaakasImages.appleLogo, name: 'Apple'),
      // salePrice: 400,1
      sku: 'ABR4568',
      categoryId: '15',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '038',
      title: 'Iphone 14 pro 512gb',
      stock: 15,
      price: 999,
      thumbnail: BaakasImages.productImage52,
      description:
          'This is a Product description for Iphone. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '5', image: BaakasImages.appleLogo, name: 'Apple'),
      // salePrice: 400,1
      sku: 'ABR4568',
      categoryId: '15',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '039',
      title: 'Iphone 14 white 512gb',
      stock: 15,
      price: 999,
      thumbnail: BaakasImages.productImage53,
      description:
          'This is a Product description for Iphone. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '5', image: BaakasImages.appleLogo, name: 'Apple'),
      // salePrice: 400,1
      sku: 'ABR4568',
      categoryId: '15',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '040',
      title: 'Iphone 12, 4 Colors 128gb and 256gb',
      stock: 15,
      price: 950,
      isFeatured: true,
      thumbnail: BaakasImages.productImage70,
      description:
          'This is a Product description for Iphone 12. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '5', image: BaakasImages.appleLogo, name: 'Apple'),
      images: [
        BaakasImages.productImage70,
        BaakasImages.productImage71,
        BaakasImages.productImage72,
        BaakasImages.productImage73,
      ],
      salePrice: 800,
      sku: 'ABR4568',
      categoryId: '15',
      productAttributes: [
        ProductAttributeModel(
          name: 'Color',
          values: ['Green', 'Red', 'Blue', 'Black'],
        ),
        ProductAttributeModel(name: 'Storage', values: ['128 gb', '256 gb']),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          stock: 16,
          price: 400,
          salePrice: 350,
          image: BaakasImages.productImage70,
          description:
              'This is a Product description for Iphone 12. There are more things that can be added but i am just practicing and nothing else.',
          attributeValues: {'Color': 'Red', 'Storage': '128 gb'},
        ),
        ProductVariationModel(
          id: '2',
          stock: 15,
          price: 450,
          image: BaakasImages.productImage70,
          attributeValues: {'Color': 'Red', 'Storage': '256 gb'},
        ),
        ProductVariationModel(
          id: '3',
          stock: 14,
          price: 470,
          image: BaakasImages.productImage71,
          attributeValues: {'Color': 'Blue', 'Storage': '128 gb'},
        ),
        ProductVariationModel(
          id: '4',
          stock: 13,
          price: 500,
          image: BaakasImages.productImage71,
          attributeValues: {'Color': 'Blue', 'Storage': '256 gb'},
        ),
        ProductVariationModel(
          id: '5',
          stock: 12,
          price: 650,
          image: BaakasImages.productImage72,
          attributeValues: {'Color': 'Green', 'Storage': '128 gb'},
        ),
        ProductVariationModel(
          id: '5',
          stock: 12,
          price: 650,
          image: BaakasImages.productImage72,
          attributeValues: {'Color': 'Green', 'Storage': '256 gb'},
        ),
        ProductVariationModel(
          id: '6',
          stock: 11,
          price: 800,
          image: BaakasImages.productImage73,
          attributeValues: {'Color': 'Black', 'Storage': '128 gb'},
        ),
        ProductVariationModel(
          id: '6',
          stock: 11,
          price: 800,
          image: BaakasImages.productImage73,
          attributeValues: {'Color': 'Black', 'Storage': '256 gb'},
        ),
      ],
      productType: ProductType.variable.toString(),
    ),
    ProductModel(
      id: '008',
      title: 'APPLE iPhone 8 (Black, 64 GB)',
      stock: 15,
      price: 480,
      isFeatured: true,
      thumbnail: BaakasImages.productImage14,
      description:
          'This is a Product description for iphone 8. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(
        id: '5',
        image: BaakasImages.appleLogo,
        name: 'iphone 8',
      ),
      images: [
        BaakasImages.productImage15,
        BaakasImages.productImage16,
        BaakasImages.productImage17,
        BaakasImages.productImage14,
      ],
      salePrice: 380,
      sku: 'ABR4568',
      categoryId: '4',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
  ];

  /// -- Sorting Filters for search
  static final sortingFilters = [
    SortFilterModel(id: '1', name: 'Name'),
    SortFilterModel(id: '2', name: 'Lowest Price'),
    SortFilterModel(id: '3', name: 'Most Popular'),
    SortFilterModel(id: '4', name: 'Highest Price'),
    SortFilterModel(id: '5', name: 'Newest'),
    SortFilterModel(id: '6', name: 'Most Suitable'),
  ];

  /// -- Product Reviews
  static final List<ProductReviewModel> productReviews = [
    ProductReviewModel(
      id: '01',
      userId: '001',
      userName: 'John Doe',
      rating: 4.5,
      timestamp: DateTime.now(),
      companyTimestamp: DateTime.now(),
      userImageUrl: BaakasImages.userProfileImage2,
      comment:
          'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
      companyComment:
          'Thank you for your kind words, John! We are delighted to hear about your smooth experience with the app. We always strive to offer an intuitive interface for our users. Stay tuned for more updates!',
    ),
    ProductReviewModel(
      id: '02',
      userId: '002',
      userName: 'Sophia Wilson',
      rating: 3.5,
      timestamp: DateTime.now(),
      companyTimestamp: DateTime.now(),
      userImageUrl: BaakasImages.userProfileImage1,
      comment:
          'I am genuinely impressed with the app design and the variety of products available. The filter and sort features have made shopping so much easier for me!',
      companyComment:
          'Thank you so much, Sophia! We are thrilled to hear you are enjoying the app and finding the features useful. Our goal is to make your shopping experience as efficient and pleasant as possible. Keep exploring, and happy shopping!',
    ),
    ProductReviewModel(
      id: '03',
      userId: '003',
      userName: 'Alex Brown',
      rating: 5,
      timestamp: DateTime.now(),
      companyTimestamp: DateTime.now(),
      userImageUrl: BaakasImages.userProfileImage3,
      comment:
          'The app is pretty fast, and the product recommendations are on point! I would love to see more features in the future.',
      companyComment:
          'Thanks for the feedback, Alex! We are thrilled to hear you enjoyed the speed and recommendations. We are constantly working on introducing new features, so keep an eye out for the next update!',
    ),
  ];
}

class SortFilterModel {
  String id;
  String name;

  SortFilterModel({required this.id, required this.name});
}
