import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_store_app/data/data.dart';
import 'package:grocery_store_app/domain/domain.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../utils/order_utils.dart';
import 'local_make_order_receipt_test.mocks.dart';

@GenerateMocks([OrderReceiptPdfMaker])
void main() {
  late LocalMakeOrderReceipt sut;
  late MockOrderReceiptPdfMaker pdfMakerSpy;
  late OrderEntity order;
  late String resultPath;

  PostExpectation mockPdfMakerCall() => when(pdfMakerSpy.makePdf(any));

  void mockPdfMakerSuccess(String data) {
    mockPdfMakerCall().thenAnswer((_) async => data);
  }

  void mockPdfMakerError() {
    mockPdfMakerCall().thenThrow(Exception());
  }

  setUp(() {
    pdfMakerSpy = MockOrderReceiptPdfMaker();
    sut = LocalMakeOrderReceipt(pdfMaker: pdfMakerSpy);
    order = makeOrder();

    resultPath = faker.internet.httpUrl();
    mockPdfMakerSuccess(resultPath);
  });

  test('Should call to OrderReceiptPdfMaker with correct data', () async {
    final response = await sut.makeReceipt(order);

    verify(pdfMakerSpy.makePdf(order)).called(1);
    expect(response, resultPath);
  });

  test('Should throw a MakeOrderReceiptError if pdf maker fails ', () async {
    mockPdfMakerError();
    final future = sut.makeReceipt(order);

    expect(future, throwsA(const TypeMatcher<MakeOrderReceiptError>()));
  });
}
