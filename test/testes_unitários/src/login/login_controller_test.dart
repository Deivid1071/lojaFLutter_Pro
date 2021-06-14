import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:loja_virtual_DMpro/repositories/login_repository.dart';
import 'package:loja_virtual_DMpro/src/login/login_controller.dart';
import 'package:loja_virtual_DMpro/src/login/login_viewmodel.dart';
import 'package:mockito/mockito.dart';

class LoginRePositoryMock extends Mock implements LoginRepository {}

main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final repository = LoginRePositoryMock();
  final controller = LoginController(repository);
  LoginViewModel model = LoginViewModel();

  setUp(() async {
    await Firebase.initializeApp();
  });
  group('Home Controller Test', () {
    test(
        "Deve retornar um uam String de erro vazia confirmando que a requisição funcionou",
        () async {
      model.email = '';
      model.password = '';
      await controller.login(model);

      expect(controller.errorLogin, '');
    });
  });
}
