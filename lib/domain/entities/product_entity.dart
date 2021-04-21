import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String name;
  final num? price;
  final num? stock;
  final String code;
  final DateTime creationDate;

  ProductEntity(
      {required this.name,
      this.price,
      this.stock,
      required this.code,
      required this.creationDate});

  @override
  List<Object?> get props => [name, price, stock, code, creationDate];
}
