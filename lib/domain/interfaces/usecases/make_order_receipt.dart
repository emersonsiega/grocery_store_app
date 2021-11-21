import '../../domain.dart';

abstract class MakeOrderReceipt {
  Future<String> makeReceipt(OrderEntity order);
}
