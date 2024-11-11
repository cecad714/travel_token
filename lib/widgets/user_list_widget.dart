import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveltoken/controllers/create_group_controller.dart';

class UserListWidget extends StatelessWidget {
  // corrected class name to UserListWidget
  const UserListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: context.watch<CreateGroupController>().userModelList.length,
        itemBuilder: (context, index) {
          final user = context
              .watch<CreateGroupController>()
              .userModelList[index]; // using watch here
          return ListTile(
            title: Text(user.name),
            trailing: IconButton(
              onPressed: () {
                context
                    .read<CreateGroupController>()
                    .removeUser(user: user); // simplified removal
              },
              icon: const Icon(
                Icons.close,
                color: Colors.red,
                size: 25,
              ),
            ),
          );
        },
      ),
    );
  }
}
