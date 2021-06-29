import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:loja_virtual_DMpro/src/app.module.dart';
import 'package:loja_virtual_DMpro/src/base/base_page.dart';
import 'package:loja_virtual_DMpro/src/pages/login/login_viewmodel.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ModularApp(
    module: AppModule(),
  ));
}

class MyApp extends StatelessWidget {
  final loginViewModel = Modular.get<LoginViewModel>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => loginViewModel,
      child: MaterialApp(
        title: 'Loja do DM',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: const Color(0xFF047D8D),
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: const AppBarTheme(elevation: 0)),
        home: BasePage(),
      ),
    );
  }
}
