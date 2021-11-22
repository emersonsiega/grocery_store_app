import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import '../components/components.dart';
import '../view.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AppPresenter presenter;
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();

    presenter = GetIt.I.get<AppPresenter>();
    subscription = presenter.stream.listen(_stateListener);

    presenter.loadAppState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  void _stateListener(AppState state) {
    if (!state.isLoading && state.errorMessage == null) {
      Future.delayed(const Duration(seconds: 2), () {
        if (state.currentUser == null) {
          AutoRouter.of(context).replace(const LoginRoute());
        } else {
          AutoRouter.of(context).replace(const AppRoute());
        }
      });
    }

    if (!state.isLoading && state.errorMessage != null) {
      CustomSnackbar.showError(message: state.errorMessage!, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppTitleHeader(),
          const Spacer(),
          const Loading(),
          SizedBox(height: 5.height),
          Text(
            "Carregando...",
            textAlign: TextAlign.center,
            style: context.theme.textTheme.bodyText2?.copyWith(
                color: context.theme.dividerColor,
                fontWeight: FontWeight.normal),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
