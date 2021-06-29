import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:loja_virtual_DMpro/repositories/login_repository.dart';
import 'package:loja_virtual_DMpro/shared/models/signed_user.dart';
import 'package:loja_virtual_DMpro/src/login/login_viewmodel.dart';
import 'package:mockito/mockito.dart';

class LoginRePositoryMock extends Mock implements LoginRepository {}

main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final repository = LoginRePositoryMock();
  final viewModel = LoginViewModel(repository);
  SignedUser user = SignedUser();

  setUp(() async {
    await Firebase.initializeApp();
  });
  group('Home Controller Test', () {
    test(
        "Deve retornar um uam String de erro vazia confirmando que a requisição funcionou",
        () async {
      user.email = '';
      user.password = '';
      await viewModel.login(user);

      expect(viewModel.errorLogin, '');
    });
  });
}
