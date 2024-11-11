import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveltoken/constant/app_color.dart';
import 'package:traveltoken/constant/app_image.dart';
import 'package:traveltoken/controllers/group_page_controller.dart';
import 'package:traveltoken/controllers/home_page_controller.dart';
import 'package:traveltoken/controllers/sign_in_controller.dart';
import 'package:traveltoken/model/expense_model.dart';
import 'package:traveltoken/model/group_model.dart';
import 'package:traveltoken/pages/add_expense_page.dart';
import 'package:traveltoken/pages/summary_page.dart';
import 'package:traveltoken/widgets/button_widget.dart';
import 'package:traveltoken/widgets/group_name_widget.dart';

class GroupPage extends StatelessWidget {
  final GroupModel groupModel;
  const GroupPage({
    super.key,
    required this.groupModel,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context
            .read<GroupPageController>()
            .getAllExpenses(groupId: groupModel.id);
      },
    );
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await context
              .read<GroupPageController>()
              .getAllExpenses(groupId: groupModel.id);
        },
        child: Scaffold(
          backgroundColor: AppColor.whiteColor,
          body: Consumer<GroupPageController>(
            builder: (context, value, child) {
              return value.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        child: Column(
                          children: <Widget>[
                            // GroupNameWidget at the top
                            GropNameWidget(
                              groupModel: groupModel,
                            ),

                            const SizedBox(height: 40),

                            // Expanded widget allows the ListView to take up available space in the middle
                            value.expenseModelList.isEmpty
                                ? const Expanded(
                                    child: Center(
                                      child: Text("No Data Found"),
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.separated(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      controller: ScrollController(),
                                      itemCount: value.expenseModelList.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        bool isUser = context
                                                .read<SignInController>()
                                                .getUser()
                                                ?.uid ==
                                            value
                                                .expenseModelList[index].paidBy;
                                        return Align(
                                          alignment: isUser
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: isUser
                                                ? [
                                                    ChatDetailWidget(
                                                      expenseModel: value
                                                              .expenseModelList[
                                                          index],
                                                    ),
                                                    const SizedBox(width: 15),
                                                    const ChatImageWidget(),
                                                    const SizedBox(width: 20),
                                                  ]
                                                : [
                                                    const ChatImageWidget(),
                                                    const SizedBox(width: 15),
                                                    ChatDetailWidget(
                                                      expenseModel: value
                                                              .expenseModelList[
                                                          index],
                                                    ),
                                                    const SizedBox(width: 20),
                                                  ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        height: 40,
                                      ),
                                    ),
                                  ),

                            // ButtonWidget at the bottom
                            Padding(
                              padding:
                                  const EdgeInsets.all(18).copyWith(bottom: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * .7,
                                    child: value.expenseModelList.isEmpty ||
                                            groupModel.createdUserId !=
                                                context
                                                    .read<SignInController>()
                                                    .getUser()
                                                    ?.uid
                                        ? const SizedBox()
                                        : ButtonWidget(
                                            text: "Settle Up",
                                            onTap: () async {
                                              await context
                                                  .read<GroupPageController>()
                                                  .settleGroup(
                                                      groudId: groupModel.id)
                                                  .then(
                                                (value) {
                                                  if (!context.mounted) return;

                                                  context
                                                      .read<
                                                          HomePageController>()
                                                      .getAllGroup();

                                                  ScaffoldMessenger.of(context)
                                                      .clearSnackBars();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  "Done")));
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                    builder: (context) =>
                                                        SummaryPage(
                                                            groupModel:
                                                                groupModel),
                                                  ));
                                                },
                                              );
                                            },
                                          ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => AddExpensePage(
                                          groupModel: groupModel,
                                        ),
                                      ));
                                    },
                                    child: SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: Image.asset(
                                        AppImages.button,
                                        height: 60,
                                        width: 60,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}

class ChatImageWidget extends StatelessWidget {
  const ChatImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 25,
      foregroundImage: AssetImage(AppImages.person),
    );
  }
}

class ChatDetailWidget extends StatelessWidget {
  final ExpenseModel expenseModel;
  const ChatDetailWidget({super.key, required this.expenseModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 17, top: 7),
      width: 150,
      height: 80,
      decoration: BoxDecoration(
        color: AppColor.homePageDateColor,
        borderRadius: BorderRadius.circular(9),
      ),
      child: FutureBuilder(
          future: context
              .read<GroupPageController>()
              .getuserFromId(userId: expenseModel.paidBy),
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  snapshot.data?.name ?? "",
                  style:
                      const TextStyle(color: AppColor.whiteColor, fontSize: 12),
                ),
                Text(
                  expenseModel.description,
                  style:
                      const TextStyle(color: AppColor.whiteColor, fontSize: 9),
                ),
                Text(
                  expenseModel.amount.toString(),
                  style: const TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
