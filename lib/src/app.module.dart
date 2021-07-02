import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:loja_virtual_DMpro/src/modules/login_module.dart';
import 'package:loja_virtual_DMpro/src/modules/register_module.dart';
import 'package:loja_virtual_DMpro/src/pages/login/login_page.dart';
import 'package:loja_virtual_DMpro/src/pages/login/login_viewmodel.dart';
import 'package:loja_virtual_DMpro/src/pages/register/register_page.dart';
import 'package:loja_virtual_DMpro/src/repositories/auth_repository.dart';

import '../main.dart';

class AppModule extends MainModule {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
        Bind((i) => LoginViewModel(i.get())),
        Bind((i) => AuthRepository(i.get())),
        Bind((i) => FirebaseAuth.instance),
      ];

  @override
  // TODO: implement bootstrap
  Widget get bootstrap => MyApp();

  @override
  // TODO: implement routers
  List<ModularRouter> get routers => [
        ModularRouter(LoginPage.routeName, module: LoginModule()),
        ModularRouter(RegisterPage.routeName, module: RegisterModule())
      ];
}
