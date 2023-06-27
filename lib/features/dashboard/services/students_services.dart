// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:libraryprox_remote/apis/students_api.dart';
import 'package:libraryprox_remote/constents/error_handling.dart';
import 'package:libraryprox_remote/constents/utils.dart';
import 'package:libraryprox_remote/models/student_model.dart';

StudentsApi studentsApi = StudentsApi();

class StudentServices {
  Future<List<Students>> getAllStudents(
      BuildContext context, String? query) async {
    List<Students> students = [];

    Response response = await studentsApi.getAll();
    var notValideData = jsonDecode(utf8.decode(response.bodyBytes)) as List;

    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () {
        for (var student in notValideData) {
          students.add(Students.fromJson(jsonEncode(student)));
        }
      },
    );

    if (query != null) {
      return students.where((student) {
        final searchResult = student.fName
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            student.phone.toLowerCase().contains(query.toLowerCase()) ||
            student.id.toString().toLowerCase().contains(query.toLowerCase());
        return searchResult;
      }).toList();
    }

    return students;
  }

  Future removeStudent(int id, BuildContext context) async {
    Response response = await studentsApi.delete(id);
    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () {
        showSnackBar(context, "Deleted Student ");
      },
    );
  }

  Future updateStudent(int id, Students student, BuildContext context) async {
    Response response = await studentsApi.update(id, student);
    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () {
        showSnackBar(context, "Update book ");
      },
    );
  }

  Future addNewStudent(Students student, BuildContext context) async {
    Response response = await studentsApi.addNew(student);
    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () {
        showSnackBar(context, "Add Student ");
      },
    );
  }
}
