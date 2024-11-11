import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveltoken/constant/app_fonts.dart';
import 'package:traveltoken/constant/app_size.dart';
import 'package:traveltoken/constant/app_string.dart';
import 'package:traveltoken/controllers/create_group_controller.dart';
import 'package:traveltoken/controllers/home_page_controller.dart';
import 'package:traveltoken/widgets/button_widget.dart';
import 'package:traveltoken/widgets/text_field_name_widget.dart';
import 'package:traveltoken/widgets/text_field_widget.dart';
import 'package:traveltoken/widgets/user_list_widget.dart';
import 'package:traveltoken/widgets/user_search_widget.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  TextEditingController? titleController;
  TextEditingController? dateController;

  @override
  void initState() {
    titleController = TextEditingController();
    dateController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController?.dispose();
    dateController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: context.watch<CreateGroupController>().isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(AppPadding.padding22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //add people

                    const Text(
                      AppString.addPeople,
                      style: TextStyle(
                        fontFamily: AppFonts.raleWay,
                        fontSize: AppSize.appSize28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //choose people
                    const Text(
                      AppString.choosePeople,
                      style: TextStyle(
                        fontFamily: AppFonts.raleWay,
                        fontSize: AppFontSize.font16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: AppSize.appSize40),
                    //Group title
                    const TextFieldNameWidget(
                      text: AppString.groupTitle,
                    ),
                    TextFieldWidget(
                        hintText: AppString.required,
                        textEditingController: titleController,
                        onChanged: (value) {
                          context
                              .read<CreateGroupController>()
                              .changeTitle(text: value);
                        }),

                    const SizedBox(height: AppSize.appSize13),
                    //email id
                    const TextFieldNameWidget(text: AppString.searchUsers),
                    const UserSearchWidget(),
                    //added email
                    const UserListWidget(),
                    ButtonWidget(
                      text: AppString.createGroup,
                      onTap: () async {
                        final validate = context
                            .read<CreateGroupController>()
                            .validateFields();
                        if (validate.isEmpty) {
                          bool isSuccess = await context
                              .read<CreateGroupController>()
                              .createGroup();
                          if (isSuccess) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text(AppString.successFullyCreated)));
                            }
                            titleController?.clear();
                            dateController?.clear();
                            context.read<CreateGroupController>().clearList();
                            context.read<HomePageController>().getAllGroup();
                            Navigator.of(context).pop();
                          }
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(validate)));
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
