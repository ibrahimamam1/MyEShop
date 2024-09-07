import 'package:e_shop/common/widgets/loaders/loaders.dart';

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
    return BrandModel(id: data['Id'], image: data['Image'], name: data['Name']);
  }
}
