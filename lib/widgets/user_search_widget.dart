import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:traveltoken/constant/app_color.dart';
import 'package:traveltoken/constant/app_size.dart';
import 'package:traveltoken/constant/app_string.dart';
import 'package:traveltoken/controllers/create_group_controller.dart';
import 'package:traveltoken/model/user_model.dart';

class UserSearchWidget extends StatelessWidget {
  const UserSearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController? textEditingController;
    return TypeAheadField<UserModel>(
      suggestionsCallback: (search) {
        return Provider.of<CreateGroupController>(context, listen: false)
            .searchUsers(key: search);
      },
      builder: (context, controller, focusNode) {
        textEditingController = controller;
        return Container(
          height: AppSize.appSize37,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColor.formFieldFill),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            controller: textEditingController,
            focusNode: focusNode,
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: AppString.required,
                contentPadding: EdgeInsets.only(left: 10),
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: AppFontSize.font16,
                )),
          ),
        );
      },
      itemBuilder: (context, user) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(user.name),
        );
      },
      onSelected: (user) {
        context.read<CreateGroupController>().addUser(user: user);
        textEditingController?.clear();
      },
    );
  }
}
