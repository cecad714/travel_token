import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveltoken/constant/app_fonts.dart';
import 'package:traveltoken/constant/app_size.dart';
import 'package:traveltoken/constant/app_string.dart';
import 'package:traveltoken/controllers/add_expense_controller.dart';
import 'package:traveltoken/controllers/group_page_controller.dart';
import 'package:traveltoken/controllers/home_page_controller.dart';
import 'package:traveltoken/model/group_model.dart';
import 'package:traveltoken/widgets/button_widget.dart';
import 'package:traveltoken/widgets/text_field_widget.dart';

class AddExpensePage extends StatefulWidget {
  final GroupModel groupModel;
  const AddExpensePage({
    super.key,
    required this.groupModel,
  });

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  TextEditingController? descriptionController;
  TextEditingController? amountController;

  @override
  void initState() {
    descriptionController = TextEditingController();
    amountController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    descriptionController?.dispose();
    amountController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Consumer<AddExpenseController>(
        builder: (context, value, child) {
          return value.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //add people

                      const Text(
                        AppString.addExpense,
                        style: TextStyle(
                          fontFamily: AppFonts.raleWay,
                          fontSize: AppSize.appSize28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //choose people
                      const Text(
                        AppString.addExpenseGroup,
                        style: TextStyle(
                          fontFamily: AppFonts.raleWay,
                          fontSize: AppFontSize.font16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(
                        height: AppSize.appSize40,
                      ),
                      //Description
                      const Text(
                        AppString.description,
                        style: TextStyle(
                          fontFamily: AppFonts.raleWay,
                          fontSize: AppFontSize.font14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      TextFieldWidget(
                        hintText: AppString.required,
                        onChanged: (value) {
                          context
                              .read<AddExpenseController>()
                              .changeDescription(value: value);
                        },
                        textEditingController: descriptionController,
                      ),

                      const SizedBox(
                        height: AppSize.appSize13,
                      ),
                      //Amount
                      const Text(
                        AppString.amount,
                        style: TextStyle(
                          fontFamily: AppFonts.raleWay,
                          fontSize: AppFontSize.font14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFieldWidget(
                        hintText: AppString.required,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          context
                              .read<AddExpenseController>()
                              .changeAmount(value: value);
                        },
                        textEditingController: amountController,
                      ),

                      const SizedBox(
                        height: AppSize.appSize13,
                      ),

                      const Spacer(),

                      ButtonWidget(
                        text: AppString.addExpense,
                        onTap: () async {
                          final String validate = context
                              .read<AddExpenseController>()
                              .validateFields();

                          if (validate.isEmpty) {
                            context
                                .read<AddExpenseController>()
                                .createExpense(groupId: widget.groupModel.id);

                            descriptionController?.clear();
                            amountController?.clear();
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text(AppString.successFullyCreated)));
                            context
                                .read<GroupPageController>()
                                .getAllExpenses(groupId: widget.groupModel.id);
                            context.read<HomePageController>().getAllGroup();

                            Navigator.of(context).pop();
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
                );
        },
      )),
    );
  }
}
