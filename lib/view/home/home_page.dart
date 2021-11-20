import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import '../app/app_presenter.dart';
import '../app/app_state.dart';
import '../view.dart';
import 'product_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppPresenter appPresenter;
  late HomePresenter homePresenter;
  String? query;

  @override
  void initState() {
    super.initState();
    appPresenter = GetIt.I.get();
    homePresenter = GetIt.I.get();

    homePresenter.stream.listen(_homeStateListener);
  }

  void _homeStateListener(HomeState state) {
    if (state.errorMessage != null) {
      CustomSnackbar.showError(
        message: state.errorMessage,
        context: context,
      );
    }

    if (state.successMessage != null) {
      CustomSnackbar.showInfo(
        message: state.successMessage,
        context: context,
      );
    }
  }

  void filterProducts(String? query) {
    setState(() {
      this.query = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<AppState>(
        stream: appPresenter.stream,
        initialData: const AppState(),
        builder: (context, snapshot) {
          final state = snapshot.data!;

          final products = query == null
              ? state.products
              : state.products
                  ?.where((item) =>
                      item.name.toLowerCase().startsWith(query!.toLowerCase()))
                  .toList();

          return CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverAppBar(
                toolbarHeight: 40.height,
                collapsedHeight: 40.height,
                expandedHeight: 140.height,
                backgroundColor: context.colorScheme.background,
                floating: true,
                pinned: true,
                snap: true,
                elevation: 0,
                centerTitle: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.width,
                      vertical: 8.height,
                    ),
                    child: ProductFilter(
                      onFilter: filterProducts,
                      text: query,
                    ),
                  ),
                  centerTitle: false,
                  // collapseMode: CollapseMode.none,
                  title: Padding(
                    padding: EdgeInsets.only(bottom: 8.height),
                    child: Text(
                      "Produtos",
                      style: context.textTheme.headline6,
                    ),
                  ),
                  titlePadding: EdgeInsetsDirectional.only(
                    start: 10.width,
                    end: 20,
                  ),
                ),
              ),
              if (products == null || products.isEmpty)
                const SliverToBoxAdapter(
                  child: EmptyText(),
                ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 5,
                ),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.width,
                    mainAxisSpacing: 15.height,
                    childAspectRatio: 17 / 19,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = products![index];

                      return ProductListTile(
                        key: ValueKey(product),
                        product: product,
                        canAdd: state.cart == null ||
                            !state.cart!.containsProduct(product),
                      );
                    },
                    childCount: products?.length ?? 0,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class EmptyText extends StatelessWidget {
  const EmptyText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Center(
        child: Text(
          "Nenhum produto encontrado...",
          style: context.textTheme.bodyText1?.copyWith(
            color: context.theme.dividerColor,
          ),
        ),
      ),
    );
  }
}

class ProductFilter extends StatefulWidget {
  final ValueChanged<String?> onFilter;
  final String? text;
  const ProductFilter({
    Key? key,
    required this.onFilter,
    this.text,
  }) : super(key: key);

  @override
  State<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends State<ProductFilter> {
  late TextEditingController controller;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.text);
  }

  void onSearch(String? text) {
    if (timer?.isActive ?? false) {
      timer!.cancel();
    }

    timer = Timer(const Duration(milliseconds: 500), () {
      widget.onFilter(text);
    });
  }

  void _resetFilter() {
    timer?.cancel();
    controller.clear();
    widget.onFilter('');
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onSearch,
      decoration: InputDecoration(
        hintText: "Pesquisar",
        prefixIcon: Icon(
          Icons.search,
          color: context.theme.dividerColor,
        ),
        suffixIcon: timer?.isActive == false && controller.text.isNotEmpty
            ? GestureDetector(
                onTap: _resetFilter,
                key: const Key('clearFilter'),
                child: Icon(
                  Icons.close,
                  size: 20.fontSize,
                  color: context.colorScheme.onBackground,
                ),
              )
            : null,
      ),
    );
  }
}
