import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MainMenu extends StatelessWidget {
  final ZoomDrawerController zoomDrawerController;
  const MainMenu({super.key, required this.zoomDrawerController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, top: 30),
          child: Column(
            children: [
              InkWell(
                onTap: () => zoomDrawerController.toggle!(),
                child: const Icon(
                  Icons.menu_rounded,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
