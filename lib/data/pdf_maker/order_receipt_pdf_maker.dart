import '../../domain/domain.dart';

abstract class OrderReceiptPdfMaker {
  Future<String> makePdf(OrderEntity order);

  Future<void> printPdf(String path);
}
