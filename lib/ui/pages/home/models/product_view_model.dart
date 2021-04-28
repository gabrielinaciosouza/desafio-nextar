import 'package:equatable/equatable.dart';

class ProductViewModel extends Equatable {
  final String name;
  final num? price;
  final num? stock;
  final String code;
  final String? imagePath;
  final String creationDate;

  ProductViewModel(
      {required this.name,
      required this.price,
      required this.stock,
      required this.code,
      required this.imagePath,
      required this.creationDate});

  @override
  List<Object?> get props =>
      [name, price, stock, code, creationDate, imagePath];
}
