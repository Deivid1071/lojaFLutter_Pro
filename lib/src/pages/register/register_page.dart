import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_modular/flutter_modular.dart' hide Consumer;
import 'package:loja_virtual_DMpro/src/models/signed_user.dart';
import 'package:loja_virtual_DMpro/src/pages/login/login_page.dart';
import 'package:loja_virtual_DMpro/src/pages/register/register_viewmodel.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = '/register_page';

  RegisterPage({Key key}) : super(key: key);

  SignedUser user = SignedUser();

  @override
  Widget build(BuildContext context) {
    final RegisterViewModel viewModel = Modular.get<RegisterViewModel>();
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    return ChangeNotifierProvider(
        create: (context) => Modular.get<RegisterViewModel>(),
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            title: const Text('Criar conta'),
            centerTitle: true,
          ),
          body: Center(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formkey,
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Nome completo'),
                      validator: (name) {
                        if (name.isEmpty) {
                          return 'Preencha com seu nome';
                        } else {
                          if (!(name.trim().split(' ').length > 1)) {
                            return 'Preencha seu nome completo';
                          }
                        }
                        user.name = name;
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      enabled: true,
                      //controller: _emailController,
                      validator: (email) {
                        if (!viewModel.verifyEmailValid(email)) {
                          if (email.isEmpty) {
                            return 'Campo obrigatório';
                          } else {
                            return 'E-mail inválido';
                          }
                        } else {
                          user.email = email;
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Senha'),
                      obscureText: true,
                      validator: (pass) {
                        if (!viewModel.verifyPasswordValid(pass)) {
                          return 'Senha deve ter no minimo 6 caracteres';
                        } else {
                          user.password = pass;
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Confirmar senha'),
                      obscureText: true,
                      validator: (confirmPass) {
                        if (user.password != confirmPass) {
                          return 'Os campos de senha precisam ser iguais.';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44,
                      child: Consumer<RegisterViewModel>(
                          builder: (context, vm, child) {
                        return RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          disabledColor:
                              Theme.of(context).primaryColor.withAlpha(100),
                          onPressed: () async {
                            if (formkey.currentState.validate()) {
                              formkey.currentState.save();
                              await vm.register(user);

                              if (vm.errorRegister.isEmpty) {
                                debugPrint("Navegar para home");
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Erro de login'),
                                        content: Text(vm.errorRegister),
                                      );
                                    });
                              }
                            }
                          },
                          child: vm.loadingButton
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ))
                              : const Text(
                                  'Criar conta',
                                  style: TextStyle(fontSize: 18),
                                ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
