// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/helpers/transelator.dart';

import 'package:libraryprox_remote/common/widgets/custom_text_field.dart';
import 'package:libraryprox_remote/common/widgets/dropdown.dart';
import 'package:libraryprox_remote/common/widgets/update_button.dart';
import 'package:libraryprox_remote/features/dashboard/screens/users_screen.dart';
import 'package:libraryprox_remote/features/dashboard/services/users_services.dart';
import 'package:libraryprox_remote/features/dashboard/services/logs_services.dart';
import 'package:libraryprox_remote/models/user_model.dart';
import 'package:libraryprox_remote/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/logs_model.dart';
import '../../../provider/user_provider.dart';

class FormUpdate extends StatefulWidget {
  final User? user;
  const FormUpdate({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<FormUpdate> createState() => _FormUpdateState();
}

class _FormUpdateState extends State<FormUpdate> {
  List<String> listItemsRoles = ["Admin", "User Id"];

  UsersServices usersServices = UsersServices();
  LogsServices logsServices = LogsServices();

  // Form Key
  final _updateUserFormKey = GlobalKey<FormState>();

  // TextControllers
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _isAdminController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  initControllers() {
    _userNameController.text = widget.user!.username.toString();
    _isAdminController.text = widget.user!.isAdmin ? "Admin" : "User Id";
  }

  updateStudent() {
    User userP = Provider.of<UserProvider>(context, listen: false).user;

    User user = User(
        id: widget.user!.id,
        username: _userNameController.text,
        isAdmin: _isAdminController.text == listItemsRoles[0] ? true : false,
        password: _passwordController.text.isNotEmpty
            ? _passwordController.text
            : null);

    usersServices.updateUser(user.id, user, context);

    logsServices.log(
        Logs(opration: "Update User ${widget.user!.id}", user: userP.username),
        context);
    setState(() {});
    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed(UsersScreen.routerName);
  }

  deleteUser() {
    User userP = Provider.of<UserProvider>(context, listen: false).user;

    usersServices.removeUser(widget.user!.id, context);

    logsServices.log(
        Logs(opration: "Update User ${widget.user!.id}", user: userP.username),
        context);
    setState(() {});
    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed(UsersScreen.routerName);
  }

  @override
  void initState() {
    super.initState();
    initControllers();
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
    listItemsRoles =
        listItemsRoles.map((e) => transelator(context, e)).toList();
    return AlertDialog(
      title: Text(transelator(context, "Update User")),
      content: SingleChildScrollView(
        child: Form(
          key: _updateUserFormKey,
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
                        DropDown(
                          value: transelator(context, _isAdminController.text),
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
              UpdateButton(onPressed: () {
                if (_updateUserFormKey.currentState!.validate()) {
                  updateStudent();
                }
              }),
              const SizedBox(height: 5),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: deleteUser,
                  child: Text(
                    transelator(context, "Remove"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
