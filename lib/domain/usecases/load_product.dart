import '../entities/entities.dart';

abstract class LoadProduct {
  Future<ProductEntity?> load(String code);
}
