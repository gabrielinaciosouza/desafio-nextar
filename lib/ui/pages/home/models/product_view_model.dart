class ProductViewModel {
  final String name;
  final num? price;
  final num? stock;
  final String code;
  final String creationDate;

  ProductViewModel(
      {required this.name,
      required this.price,
      required this.stock,
      required this.code,
      required this.creationDate});
}
