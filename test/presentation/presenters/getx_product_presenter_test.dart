import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:desafio_nextar/domain/helpers/helpers.dart';
import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';

import 'package:desafio_nextar/presentation/presenters/presenters.dart';
import 'package:desafio_nextar/presentation/protocols/protocols.dart';

import 'package:desafio_nextar/ui/helpers/helpers.dart';

class ValidationSpy extends Mock implements Validation {
  @override
  ValidationError validate({required String? field, required String? value}) =>
      this.noSuchMethod(Invocation.method(#validate, [field, value]),
          returnValue: ValidationError.none,
          returnValueForMissingStub: ValidationError.none);
}

class DeleteFromCacheSpy extends Mock implements DeleteFromCache {
  @override
  Future<void> delete(String code) =>
      this.noSuchMethod(Invocation.method(#delete, [code]),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());
}

class SaveProductSpy extends Mock implements SaveProduct {
  @override
  Future<void> save(ProductEntity product) =>
      this.noSuchMethod(Invocation.method(#save, [product]),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());
}

void main() {
  late GetxProductPresenter sut;
  late ValidationSpy validation;
  late DeleteFromCacheSpy deleteFromCache;
  late SaveProductSpy saveProduct;
  late String value;
  late String price;
  late String stock;
  late ProductEntity product;

  void mockValidation({
    required String value,
    required String field,
    required error,
  }) {
    when(validation.validate(field: field, value: value)).thenReturn(error);
  }

  PostExpectation submitCall() => when(saveProduct.save(product));

  void mockSubmitError({required DomainError error}) {
    submitCall().thenThrow(error);
  }

  setUp(() {
    validation = ValidationSpy();
    deleteFromCache = DeleteFromCacheSpy();
    saveProduct = SaveProductSpy();
    sut = GetxProductPresenter(
        validation: validation,
        deleteFromCache: deleteFromCache,
        saveProduct: saveProduct);
    value = 'any_value';
    price = '10';
    stock = '20';
    CustomizableDateTime.customTime = DateTime.parse("1969-07-20 20:18:04");
    product = ProductEntity(
        name: value,
        code: value,
        creationDate: CustomizableDateTime.current,
        price: price.isEmpty ? null : num.parse(price),
        stock: stock.isEmpty ? null : num.parse(stock));
    sut.price = price;
    sut.stock = stock;
  });
  test('Should call Validation with correct value value', () {
    sut.validateName(value);
    verify(validation.validate(field: 'name', value: value)).called(1);
  });

  test(
      'Should emit name error if validation returns ValidationError.invalidField',
      () {
    mockValidation(
        field: 'name', value: value, error: ValidationError.invalidField);

    sut.nameErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(value);
    sut.validateName(value);
  });

  test(
      'Should emit name error if validation return ValidationError.requiredField',
      () {
    mockValidation(
        field: 'name', value: value, error: ValidationError.requiredField);

    sut.nameErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(value);
    sut.validateName(value);
  });

  test('Should emit empty if validation succeeds', () {
    sut.nameErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.none)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(value);
    sut.validateName(value);
  });

  test('Should call Validation with correct password', () {
    sut.validateCode(value);

    verify(validation.validate(field: 'code', value: value)).called(1);
  });

  test(
      'Should emit code error if validation returns ValidationError.invalidField',
      () {
    mockValidation(
        field: 'code', value: value, error: ValidationError.invalidField);

    sut.codeErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateCode(value);
    sut.validateCode(value);
  });

  test(
      'Should emit code error if validation return ValidationError.requiredField',
      () {
    mockValidation(
        field: 'code', value: value, error: ValidationError.requiredField);

    sut.codeErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateCode(value);
    sut.validateCode(value);
  });

  test('Should emit empty if validation succeeds', () {
    sut.codeErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.none)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateCode(value);
    sut.validateCode(value);
  });

  test('Should emit isFormValid true if validations succeeds', () async {
    sut.nameErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.none)));
    sut.codeErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.none)));

    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateName(value);
    await Future.delayed(Duration.zero);
    sut.validateCode(value);
  });

  test('Should call Submit with correct values on Editing', () async {
    sut.validateName(value);
    sut.validateCode(value);
    sut.isEditing = true;
    await sut.submit();

    verify(deleteFromCache.delete(value)).called(1);
    verify(saveProduct.save(product)).called(1);
  });

  test('Should call Submit with correct values on Saving', () async {
    sut.validateName(value);
    sut.validateCode(value);
    sut.isEditing = false;
    await sut.submit();

    verifyNever(deleteFromCache.delete(value));
    verify(saveProduct.save(product)).called(1);
  });

  test('Should emit correct events on Submit success', () async {
    sut.validateName(value);
    sut.validateCode(value);

    expectLater(sut.isLoadingStream, emits(true));

    await sut.submit();
  });

  test('Should emit correct events on UnexpectedError', () async {
    mockSubmitError(error: DomainError.unexpected);

    sut.validateName(value);
    sut.validateCode(value);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(
        sut.mainErrorStream, emitsInOrder([UIError.none, UIError.unexpected]));

    await sut.submit();
  });

  test('Should change page on success success', () async {
    sut.validateName(value);
    sut.validateCode(value);

    sut.navigateToStream!.listen(expectAsync1((page) => expect(page, '/home')));

    await sut.submit();
  });
}
