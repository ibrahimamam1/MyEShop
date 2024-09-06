class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({this.name, this.values});

  toJson() {
    return {'Name': name, 'Values': values};
  }

  //map json data to model
  factory ProductAttributeModel.fromJson(Map<String, dynamic> data) {
    if (data.isEmpty) return ProductAttributeModel();

    return ProductAttributeModel(
      name: data.containsKey('Name') ? data['Name'] : '',
      values: List<String>.from(data['Values']),
    );
  }
}
