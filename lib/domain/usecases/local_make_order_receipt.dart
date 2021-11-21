import '../../data/data.dart';
import '../../infra/infra.dart';
import '../domain.dart';

class LocalMakeOrderReceipt implements MakeOrderReceipt {
  final OrderReceiptPdfMaker pdfMaker;

  LocalMakeOrderReceipt({required this.pdfMaker});

  @override
  Future<String> makeReceipt(OrderEntity order) async {
    try {
      return await pdfMaker.makePdf(order);
    } catch (error, trace) {
      Log.e("Make order receipt error", data: error, trace: trace);
      throw MakeOrderReceiptError();
    }
  }
}
