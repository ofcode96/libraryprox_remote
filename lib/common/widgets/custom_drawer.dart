import 'package:flutter/material.dart';

import 'package:libraryprox_remote/common/helpers/transelator.dart';
import 'package:libraryprox_remote/constents/globales.dart';
import 'package:libraryprox_remote/models/user_model.dart';
import 'package:libraryprox_remote/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../constents/menu_items.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            headerDrawer(context),
            const MenuList(),
          ],
        ),
      ),
    );
  }

  Widget headerDrawer(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;
    return Material(
      color: Globals.primaryColor,
      child: InkWell(
        onTap: () {
          //? Next Version
        },
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundColor: Colors.black45,
                child: Icon(Icons.person, size: 60),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                user.username.toString(),
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.isAdmin
                        ? transelator(context, "Admin")
                        : transelator(context, "User Id"),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuList extends StatelessWidget {
  const MenuList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 12,
      children: [
        SizedBox(
            height: double.maxFinite,
            child: Column(
              children: menuItems.map((menu) {
                User user = Provider.of<UserProvider>(context).user;
                if (menu.name == "Logs" && !user.isAdmin) {
                  return Container();
                }
                if (menu.name == "Users" && !user.isAdmin) {
                  return Container();
                }

                String menuStr = transelator(context, menu.name);

                return ListTile(
                  leading: Icon(
                    menu.icon,
                  ),
                  title: Text(
                    menuStr,
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(menu.route);
                  },
                );
              }).toList(),
            )),
      ],
    );
  }
}
