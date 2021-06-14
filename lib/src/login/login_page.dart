import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:loja_virtual_DMpro/repositories/login_repository.dart';
import 'package:loja_virtual_DMpro/shared/models/signed_user.dart';
import 'package:loja_virtual_DMpro/src/login/login_controller.dart';
import 'package:loja_virtual_DMpro/src/login/login_viewmodel.dart';

class LoginPage extends StatelessWidget {
  final controller = Modular.get<LoginController>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  LoginViewModel model = LoginViewModel();

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
                TextFormField(
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  controller: _emailController,
                  validator: (email) {
                    if (!controller.verifyEmailValid(email)) {
                      return 'E-mail inválido';
                    } else {
                      model.email = email;
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Senha'),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  controller: _passwordController,
                  validator: (pass) {
                    if (!controller.verifyPasswordValid(pass)) {
                      return 'Senha deve ter no minimo 6 caracteres';
                    } else {
                      model.password = pass;
                      return null;
                    }
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
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () async {
                      if (formkey.currentState.validate()) {
                        await controller.login(model);
                      }
                      if (controller.errorLogin.isEmpty) {
                        debugPrint('Navegar para Home');
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Erro de login'),
                                content: Text(controller.errorLogin),
                              );
                            });
                      }
                      debugPrint(SignedUser.token);
                    },
                    child: ValueListenableBuilder<bool>(
                      valueListenable: controller.stateButtonLoginLoading,
                      builder: (context, value, _) {
                        return value
                            ? const Center(
                                child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ))
                            : const Text(
                                'Entrar',
                                style: TextStyle(fontSize: 18),
                              );
                      },
                    ),
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
