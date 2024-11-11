import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveltoken/constant/app_fonts.dart';
import 'package:traveltoken/constant/app_size.dart';
import 'package:traveltoken/constant/app_string.dart';
import 'package:traveltoken/controllers/home_page_controller.dart';
import 'package:traveltoken/controllers/sign_in_controller.dart';
import 'package:traveltoken/widgets/expense_list_widget.dart';

class ExpenseListWidget extends StatelessWidget {
  const ExpenseListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<HomePageController>().getAllGroup();
      },
    );
    final userName = context.read<SignInController>().getUser();
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<HomePageController>().getAllGroup();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Consumer<HomePageController>(
            builder: (context, homePageController, child) {
              return homePageController.isLoadingHome
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(AppPadding.padding10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //name
                          Text(
                            "${AppString.hi}${userName?.displayName ?? ""}",
                            style: const TextStyle(
                              fontFamily: AppFonts.montserratFont,
                              fontSize: AppFontSize.font32,
                            ),
                          ),
                          const SizedBox(height: AppSize.appSize16),
                          //expense
                          const Text(
                            AppString.groups,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: AppFonts.montserratFont,
                                fontSize: AppFontSize.font18,
                                fontWeight: FontWeight.w600),
                          ),
                          //listview builder
                          Expanded(
                              child: homePageController.groupModelList.isEmpty
                                  ? const Center(
                                      child: Text("No Data Found"),
                                    )
                                  : ListView.builder(
                                      itemCount: homePageController
                                          .groupModelList.length,
                                      itemBuilder: (context, index) {
                                        return HomeCardWidget(
                                          fromHome: true,
                                          groupModel: homePageController
                                              .groupModelList[index],
                                        );
                                      },
                                    )),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
