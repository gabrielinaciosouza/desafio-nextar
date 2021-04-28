import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String name;
  final num? price;
  final num? stock;
  final String code;
  final String? imagePath;
  final DateTime creationDate;

  ProductEntity(
      {required this.name,
      this.price,
      this.stock,
      this.imagePath,
      required this.code,
      required this.creationDate});

  @override
  List get props => [name, price, stock, code, creationDate, imagePath];
}
