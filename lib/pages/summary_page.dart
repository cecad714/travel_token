import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveltoken/constant/app_color.dart';
import 'package:traveltoken/constant/app_image.dart';
import 'package:traveltoken/controllers/summary_controller.dart';
import 'package:traveltoken/model/group_model.dart';
import 'package:traveltoken/widgets/group_name_widget.dart';

class SummaryPage extends StatelessWidget {
  final GroupModel groupModel;
  const SummaryPage({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: <Widget>[
              GropNameWidget(
                groupModel: groupModel,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: FutureBuilder(
                    future: context
                        .read<SummaryController>()
                        .generateSummary(groupModel.id),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        controller: ScrollController(),
                        itemCount: snapshot.data?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 18, right: 18, bottom: 15),
                            child: ListTile(
                              minTileHeight: 61,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              leading: const CircleAvatar(
                                foregroundImage: AssetImage(AppImages.artist),
                              ),
                              title: Text(snapshot.data?[index] ?? ""),
                              tileColor: AppColor.tileBackgroundColor,
                            ),
                          );
                        },
                      );
                    }),
              ),
              SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: const BoxDecoration(color: AppColor.whiteColor),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: FutureBuilder(
                        future: context
                            .read<SummaryController>()
                            .calculateTotalExpense(groupId: groupModel.id),
                        builder: (context, snapshot) {
                          return Text(
                            "Total Expenses : ₹ ${snapshot.data}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
