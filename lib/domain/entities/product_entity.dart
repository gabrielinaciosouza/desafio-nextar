class ProductEntity {
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
}
