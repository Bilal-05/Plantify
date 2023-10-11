import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:plant_app/constant/colors.dart';
import 'package:plant_app/views/main_menu/drawer/drawer-menu/drawer_menu_view.dart';
import 'package:plant_app/views/main_menu/main_menu_view/mainmenu_view.dart';
import 'package:plant_app/widgets/background.dart';

class Zoom extends StatefulWidget {
  final String documentId;
  const Zoom({super.key, required this.documentId});

  @override
  State<Zoom> createState() => _ZoomState();
}

class _ZoomState extends State<Zoom> {
  final drawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: ZoomDrawer(
              style: DrawerStyle.defaultStyle,
              controller: drawerController,
              menuScreen: DrawerMenu(
                zoomDrawerController: drawerController,
                documentId: widget.documentId,
              ),
              mainScreen: MainMenu(
                zoomDrawerController: drawerController,
              ),
              disableDragGesture: false,
              androidCloseOnBackTap: true,
              mainScreenTapClose: true,
              borderRadius: 40.0,
              showShadow: true,
              angle: 0.0,
              shadowLayer1Color: AppColor.pc,
              shadowLayer2Color: Colors.transparent,
              slideWidth: MediaQuery.of(context).size.width * 0.65,
              openCurve: Curves.fastOutSlowIn,
            ),
          ),
        ],
      ),
    );
  }
}
