import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../page_manager.dart';

class DrawerTileWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final int page;

  const DrawerTileWidget({Key key, this.icon, this.text, this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int currentPage = context.read<PageManager>().currentPage;
    final primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: () {
        context.read<PageManager>().setPage(page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                icon,
                size: 32.0,
                color: currentPage == page ? primaryColor : Colors.grey[700],
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 16.0,
                color: currentPage == page ? primaryColor : Colors.grey[700],
              ),
            )
          ],
        ),
      ),
    );
  }
}
