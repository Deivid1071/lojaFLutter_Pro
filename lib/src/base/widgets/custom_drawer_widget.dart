import 'package:flutter/material.dart';

import 'drawer_tile_widget.dart';

class CustomDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerTileWidget(
            icon: Icons.home,
            text: 'Início',
            page: 0,
          ),
          const DrawerTileWidget(
            icon: Icons.list,
            text: 'Produtos',
            page: 1,
          ),
          const DrawerTileWidget(
            icon: Icons.playlist_add_check,
            text: 'Meus Pedidos',
            page: 2,
          ),
          const DrawerTileWidget(
            icon: Icons.location_on,
            text: 'Lojas',
            page: 3,
          ),
        ],
      ),
    );
  }
}
