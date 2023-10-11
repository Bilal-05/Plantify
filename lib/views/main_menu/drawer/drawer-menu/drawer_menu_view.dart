// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:plant_app/constant/colors.dart';
import 'package:plant_app/constant/imagepath.dart';
// import 'package:plant_app/views/startingView/startingview.dart';
import 'package:plant_app/widgets/custom_media_query.dart';
import 'package:plant_app/widgets/custom_button.dart';
import 'package:plant_app/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMenu extends StatelessWidget {
  final ZoomDrawerController zoomDrawerController;
  final String documentId;
  const DrawerMenu(
      {super.key,
      required this.zoomDrawerController,
      required this.documentId});

  @override
  Widget build(BuildContext context) {
    bool loader = true;

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Something went wrong",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColor.tc,
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          Text("Full Name: ${data['full_name']} ${data['last_name']}");

          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              margin: const EdgeInsets.only(top: 100, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FloatingActionButton.small(
                    onPressed: () {
                      zoomDrawerController.toggle!();
                    },
                    backgroundColor: AppColor.pc,
                    child: const Icon(Icons.close),
                  ),
                  Media.space(0.05, context),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: const CircleAvatar(
                          radius: 60,
                        ),
                      ),
                      Media.space(0.015, context),
                      Text(
                        data['full_name'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.tc,
                        ),
                      ),
                      Media.space(0.005, context),
                      Text(
                        data['email'],
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColor.tc,
                        ),
                      )
                    ],
                  ),
                  Media.space(0.05, context),
                  DrawerItem(
                    assetName: ImagePath.home,
                    itemName: 'Home',
                    thickNess: 0.5,
                  ),
                  DrawerItem(
                    assetName: ImagePath.popular,
                    itemName: 'Promotions',
                    thickNess: 0.5,
                  ),
                  DrawerItem(
                    assetName: ImagePath.cart,
                    itemName: 'Cart',
                    thickNess: 0.5,
                  ),
                  DrawerItem(
                    assetName: ImagePath.setting,
                    itemName: 'Setting',
                    thickNess: 0.5,
                  ),
                  DrawerItem(
                    assetName: ImagePath.lock,
                    itemName: 'Privacy',
                    thickNess: 0.5,
                  ),
                  DrawerItem(
                    assetName: ImagePath.invite,
                    itemName: 'Invite',
                    thickNess: 0,
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: CustomButton(
                      buttonText: 'Logout',
                      buttonColor: Colors.transparent,
                      buttonFunction: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.remove('isLogin');
                        await prefs.remove('documentId');
                        await FirebaseAuth.instance.signOut();
                        setState() {
                          loader = false;
                        }

                        Future.delayed(
                          const Duration(milliseconds: 1500),
                        );
                        Navigator.popUntil(
                          context,
                          ModalRoute.withName('/'),
                        );
                      },
                      width: 130,
                      height: 40,
                      isDatahere: loader,
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            color: AppColor.tc,
          ),
        );
      },
    );
  }
}
