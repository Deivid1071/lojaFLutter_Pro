import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_virtual_DMpro/src/base/page_manager.dart';
import 'package:loja_virtual_DMpro/src/base/widgets/custom_drawer_widget.dart';
import 'package:loja_virtual_DMpro/src/pages/login/login_page.dart';

import 'package:provider/provider.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          LoginPage(),
          Scaffold(
            appBar: AppBar(
              title: Text(
                'Home',
                style: GoogleFonts.nunito(),
              ),
            ),
            drawer: CustomDrawerWidget(),
          ),
          Container(
            color: Colors.red[200],
          ),
          Container(
            color: Colors.green[700],
          ),
        ],
      ),
    );
  }
}
