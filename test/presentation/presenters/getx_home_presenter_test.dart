import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:desafio_nextar/domain/helpers/helpers.dart';
import 'package:desafio_nextar/presentation/presenters/presenters.dart';
import 'package:desafio_nextar/ui/helpers/helpers.dart';
import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';
import 'package:desafio_nextar/ui/pages/pages.dart';

class LoadProductsSpy extends Mock implements LoadProducts {
  List<ProductEntity> _list = [];
  Future<List<ProductEntity>> load() =>
      this.noSuchMethod(Invocation.method(#load, []),
          returnValue: Future.value(_list),
          returnValueForMissingStub: Future.value(_list));
}

class DeleteProductSpy extends Mock implements DeleteFromCache {
  Future<void> delete(String code) =>
      this.noSuchMethod(Invocation.method(#delete, []),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());
}

class LogoffSpy extends Mock implements DeleteFromCache {
  Future<void> delete(String key) =>
      this.noSuchMethod(Invocation.method(#delete, []),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());
}

void main() {
  late LoadProductsSpy loadProducts;
  late DeleteProductSpy deleteProducts;
  late LogoffSpy logoff;
  late GetxHomePresenter sut;
  late List<ProductEntity> productList;
  late String code;

  List<ProductEntity> mockValidProducts() => [
        ProductEntity(
            name: 'Product 1',
            code: 'any_code',
            creationDate: DateTime(2021, 4, 21)),
        ProductEntity(
            name: 'Product 2',
            code: 'any_code2',
            creationDate: DateTime(2021, 4, 20))
      ];

  PostExpectation mockLoadProductsCall() => when(loadProducts.load());

  PostExpectation mockDeleteProductCall() => when(deleteProducts.delete(code));

  PostExpectation mockLogoffCall() => when(logoff.delete('token'));

  void mockLoadProducts() {
    productList = mockValidProducts();
    mockLoadProductsCall().thenAnswer((_) async => productList);
  }

  void mockLoadProductsError() =>
      mockLoadProductsCall().thenThrow(DomainError.unexpected);

  void mockDeleteProductError() =>
      mockDeleteProductCall().thenThrow(DomainError.unexpected);

  void mockLogoffError() => mockLogoffCall().thenThrow(DomainError.unexpected);

  setUp(() {
    loadProducts = LoadProductsSpy();
    deleteProducts = DeleteProductSpy();
    logoff = LogoffSpy();
    code = 'any_code';
    sut = GetxHomePresenter(
        loadProductsData: loadProducts,
        deleteProductByCode: deleteProducts,
        logoffSession: logoff);
    mockLoadProducts();
  });

  test('Should call LoadProducts on loadProducts', () async {
    await sut.loadProducts();
    verify(loadProducts.load()).called(1);
  });

  test('Should emit correct events on success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.productsStream!.listen(expectAsync1((product) => expect(product, [
          ProductViewModel(
              name: productList[0].name,
              price: productList[0].price,
              stock: productList[0].stock,
              code: productList[0].code,
              imagePath: productList[0].imagePath == null
                  ? ''
                  : productList[0].imagePath,
              creationDate: '21-04-2021'),
          ProductViewModel(
              name: productList[1].name,
              price: productList[1].price,
              imagePath: productList[1].imagePath == null
                  ? ''
                  : productList[0].imagePath,
              stock: productList[1].stock,
              code: productList[1].code,
              creationDate: '20-04-2021')
        ])));

    await sut.loadProducts();
  });

  test('Should emit correct events on failure', () async {
    mockLoadProductsError();
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(sut.mainErrorStream, emits(UIError.unexpected));

    await sut.loadProducts();
  });

  test('Should call DeleteProduct on deleteProduct with correct values',
      () async {
    await sut.deleteProduct(code);
    verify(deleteProducts.delete(code));
  });

  test('Should emit correct events on deleteProduct success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(sut.mainErrorStream, emits(UIError.none));

    await sut.deleteProduct(code);
  });

  test('Should emit correct events on deleteProduct fails', () async {
    mockDeleteProductError();
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(
        sut.mainErrorStream, emitsInOrder([UIError.none, UIError.unexpected]));

    await sut.deleteProduct(code);
  });

  test('Should call Logoff with correct values', () async {
    await sut.logoff();
    verify(logoff.delete('token')).called(1);
  });

  test('Should emit correct events on logoff success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    sut.navigateToStream!
        .listen(expectAsync1((page) => expect(page, '/login')));

    await sut.logoff();
  });

  test('Should emit correct events on logoff success', () async {
    mockLogoffError();

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(
        sut.mainErrorStream, emitsInOrder([UIError.none, UIError.unexpected]));

    await sut.logoff();
  });

  test('Should go to ProductPage on product click', () async {
    sut.navigateToStream!
        .listen((page) => expect(page, '/product/any_code/edit'));
    sut.goToEditProduct('any_code');
  });

  test('Should go to ProductPage on new product click', () async {
    sut.navigateToStream!.listen((page) => expect(page, '/product/new'));
    sut.goToNewProduct();
  });
}
