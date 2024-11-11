import 'package:flutter/material.dart';
import 'package:traveltoken/constant/app_color.dart';
import 'package:traveltoken/constant/app_fonts.dart';
import 'package:traveltoken/constant/app_image.dart';
import 'package:traveltoken/controllers/utils.dart';
import 'package:traveltoken/model/group_model.dart';

class GropNameWidget extends StatelessWidget {
  final GroupModel groupModel;
  const GropNameWidget({
    super.key,
    required this.groupModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 10, horizontal: 16), // Padding for the container
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          // Circle Avatar for the image
          const CircleAvatar(
            foregroundImage: AssetImage(AppImages.artist),
            radius: 30, // Adjust radius for size
          ),
          const SizedBox(width: 16), // Space between avatar and text

          // Column for title and subtitle
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Text
              Text(
                groupModel.name,
                style: const TextStyle(
                  fontFamily: AppFonts.raleWay,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4), // Space between title and subtitle

              // Subtitle Text
              Text(
                Apputils.formatDateString(groupModel.date),
                style: const TextStyle(
                  fontFamily: AppFonts.inter,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
