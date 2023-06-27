// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/widgets/dot_state.dart';
import 'package:libraryprox_remote/common/widgets/loader.dart';
import 'package:libraryprox_remote/features/dashboard/services/users_services.dart';
import 'package:libraryprox_remote/features/dashboard/widgets/custom_search.dart';
import 'package:libraryprox_remote/features/dashboard/widgets/update_form_users.dart';
import 'package:libraryprox_remote/models/user_model.dart';

class UsersBody extends StatefulWidget {
  const UsersBody({Key? key}) : super(key: key);

  @override
  State<UsersBody> createState() => _UsersBodyState();
}

class _UsersBodyState extends State<UsersBody> {
  final UsersServices usersServices = UsersServices();
  List<User>? users;
  String strQuiry = "";

  fetchAllUsers() async {
    users = await usersServices.getAllUsers(context, null);

    setState(() {});
  }

  searchStudent(String query) async {
    strQuiry = query;
    if (strQuiry.isNotEmpty) {
      users = await usersServices.getAllUsers(context, strQuiry);
    } else {
      users = await usersServices.getAllUsers(context, null);
    }

    setState(() {});
  }

  _getData() async {
    await Future.delayed(const Duration(seconds: 1));
    if (users == null) {
      throw "Ther Are no Users";
    }
    if (users!.length <= 0) {
      throw "Ther Are no User in Search";
    }
    return;
  }

  @override
  void initState() {
    fetchAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          height: double.maxFinite,
          child: Column(
            children: [
              // Search Bar
              CustomeSearch(
                onChanged: searchStudent,
              ),

              const SizedBox(
                height: 20,
              ),
              // List Of Items

              FutureBuilder(
                  future: _getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return Expanded(
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: users?.length,
                            itemBuilder: (context, index) {
                              User user = users![index];
                              return InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return FormUpdate(user: user);
                                      });
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              user.username,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              user.id.toString(),
                                              style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 14,
                                                  backgroundColor: Colors.grey,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        DotState(
                                          isSoccess: user.isAdmin,
                                          successColor: Colors.purple,
                                          failColor: Colors.blue,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  })
            ],
          ),
        ));
  }
}
