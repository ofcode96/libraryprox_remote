// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/helpers/generate_id.dart';
import 'package:libraryprox_remote/common/helpers/transelator.dart';
import 'package:libraryprox_remote/common/widgets/add_button.dart';

import 'package:libraryprox_remote/common/widgets/custom_text_field.dart';
import 'package:libraryprox_remote/features/dashboard/screens/users_screen.dart';
import 'package:libraryprox_remote/features/dashboard/services/users_services.dart';
import 'package:libraryprox_remote/features/dashboard/services/logs_services.dart';
import 'package:libraryprox_remote/models/user_model.dart';
import 'package:libraryprox_remote/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/logs_model.dart';
import '../../../provider/user_provider.dart';

class FormAdd extends StatefulWidget {
  const FormAdd({
    Key? key,
  }) : super(key: key);

  @override
  State<FormAdd> createState() => _FormAddState();
}

class _FormAddState extends State<FormAdd> {
  List<String> listItemsRoles = ["Admin", "User"];

  UsersServices usersServices = UsersServices();
  LogsServices logsServices = LogsServices();

  // Form Key
  final _addUserFormKey = GlobalKey<FormState>();

  // TextControllers
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _isAdminController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  addUser() {
    User userP = Provider.of<UserProvider>(context, listen: false).user;
    int userId = generateUniqueId();

    User user = User(
        id: userId,
        username: _userNameController.text,
        isAdmin: _isAdminController.text == listItemsRoles[0] ? true : false,
        password: _passwordController.text.isNotEmpty
            ? _passwordController.text
            : null);

    usersServices.addNewUser(user, context);

    logsServices.log(
        Logs(opration: "Add User $userId", user: userP.username), context);
    setState(() {});
    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed(UsersScreen.routerName);
  }

  @override
  void initState() {
    super.initState();
    _isAdminController.text = listItemsRoles[0];
  }

  @override
  void dispose() {
    super.dispose();

// Dispose Controller
    _userNameController.dispose();
    _isAdminController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context, listen: false).isDark;
    return AlertDialog(
      title: Text(transelator(context, "User")),
      content: SingleChildScrollView(
        child: Form(
          key: _addUserFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transelator(context, "User Name")),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _userNameController,
                hintText: transelator(context, "User Name"),
                onChanged: (String text) async {},
              ),
              const SizedBox(height: 8),
              Text(transelator(context, "Password")),
              const SizedBox(height: 8),
              CustomTextField(
                obscureText: true,
                mostEmpty: true,
                controller: _passwordController,
                hintText: transelator(context, "Password"),
                onChanged: (String text) async {},
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transelator(context, "Role")),
                        const SizedBox(height: 3),
                        DropdownButton(
                          isExpanded: true,
                          alignment: Alignment.centerRight,
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                          value: _isAdminController.text,
                          items: listItemsRoles
                              .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            _isAdminController.text = value!;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AddButton(onPressed: () {
                if (_addUserFormKey.currentState!.validate()) {
                  addUser();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
