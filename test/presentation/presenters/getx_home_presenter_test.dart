import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class GetxHomePresenter {
  final LoadProducts loadProductsData;
  GetxHomePresenter({required this.loadProductsData});
  Future<void> loadProducts() async {
    await loadProductsData.load();
  }
}

class LoadProductsSpy extends Mock implements LoadProducts {
  List<ProductEntity> _list = [];
  Future<List<ProductEntity>> load() =>
      this.noSuchMethod(Invocation.method(#load, []),
          returnValue: Future.value(_list),
          returnValueForMissingStub: Future.value(_list));
}

void main() {
  test('Should call LoadProducts on loadProducts', () async {
    final loadProducts = LoadProductsSpy();
    final sut = GetxHomePresenter(loadProductsData: loadProducts);
    await sut.loadProducts();
    verify(loadProducts.load()).called(1);
  });
}
