import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveltoken/constant/app_fonts.dart';
import 'package:traveltoken/constant/app_size.dart';
import 'package:traveltoken/constant/app_string.dart';
import 'package:traveltoken/controllers/sign_in_controller.dart';
import 'package:traveltoken/controllers/summary_list_page_controller.dart';
import 'package:traveltoken/widgets/expense_list_widget.dart';

class SummaryListPage extends StatelessWidget {
  const SummaryListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<SummaryListPageController>().getAllGroup();
      },
    );
    final userName = context.read<SignInController>().getUser();
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<SummaryListPageController>().getAllGroup();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Consumer<SummaryListPageController>(
            builder: (context, homePageController, child) {
              return homePageController.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(AppPadding.padding10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name
                          Text(
                            "${AppString.hi}${userName?.displayName ?? ""}",
                            style: const TextStyle(
                              fontFamily: AppFonts.montserratFont,
                              fontSize: AppFontSize.font32,
                            ),
                          ),
                          const SizedBox(height: AppSize.appSize16),
                          // Summary
                          const Text(
                            AppString.summary,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: AppFonts.montserratFont,
                                fontSize: AppFontSize.font18,
                                fontWeight: FontWeight.w600),
                          ),
                          // List view builder
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
                                          fromHome: false,
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
