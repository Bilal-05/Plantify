import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app/constant/colors.dart';
import 'package:plant_app/widgets/custom_media_query.dart';

class DrawerItem extends StatelessWidget {
  final String assetName;
  final String itemName;
  final double thickNess;
  const DrawerItem(
      {super.key,
      required this.assetName,
      required this.itemName,
      required this.thickNess});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 30,
                width: 30,
                child: SvgPicture.asset(assetName),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                itemName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColor.tc,
                ),
              )
            ],
          ),
          Media.space(0.01, context),
          thickNess > 0.0
              ? Divider(
                  thickness: thickNess,
                  indent: 50,
                  endIndent: 10,
                  color: AppColor.tc,
                )
              : Container(),
        ],
      ),
    );
  }
}
