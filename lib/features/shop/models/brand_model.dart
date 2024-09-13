import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.image,
    required this.name,
    this.isFeatured,
    this.productsCount,
  });

  //Emtpy brand model
  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  //convert model to json
  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'Productscount': productsCount,
      'IsFeatured': isFeatured,
    };
  }

  //Map Json data to model
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
        id: data['Id'] ?? '',
        image: data['Image'] ?? '',
        name: data['Name'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        productsCount: int.parse((data['Productscount'] ?? 0).toString()));
  }

  //Map Snapshot data to model
  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      //Map Json to Model

      return BrandModel(
          id: document.id,
          image: data['Image'] ?? '',
          name: data['Name'] ?? '',
          productsCount: data['Productscount'] ?? 0,
          isFeatured: data['IsFeatured'] ?? false);
    } else {
      return BrandModel.empty();
    }
  }
}
