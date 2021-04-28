import '../../domain/entities/entities.dart';

class LocalProductModel {
  final String name;
  final num? price;
  final num? stock;
  final String? imagePath;
  final String code;
  final DateTime creationDate;

  LocalProductModel(
      {required this.name,
      required this.price,
      required this.code,
      required this.imagePath,
      required this.creationDate,
      required this.stock});

  factory LocalProductModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['name', 'creationDate', 'code'])) {
      throw Exception();
    }
    return LocalProductModel(
        name: json['name'],
        code: json['code'],
        imagePath: json['imagePath'],
        creationDate: DateTime.parse(json['creationDate']),
        price: json['price'] != 'null' ? num.parse(json['price']) : null,
        stock: json['stock'] != 'null' ? num.parse(json['stock']) : null);
  }

  ProductEntity toEntity() => ProductEntity(
      code: code,
      creationDate: creationDate,
      name: name,
      imagePath: imagePath,
      price: price,
      stock: stock);
}
