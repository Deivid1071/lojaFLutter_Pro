import 'package:flutter_modular/flutter_modular.dart';
import 'package:loja_virtual_DMpro/src/pages/login/login_page.dart';
import 'package:loja_virtual_DMpro/src/pages/login/login_viewmodel.dart';
import 'package:loja_virtual_DMpro/src/repositories/auth_repository.dart';

class LoginModule extends ChildModule {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
        Bind((i) => LoginViewModel(i.get())),
        Bind((i) => AuthRepository(i.get())),
      ];

  @override
  // TODO: implement routers
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, __) => LoginPage()),
      ];

  static Inject get to => Inject<LoginModule>.of();
}
