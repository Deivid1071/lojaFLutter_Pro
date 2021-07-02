import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart' hide Consumer;
import 'package:loja_virtual_DMpro/src/models/signed_user.dart';
import 'package:loja_virtual_DMpro/src/pages/register/register_page.dart';
import 'package:provider/provider.dart';

import 'login_viewmodel.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login_page';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  LoginViewModel viewModel = Modular.get<LoginViewModel>();
  SignedUser user = SignedUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formkey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                Consumer<LoginViewModel>(builder: (context, vm, child) {
                  return TextFormField(
                    decoration: const InputDecoration(hintText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    enabled: !vm.loadingButton,
                    controller: _emailController,
                    validator: (email) {
                      if (!viewModel.verifyEmailValid(email)) {
                        return 'E-mail inválido';
                      } else {
                        user.email = email;
                        return null;
                      }
                    },
                  );
                }),
                const SizedBox(
                  height: 16,
                ),
                Consumer<LoginViewModel>(
                  builder: (context, vm, child) {
                    return TextFormField(
                      decoration: const InputDecoration(hintText: 'Senha'),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      enabled: !vm.loadingButton,
                      controller: _passwordController,
                      obscureText: true,
                      validator: (pass) {
                        if (!viewModel.verifyPasswordValid(pass)) {
                          return 'Senha deve ter no minimo 6 caracteres';
                        } else {
                          user.password = pass;
                          return null;
                        }
                      },
                    );
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: const Text('Esqueci minha senha'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: Consumer<LoginViewModel>(
                    builder: (context, vm, child) {
                      return RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(100),
                        onPressed: vm.loadingButton
                            ? null
                            : () async {
                                if (formkey.currentState.validate()) {
                                  await viewModel.login(user);

                                  if (viewModel.errorLogin.isEmpty) {
                                    debugPrint('Navegar para Home');
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Erro de login'),
                                            content: Text(viewModel.errorLogin),
                                          );
                                        });
                                  }
                                  debugPrint(SignedUser.token);
                                }
                              },
                        child: vm.loadingButton
                            ? const Center(
                                child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ))
                            : const Text(
                                'Entrar',
                                style: TextStyle(fontSize: 18),
                              ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterPage.routeName);
                  },
                  child: Text(
                    'CRIAR CONTA',
                    style: TextStyle(
                        fontSize: 14, color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
