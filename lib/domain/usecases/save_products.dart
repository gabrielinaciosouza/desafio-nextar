import '../entities/entities.dart';

abstract class SaveProduct {
  Future<void> save(ProductEntity product);
}
