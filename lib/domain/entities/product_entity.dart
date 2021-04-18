class ProductEntity {
  final String name;
  final num? price;
  final num? stock;
  final String code;

  ProductEntity(
      {required this.name, this.price, this.stock, required this.code});
}
