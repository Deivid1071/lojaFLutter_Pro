import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:loja_virtual_DMpro/src/pages/register/register_page.dart';
import 'package:loja_virtual_DMpro/src/pages/register/register_viewmodel.dart';
import 'package:loja_virtual_DMpro/src/repositories/auth_repository.dart';

class RegisterModule extends ChildModule {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
        Bind((i) => RegisterViewModel(i.get())),
        Bind((i) => AuthRepository(i.get())),
        Bind((i) => FirebaseAuth.instance),
      ];

  @override
  // TODO: implement routers
  List<ModularRouter> get routers =>
      [ModularRouter('/', child: (_, args) => RegisterPage())];

  static Inject get to => Inject<RegisterModule>.of();
}
