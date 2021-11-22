import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';
import 'package:intl/intl.dart';

import '../../domain/domain.dart';
import '../../utils/utils.dart';
import '../../view/view.dart';
import 'order_item_list_tile.dart';

class UserOrdersBottomSheet extends StatefulWidget {
  const UserOrdersBottomSheet({Key? key}) : super(key: key);

  @override
  State<UserOrdersBottomSheet> createState() => _UserOrdersBottomSheetState();
}

class _UserOrdersBottomSheetState extends State<UserOrdersBottomSheet> {
  late AppPresenter appPresenter;
  late UserAccountPresenter presenter;
  late DateFormat dateFormat;

  @override
  void initState() {
    appPresenter = GetIt.I.get();
    presenter = GetIt.I.get();

    if (appPresenter.state.currentUser != null) {
      presenter.loadOrders(appPresenter.state.currentUser!);
    }

    dateFormat = DateFormat("dd/MM/yyyy HH:mm", 'pt_BR');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        color: context.colorScheme.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 24.height,
                left: 24.width,
              ),
              child: Text(
                "Pedidos",
                style: context.textTheme.headline6,
              ),
            ),
            SizedBox(height: 16.height),
            Expanded(
              child: StreamBuilder<UserAccountState>(
                stream: presenter.stream,
                initialData: presenter.state,
                builder: (context, snapshot) {
                  final orders = snapshot.data?.orders ?? [];
                  final loading = !snapshot.hasData || snapshot.data!.isLoading;

                  if (loading) {
                    return const Center(child: Loading());
                  }

                  if (orders.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 20.height,
                          bottom: 40.height,
                        ),
                        child: Text(
                          "Você ainda não fez pedidos...",
                          style: context.textTheme.bodyText2?.copyWith(
                            color: context.theme.dividerColor,
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: orders.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final order = orders[index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 15.height),
                        child: OrderItemListTile(
                          index: index + 1,
                          title: "#${order.id}",
                          subtitle:
                              "${order.items.length} items - ${order.total.currency}\n${dateFormat.format(order.date)}",
                          onPressed: () async => printOrder(order),
                          isThreeLine: true,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> printOrder(OrderEntity order) async {
    await presenter.printOrder(order);
  }
}
