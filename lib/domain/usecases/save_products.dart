import '../entities/entities.dart';

abstract class SaveProducts {
  Future<void> save(List<ProductEntity> product);
}
