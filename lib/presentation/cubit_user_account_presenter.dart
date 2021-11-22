import 'package:bloc/bloc.dart';

import '../data/data.dart';
import '../domain/domain.dart';
import '../view/view.dart';

class CubitUserAccountPresenter extends Cubit<UserAccountState>
    implements UserAccountPresenter {
  final LoadUserOrders loadUserOrders;
  final OrderReceiptPdfMaker pdfMaker;

  CubitUserAccountPresenter({
    required this.loadUserOrders,
    required this.pdfMaker,
  }) : super(const UserAccountState());

  @override
  Future<void> loadOrders(UserEntity user) async {
    try {
      emit(const UserAccountState(isLoading: true));
      final orders = await loadUserOrders.load(user);

      emit(
        UserAccountState(isLoading: false, orders: orders),
      );
    } catch (_) {
      emit(
        const UserAccountState(
          errorMessage: "Não foi possível carregar pedidos",
        ),
      );
    }
  }

  @override
  Future<void> printOrder(OrderEntity order) async {
    final pdf = await pdfMaker.makePdf(order);

    await pdfMaker.printPdf(pdf);
  }
}
