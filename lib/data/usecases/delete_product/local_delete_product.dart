import '../../cache/cache.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

class LocalDeleteProduct implements DeleteFromCache {
  final DeleteCacheStorage deleteCacheStorage;
  final FetchCacheStorage fetchCacheStorage;
  final SaveCacheStorage saveCacheStorage;
  LocalDeleteProduct(
      {required this.deleteCacheStorage,
      required this.fetchCacheStorage,
      required this.saveCacheStorage});

  @override
  Future<void> delete(String code) async {
    try {
      final products = await fetchCacheStorage.fetch('products');
      if (products != null) {
        List<String> productsList = products.split(',');
        String res = '';
        for (String product in productsList) {
          if (product != code && product != 'null' && product.isNotEmpty) {
            res = res + ',$product';
          }
        }
        res = res.replaceFirst(',', '');
        res = res.trim();

        if (res.isNotEmpty) {
          await saveCacheStorage.save(key: 'products', value: res);
        }
      }
      await deleteCacheStorage.delete(key: code);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
