import '../entities/entities.dart';

abstract class SaveProduct {
  Future<void> edit(ProductEntity product);
}
