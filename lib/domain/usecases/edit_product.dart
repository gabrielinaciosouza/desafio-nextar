import '../entities/entities.dart';

abstract class EditProduct {
  Future<void> edit(ProductEntity product);
}
