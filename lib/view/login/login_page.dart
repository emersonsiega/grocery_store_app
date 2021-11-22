import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_ui_layout/responsive_ui_layout.dart';

import '../components/components.dart';
import '../view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginPresenter presenter;
  final formKey = GlobalKey<FormState>();
  String? user;
  String? password;
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();

    presenter = GetIt.I.get<LoginPresenter>();
    subscription = presenter.stream.listen(_stateListener);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void _stateListener(LoginState state) {
    CustomSnackbar.showError(
      message: state.errorMessage,
      context: context,
    );

    if (state.completed) {
      AutoRouter.of(context).replace(const AppRoute());
    }
  }

  void _onChangeUser(String? value) {
    setState(() {
      user = value;
    });
  }

  void _onChangePassword(String? value) {
    setState(() {
      password = value;
    });
  }

  Future<void> _onSubmit() async {
    if (formKey.currentState!.validate()) {
      await presenter.authenticate(user: user!, password: password!);
    }
  }

  void _createAccount() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const AppTitleHeader(),
          StreamBuilder<LoginState>(
            stream: presenter.stream,
            initialData: const LoginState(),
            builder: (context, snapshot) {
              final state = snapshot.data;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.width),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 60.height),
                      TextFormField(
                        key: const Key('username'),
                        onChanged: _onChangeUser,
                        validator: emptyStringValidation,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: "Usuário",
                          helperText: "",
                        ),
                      ),
                      SizedBox(height: 20.height),
                      TextFormField(
                        key: const Key('password'),
                        onChanged: _onChangePassword,
                        validator: emptyStringValidation,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Senha",
                          helperText: "",
                        ),
                      ),
                      SizedBox(height: 50.height),
                      LoadingElevatedButton(
                        onPressed: _onSubmit,
                        isLoading: state!.isLoading,
                        text: "ENTRAR",
                      ),
                      SizedBox(height: 40.height),
                      Text(
                        "Não possui conta?",
                        style: context.textTheme.bodyText1,
                      ),
                      TextButton(
                        onPressed: _createAccount,
                        child: Text(
                          "Criar conta",
                          style: context.textTheme.button?.copyWith(
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
