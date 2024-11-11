import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveltoken/constant/app_color.dart';
import 'package:traveltoken/constant/app_fonts.dart';
import 'package:traveltoken/constant/app_size.dart';
import 'package:traveltoken/controllers/home_page_controller.dart';
import 'package:traveltoken/controllers/summary_controller.dart';
import 'package:traveltoken/controllers/summary_list_page_controller.dart';
import 'package:traveltoken/controllers/utils.dart';
import 'package:traveltoken/model/group_model.dart';
import 'package:traveltoken/pages/group_page.dart';
import 'package:traveltoken/pages/summary_page.dart';

class HomeCardWidget extends StatelessWidget {
  final bool fromHome;
  final GroupModel groupModel;
  const HomeCardWidget({
    super.key,
    required this.fromHome,
    required this.groupModel,
  });

  @override
  Widget build(BuildContext context) {
    final String dateData = Apputils.formatDateString(groupModel.date);
    return GestureDetector(
      onLongPress: () {
        showDeleteDialog(
          context,
          () {
            context
                .read<HomePageController>()
                .deleteGroup(groupId: groupModel.id);
            context.read<HomePageController>().getAllGroup();
            context.read<SummaryListPageController>().getAllGroup();
          },
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorderRadius.radius15)),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.padding8),
          child: Stack(
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppBorderRadius.radius6),
                  child: Image.asset(
                    "assets/Rectangle.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 150,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppBorderRadius.radius6),
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.58),
                          Color.fromRGBO(0, 0, 0, 1),
                        ],
                        stops: [
                          0.0,
                          1.0
                        ])),
              ),
              Padding(
                padding: const EdgeInsets.all(19.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupModel.name,
                      style: const TextStyle(
                          fontFamily: AppFonts.rubikFont,
                          fontSize: AppFontSize.font24,
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      dateData,
                      style: const TextStyle(
                        fontFamily: AppFonts.inter,
                        fontSize: AppFontSize.font10,
                        color: AppColor.dateColor,
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.appSize21,
                    ),
                    FutureBuilder(
                        future: context
                            .read<HomePageController>()
                            .calculateTotalExpense(groupId: groupModel.id),
                        builder: (context, snapshot) {
                          return Text(
                            "₹ ${snapshot.data.toString()}",
                            style: const TextStyle(
                                fontFamily: AppFonts.inter,
                                fontSize: AppFontSize.font20,
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.w600),
                          );
                        }),
                  ],
                ),
              ),
              Positioned(
                bottom: 15,
                right: 18,
                child: GestureDetector(
                  onTap: () {
                    if (fromHome) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GroupPage(
                          groupModel: groupModel,
                        ),
                      ));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SummaryPage(
                          groupModel: groupModel,
                        ),
                      ));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius:
                            BorderRadius.circular(AppBorderRadius.radius24)),
                    padding: const EdgeInsets.all(AppPadding.padding3),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: AppColor.homePageDateColor,
                          borderRadius:
                              BorderRadius.circular(AppBorderRadius.radius24)),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.padding28,
                          vertical: AppPadding.padding6,
                        ),
                        child: Text(
                          "View",
                          style: TextStyle(
                            color: AppColor.whiteColor,
                            fontFamily: AppFonts.montserratFont,
                            fontSize: AppFontSize.font10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showDeleteDialog(
      BuildContext context, VoidCallback onConfirm) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Group'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to delete this group?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onConfirm(); // Call the confirm callback
              },
            ),
          ],
        );
      },
    );
  }
}
