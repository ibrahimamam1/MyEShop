import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/features/shop/models/brand_model.dart';
import 'package:e_shop/features/shop/models/product_attribute_model.dart';
import 'package:e_shop/features/shop/models/product_model.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  // Firestore instance for database interactions
  final _db = FirebaseFirestore.instance;

  // Get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();

      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  // Get limited featured products
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .get();

      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  // Get Products based on a query
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshop = await query.get();
      final List<ProductModel> productList = querySnapshop.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();

      return productList;
    } on FirebaseException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  // Get Products based on brands
  Future<List<ProductModel>> fetchProductsForBrands(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshop = limit == -1
          ? await _db
              .collection('Products')
              .where('BrandId', isEqualTo: brandId)
              .get()
          : await _db
              .collection('Products')
              .where('BrandId', isEqualTo: brandId)
              .limit(limit)
              .get();

      final products = querySnapshop.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  // Get Products based on category
  Future<List<ProductModel>> fetchProductsForCategory(
      {required String categoryId, int limit = 4}) async {
    try {
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db
              .collection('ProductCategory')
              .where('CategoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('ProductCategory')
              .where('CategoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();

      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['ProductId'] as String)
          .toList();

      final productsQuery = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      List<ProductModel> products = productsQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  // Get Products based favourites
  Future<List<ProductModel>> fetchFavouriteProducts(
      List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadDummyProducts() async {
    final List<ProductModel> products = [
      ProductModel(
        id: '1',
        stock: 255,
        sku: 'In Stock',
        price: 30,
        title: 'Adidas Football',
        date: DateTime.now(),
        salePrice: 30,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2FAdidas_Football.png?alt=media&token=3203dfb2-c79a-4cda-9389-6cf1b518d8be',
        isFeatured: true,
        brand: BrandModel(id: '', image: '', name: 'Adidas'),
        description: 'High Quality Adidas Football',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Green', 'Red', 'Black']),
          ProductAttributeModel(name: 'Size', values: ['EU 10', 'EU 15'])
        ],
      ),
      ProductModel(
        id: '2',
        stock: 120,
        sku: 'In Stock',
        price: 699.99,
        title: 'iPhone 8 Mobile',
        date: DateTime.now(),
        salePrice: 649.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2Fiphone8_mobile_back.png?alt=media&token=b69c3014-5e1d-46ce-94f4-087d9f80a9ee',
        isFeatured: false,
        brand: BrandModel(id: '', image: '', name: 'Apple'),
        description: 'Apple iPhone 8 with advanced features',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Silver', 'Space Gray', 'Gold']),
          ProductAttributeModel(name: 'Storage', values: ['64GB', '256GB'])
        ],
      ),
      ProductModel(
        id: '3',
        stock: 80,
        sku: 'In Stock',
        price: 999.99,
        title: 'iPhone 13 Pro',
        date: DateTime.now(),
        salePrice: 949.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2Fiphone_13_pro.png?alt=media&token=ec8a8b7b-f5a5-423e-b610-ab819cc7e407',
        isFeatured: true,
        brand: BrandModel(id: '', image: '', name: 'Apple'),
        description: 'Latest iPhone 13 Pro with pro-grade cameras',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color',
              values: ['Graphite', 'Gold', 'Silver', 'Sierra Blue']),
          ProductAttributeModel(
              name: 'Storage', values: ['128GB', '256GB', '512GB', '1TB'])
        ],
      ),
      ProductModel(
        id: '4',
        stock: 50,
        sku: 'In Stock',
        price: 1199.99,
        title: 'iPhone 14 Pro',
        date: DateTime.now(),
        salePrice: 1149.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2Fiphone_14_pro.png?alt=media&token=cca768fd-432f-4695-813e-7ff1b4bb106f',
        isFeatured: true,
        brand: BrandModel(id: '', image: '', name: 'Apple'),
        description:
            'The latest iPhone 14 Pro with advanced features and powerful performance',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color',
              values: ['Deep Purple', 'Gold', 'Silver', 'Space Black']),
          ProductAttributeModel(
              name: 'Storage', values: ['128GB', '256GB', '512GB', '1TB'])
        ],
      ),
      ProductModel(
        id: '5',
        stock: 30,
        sku: 'In Stock',
        price: 599.99,
        title: 'Kitchen Counter',
        date: DateTime.now(),
        salePrice: 549.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2Fkitchen_counter.png?alt=media&token=94d5b6c1-a33e-4b67-8c68-8f350becf061',
        isFeatured: false,
        brand: BrandModel(id: '', image: '', name: 'HomeStyle'),
        description: 'Modern kitchen counter with ample storage space',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['White', 'Oak', 'Cherry']),
          ProductAttributeModel(
              name: 'Size', values: ['Small', 'Medium', 'Large'])
        ],
      ),
      ProductModel(
        id: '6',
        stock: 25,
        sku: 'In Stock',
        price: 799.99,
        title: 'Kitchen Dining Table',
        date: DateTime.now(),
        salePrice: 749.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2Fkitchen_dining%20table.png?alt=media&token=2aaaa27b-f4e3-46a1-81b4-14ad89eea200',
        isFeatured: true,
        brand: BrandModel(id: '', image: '', name: 'DineElegant'),
        description: 'Stylish kitchen dining table for family gatherings',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(
              name: 'Material', values: ['Wood', 'Glass', 'Marble']),
          ProductAttributeModel(
              name: 'Seating', values: ['4 Seats', '6 Seats', '8 Seats'])
        ],
      ),
      ProductModel(
        id: '7',
        stock: 15,
        sku: 'In Stock',
        price: 1299.99,
        title: 'Kitchen Refrigerator',
        date: DateTime.now(),
        salePrice: 1199.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2Fkitchen_refrigerator.png?alt=media&token=a78fb184-b60c-432c-915e-7c98f0636d59',
        isFeatured: true,
        brand: BrandModel(id: '', image: '', name: 'CoolTech'),
        description: 'Spacious and energy-efficient kitchen refrigerator',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Stainless Steel', 'White', 'Black']),
          ProductAttributeModel(
              name: 'Capacity',
              values: ['18 cu. ft.', '22 cu. ft.', '26 cu. ft.'])
        ],
      ),
      ProductModel(
        id: '8',
        stock: 100,
        sku: 'In Stock',
        price: 89.99,
        title: 'Tracksuit Parrot Green',
        date: DateTime.now(),
        salePrice: 79.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2Ftrcksuit_parrotgreen.png?alt=media&token=f515894b-4cac-498f-9cdb-dc10c054e798',
        isFeatured: false,
        brand: BrandModel(id: '', image: '', name: 'SportyChic'),
        description:
            'Comfortable parrot green tracksuit for sports and casual wear',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L', 'XL']),
          ProductAttributeModel(
              name: 'Material', values: ['Cotton', 'Polyester'])
        ],
      ),
      ProductModel(
        id: '9',
        stock: 150,
        sku: 'In Stock',
        price: 29.99,
        title: 'T-shirt Yellow Collar',
        date: DateTime.now(),
        salePrice: 24.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2Ftshirt_yellow_collar.png?alt=media&token=bd52b9a0-d7f6-4338-ab42-b6db8866df26',
        isFeatured: true,
        brand: BrandModel(id: '', image: '', name: 'CasualWear'),
        description: 'Stylish yellow collar t-shirt for a trendy look',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(
              name: 'Size', values: ['XS', 'S', 'M', 'L', 'XL']),
          ProductAttributeModel(
              name: 'Material', values: ['Cotton', 'Cotton Blend'])
        ],
      ),
      ProductModel(
        id: '10',
        stock: 75,
        sku: 'In Stock',
        price: 199.99,
        title: 'Nike Air Jordan Single Orange',
        date: DateTime.now(),
        salePrice: 179.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2FNikeAirJordonSingleOrange.png?alt=media&token=7c3ad5ca-392b-4d1d-98b2-17a6f09cf19c',
        isFeatured: true,
        brand: BrandModel(id: '', image: '', name: 'Nike'),
        description: 'Iconic Nike Air Jordan in vibrant orange color',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(
              name: 'Size', values: ['US 7', 'US 8', 'US 9', 'US 10', 'US 11']),
          ProductAttributeModel(name: 'Width', values: ['Regular', 'Wide'])
        ],
      ),
      ProductModel(
        id: '11',
        stock: 100,
        sku: 'In Stock',
        price: 149.99,
        title: 'Nike Air Max',
        date: DateTime.now(),
        salePrice: 129.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2FNikeAirMax.png?alt=media&token=17199b8e-105f-477b-9b15-4785b845d96c',
        isFeatured: false,
        brand: BrandModel(id: '', image: '', name: 'Nike'),
        description: 'Comfortable Nike Air Max for everyday wear',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(name: 'Size', values: [
            'US 6',
            'US 7',
            'US 8',
            'US 9',
            'US 10',
            'US 11',
            'US 12'
          ]),
          ProductAttributeModel(
              name: 'Color', values: ['Black/White', 'Grey/Red', 'Blue/White'])
        ],
      ),
      ProductModel(
        id: '12',
        stock: 60,
        sku: 'In Stock',
        price: 179.99,
        title: 'Nike Basketball Shoe Green Black',
        date: DateTime.now(),
        salePrice: 159.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2FNikeBasketballShoeGreenBlack.png?alt=media&token=ec37b02a-3428-4ea2-a9dd-ae6926be8a6f',
        isFeatured: true,
        brand: BrandModel(id: '', image: '', name: 'Nike'),
        description: 'High-performance Nike basketball shoe in green and black',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(
              name: 'Size',
              values: ['US 8', 'US 9', 'US 10', 'US 11', 'US 12', 'US 13']),
          ProductAttributeModel(
              name: 'Ankle Support', values: ['High', 'Medium'])
        ],
      ),
      ProductModel(
        id: '13',
        stock: 80,
        sku: 'In Stock',
        price: 139.99,
        title: 'Nike Wildhorse',
        date: DateTime.now(),
        salePrice: 129.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2FNikeWildhorse.png?alt=media&token=bec909f4-6cdd-4ff5-97f7-1495a5eccb06',
        isFeatured: false,
        brand: BrandModel(id: '', image: '', name: 'Nike'),
        description: 'Durable Nike Wildhorse trail running shoe',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(
              name: 'Size',
              values: ['US 7', 'US 8', 'US 9', 'US 10', 'US 11', 'US 12']),
          ProductAttributeModel(name: 'Terrain', values: ['Trail', 'Mixed'])
        ],
      ),
      ProductModel(
        id: '14',
        stock: 40,
        sku: 'In Stock',
        price: 899.99,
        title: 'Acer Laptop 1',
        date: DateTime.now(),
        salePrice: 849.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2Facer_laptop_1.png?alt=media&token=252018bb-5f2d-4d86-9813-e6baa513aa51',
        isFeatured: true,
        brand: BrandModel(id: '', image: '', name: 'Acer'),
        description: 'Powerful Acer laptop for work and entertainment',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(name: 'RAM', values: ['8GB', '16GB', '32GB']),
          ProductAttributeModel(
              name: 'Storage', values: ['256GB SSD', '512GB SSD', '1TB SSD'])
        ],
      ),
      ProductModel(
        id: '15',
        stock: 120,
        sku: 'In Stock',
        price: 59.99,
        title: 'Baseball Bat',
        date: DateTime.now(),
        salePrice: 54.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2Fbaseball_bat.png?alt=media&token=024cbb8f-5260-4b7d-adae-ce5a45af2d05',
        isFeatured: false,
        brand: BrandModel(id: '', image: '', name: 'SportsPro'),
        description:
            'High-quality baseball bat for professional and amateur players',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(name: 'Material', values: ['Aluminum', 'Wood']),
          ProductAttributeModel(
              name: 'Length', values: ['28"', '29"', '30"', '31"', '32"'])
        ],
      ),
      ProductModel(
        id: '16',
        stock: 25,
        sku: 'In Stock',
        price: 799.99,
        title: 'Bedroom Bed',
        date: DateTime.now(),
        salePrice: 749.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2Fbedroom_bed.png?alt=media&token=84cb327f-120c-4bbf-8c44-8de723dc2f75',
        isFeatured: true,
        brand: BrandModel(id: '', image: '', name: 'SleepWell'),
        description: 'Comfortable bedroom bed for a good night\'s sleep',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(
              name: 'Size', values: ['Twin', 'Full', 'Queen', 'King']),
          ProductAttributeModel(name: 'Material', values: ['Wood', 'Metal'])
        ],
      ),
      ProductModel(
        id: '17',
        stock: 20,
        sku: 'In Stock',
        price: 849.99,
        title: 'Bedroom Bed Black',
        date: DateTime.now(),
        salePrice: 799.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2Fbedroom_bed_black.png?alt=media&token=2d4acd6d-a21b-40af-b1a0-610080793954',
        isFeatured: false,
        brand: BrandModel(id: '', image: '', name: 'SleepWell'),
        description: 'Stylish black bedroom bed for modern interiors',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(
              name: 'Size', values: ['Full', 'Queen', 'King']),
          ProductAttributeModel(
              name: 'Headboard', values: ['Included', 'Not Included'])
        ],
      ),
      ProductModel(
        id: '18',
        stock: 50,
        sku: 'In Stock',
        price: 79.99,
        title: 'Bedroom Lamp',
        date: DateTime.now(),
        salePrice: 69.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2Fbedroom_lamp.png?alt=media&token=99cfdb57-631e-4289-8354-fa4eec6bdced',
        isFeatured: true,
        brand: BrandModel(id: '', image: '', name: 'LightCraft'),
        description: 'Elegant bedroom lamp for ambient lighting',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(
              name: 'Style', values: ['Modern', 'Classic', 'Minimalist']),
          ProductAttributeModel(
              name: 'Bulb Type', values: ['LED', 'Incandescent', 'CFL'])
        ],
      ),
      ProductModel(
        id: '19',
        stock: 30,
        sku: 'Out of Stock',
        price: 499.99,
        title: 'Bedroom Sofa',
        date: DateTime.now(),
        salePrice: 449.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2Fbedroom_sofa.png?alt=media&token=463c21f2-8d02-4245-a636-c6a7e80124c5',
        isFeatured: false,
        brand: BrandModel(id: '', image: '', name: 'ComfyLiving'),
        description: 'Cozy bedroom sofa for relaxation and extra seating',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(
              name: 'Material', values: ['Fabric', 'Leather']),
          ProductAttributeModel(
              name: 'Color', values: ['Beige', 'Gray', 'Blue'])
        ],
      ),
      ProductModel(
        id: '20',
        stock: 15,
        sku: 'In Stock',
        price: 899.99,
        title: 'Bedroom Wardrobe',
        date: DateTime.now(),
        salePrice: 849.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2Fbedroom_wardrobe.png?alt=media&token=061dba63-fb1d-47fb-a090-67d5c2439ec0',
        isFeatured: true,
        brand: BrandModel(id: '', image: '', name: 'StorageMax'),
        description: 'Spacious bedroom wardrobe for organized storage',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(
              name: 'Size', values: ['Small', 'Medium', 'Large']),
          ProductAttributeModel(name: 'Doors', values: ['Sliding', 'Hinged'])
        ],
      ),
      ProductModel(
        id: '21',
        stock: 90,
        sku: 'In Stock',
        price: 699.99,
        title: 'iPhone 8 Mobile',
        date: DateTime.now(),
        salePrice: 649.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2Fiphone8_mobile.png?alt=media&token=3967b444-39cd-49ba-bc9b-455e91c3e9aa',
        isFeatured: false,
        brand: BrandModel(id: '', image: '', name: 'Apple'),
        description: 'iPhone 8 with powerful features and sleek design',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(name: 'Storage', values: ['64GB', '256GB']),
          ProductAttributeModel(
              name: 'Color', values: ['Silver', 'Space Gray', 'Gold'])
        ],
      ),
      ProductModel(
        id: '22',
        stock: 70,
        sku: 'In Stock',
        price: 189.99,
        title: 'Nike Air Jordan Single Blue',
        date: DateTime.now(),
        salePrice: 169.99,
        thumbnail:
            'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FProducts%2FNikeAirJordonSingleBlue.png?alt=media&token=57d5b390-eeeb-4423-9d2f-2506a7d95cb6',
        isFeatured: true,
        brand: BrandModel(id: '', image: '', name: 'Nike'),
        description: 'Stylish Nike Air Jordan in eye-catching blue color',
        categoryId: '',
        productType: 'Single',
        productAttributes: [
          ProductAttributeModel(
              name: 'Size',
              values: ['US 7', 'US 8', 'US 9', 'US 10', 'US 11', 'US 12']),
          ProductAttributeModel(name: 'Width', values: ['Regular', 'Wide'])
        ],
      ),
    ];

    int i = 1;
    for (var product in products) {
      await _db.collection('Products').doc(i.toString()).set(product.toJson());
      i++;
    }
  }
}
