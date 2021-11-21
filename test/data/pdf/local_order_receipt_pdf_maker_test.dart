import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_store_app/data/data.dart';
import 'package:grocery_store_app/domain/domain.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../utils/order_utils.dart';
import '../../utils/utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LocalOrderReceiptPdfMaker sut;
  late OrderEntity order;

  setUp(() {
    PathProviderPlatform.instance = MockPathProviderPlatformSuccess();

    sut = LocalOrderReceiptPdfMaker();
    order = makeOrder();
  });

  test('Should create and save a pdf based on OrderModel', () async {
    final path = await sut.makePdf(order);

    expect(path, '/tmp/order-receipt-${order.id}.pdf');
  });

  test('Should rethrow exceptions', () async {
    PathProviderPlatform.instance = MockPathProviderPlatformError();

    final future = sut.makePdf(order);

    expect(future, throwsA(const TypeMatcher<Exception>()));
  });
}
