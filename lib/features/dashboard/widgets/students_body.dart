// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/widgets/dot_state.dart';
import 'package:libraryprox_remote/common/widgets/loader.dart';
import 'package:libraryprox_remote/features/dashboard/services/students_services.dart';
import 'package:libraryprox_remote/features/dashboard/widgets/custom_search.dart';
import 'package:libraryprox_remote/models/student_model.dart';

import '../screens/students_actions_screens.dart';

class StudentsBody extends StatefulWidget {
  const StudentsBody({Key? key}) : super(key: key);

  @override
  State<StudentsBody> createState() => _StudentsBodyState();
}

class _StudentsBodyState extends State<StudentsBody> {
  final StudentServices studentServices = StudentServices();
  List<Students>? students;
  String strQuiry = "";

  fetchAllStudents() async {
    students = await studentServices.getAllStudents(context, null);

    students?.sort((a, b) => b.id.compareTo(a.id));

    setState(() {});
  }

  searchStudent(String query) async {
    strQuiry = query;
    if (strQuiry.isNotEmpty) {
      students = await studentServices.getAllStudents(context, strQuiry);
    } else {
      students = await studentServices.getAllStudents(context, null);
    }

    setState(() {});
  }

  _getData() async {
    await Future.delayed(const Duration(seconds: 1));
    if (students == null) {
      throw "Ther Are no Student";
    }
    if (students!.length <= 0) {
      throw "Ther Are no Student in Search";
    }
    return;
  }

  @override
  void initState() {
    fetchAllStudents();
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
                            itemCount: students?.length,
                            itemBuilder: (context, index) {
                              var student = students![index];
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          StudentsActionsScreen(
                                        student: student,
                                      ),
                                    ),
                                  );
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
                                              student.fName,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              student.id.toString(),
                                              style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 14,
                                                  backgroundColor: Colors.grey,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        DotState(isSoccess: !student.isBanned)
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
