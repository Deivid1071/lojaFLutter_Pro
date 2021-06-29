import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:loja_virtual_DMpro/repositories/login_repository.dart';
import 'package:loja_virtual_DMpro/src/login/login_viewmodel.dart';

import '../main.dart';

class AppModule extends MainModule {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
        Bind((i) => LoginViewModel(i.get())),
        Bind((i) => LoginRepository(i.get())),
        Bind((i) => FirebaseAuth.instance),
      ];

  @override
  // TODO: implement bootstrap
  Widget get bootstrap => MyApp();

  @override
  // TODO: implement routers
  List<ModularRouter> get routers => null;
}
