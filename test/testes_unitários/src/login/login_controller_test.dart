import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:loja_virtual_DMpro/src/models/signed_user.dart';
import 'package:loja_virtual_DMpro/src/pages/login/login_viewmodel.dart';
import 'package:loja_virtual_DMpro/src/repositories/auth_repository.dart';

import 'package:mockito/mockito.dart';

class LoginRePositoryMock extends Mock implements AuthRepository {}

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final auth = FirebaseAuthMock();
  final repository = AuthRepository(auth);
  final viewModel = LoginViewModel(repository);
  SignedUser user = SignedUser();

  setUp(() async {
    await Firebase.initializeApp();
  });
  group('Home Controller Test', () {
    test(
        "Deve retornar um uam String de erro vazia confirmando que a requisição funcionou",
        () async {
      user.email = 'deivid@user.com';
      user.password = '123456';
      await viewModel.login(user);
      print(viewModel.errorLogin);
      expect(viewModel.errorLogin, '');
    });
  });
}
