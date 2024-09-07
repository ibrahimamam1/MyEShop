import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/features/shop/models/brand_model.dart';
import 'package:e_shop/features/shop/models/product_attribute_model.dart';
import 'package:e_shop/features/shop/models/product_variation_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel(
      {required this.id,
      required this.title,
      required this.stock,
      required this.price,
      required this.thumbnail,
      required this.productType,
      this.sku,
      this.brand,
      this.date,
      this.images,
      this.salePrice = 0.0,
      this.isFeatured,
      this.categoryId,
      this.description,
      this.productAttributes,
      this.productVariations});

  static ProductModel empty() => ProductModel(
      id: '', title: '', stock: 0, price: 0, thumbnail: '', productType: '');

  //Json Format
  toJson() {
    return {
      'Sku': sku,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Images': images ?? [],
      'Thumbnail': thumbnail,
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Brand': brand!.toJson(),
      'Description': description,
      'ProductType': productType,
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'ProductVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data() ?? {};
    return ProductModel(
        id: document.id,
        title: data['Title'] ?? '',
        stock: int.parse((data['Stock'] ?? 0).toString()),
        price: double.parse((data['Price'] ?? 0.0).toString()),
        thumbnail: data['Thumbnail'] ?? '',
        productType: data['ProductType'] ?? '',
        description: data['Description'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        brand: BrandModel.fromJson(data['Brand']),
        salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
        sku: data['Sku'] ?? '',
        categoryId: data['CategoryId'] ?? '',
        images: data['Images'] != null ? List<String>.from(data['Images']) : [],
        productVariations: (data['ProductVariations'] as List<dynamic>)
            .map((e) => ProductVariationModel.fromJson(e))
            .toList(),
        productAttributes: (data['ProductAttributes'] as List<dynamic>)
            .map((e) => ProductAttributeModel.fromJson(e))
            .toList());
  }

  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
        id: document.id,
        title: data['Title'] ?? '',
        stock: int.parse((data['Stock'] ?? 0).toString()),
        price: double.parse((data['Price'] ?? 0.0).toString()),
        thumbnail: data['Thumbnail'] ?? '',
        productType: data['ProductType'] ?? '',
        description: data['Description'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        brand: BrandModel.fromJson(data['Brand']),
        salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
        sku: data['Sku'] ?? '',
        categoryId: data['CategoryId'] ?? '',
        images: data['Images'] != null ? List<String>.from(data['Images']) : [],
        productVariations: (data['ProductVariations'] as List<dynamic>)
            .map((e) => ProductVariationModel.fromJson(e))
            .toList(),
        productAttributes: (data['ProductAttributes'] as List<dynamic>)
            .map((e) => ProductAttributeModel.fromJson(e))
            .toList());
  }
}
