import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String transelator(BuildContext context, String text) {
  AppLocalizations? local = AppLocalizations.of(context)!;

  switch (text) {
    case "Book":
      return local.addnew(local.book);
    case "Student":
      return local.addnew(local.student);
    case "Borrow":
      return local.addnew(local.borrow);
    case "User":
      return local.addnew(local.users);
    case "Book Title":
      return local.booktitle;
    case "Pages":
      return local.pages;
    case "Part":
      return local.part;
    case "Version":
      return local.version;

    case "Date Print":
      return local.dateprint;

    case "Price":
      return local.price;

    case "Copies":
      return local.copies;

    case "Edition":
      return local.edition;

    case "Author":
      return local.author;

    case "Description":
      return local.description;

    case "Student Full Name":
      return local.studentfullname;
    case "Address":
      return local.address;
    case "Phone Number":
      return local.phonenumber;
    case "Date Birth":
      return local.datebirth;

    case "Role":
      return local.role;

    case "Book ID":
      return local.withid(local.book);
    case "Student ID":
      return local.withid(local.student);
    case "Borrow ID":
      return local.withid(local.borrow);
    case "Start Date":
      return local.startdate;
    case "End Date":
      return local.enddate;
    case "User Name":
      return local.userName;
    case "Password":
      return local.password;
    case "Aviable":
      return local.aviable;
    case "Banned":
      return local.banned;
    case "State Borrow":
      return local.stateborrow;
    case "Admin":
      return local.admin;

    case "Remove":
      return local.remove;

    case "Update User":
      return local.updateold(local.user);

    case "Update Borrow":
      return local.updateold(local.borrow);

    case "Update Book":
      return local.updateold(local.book);

    case "Update Student":
      return local.updateold(local.student);

    case "Update":
      return local.update;

    case "User Id":
      return local.user;

    case "Last browed":
      return local.lastbrrowed;

    case "Signin date":
      return local.signindate;
    case "Yes":
      return local.yes;
    case "No":
      return local.no;

    case "Runing":
      return local.runing;

    case "Stoped":
      return local.stoped;

    case "Missed":
      return local.missed;

    case "Day":
      return local.day;
    case "Days Left":
      return local.dayleft;
    case "About":
      return local.about;

    case "About Discription":
      return local.aboutdisc;

    case "Home":
      return local.home;
    case "Books":
      return local.books;
    case "Students":
      return local.students;
    case "Borrows":
      return local.borrows;
    case "Logs":
      return local.logs;
    case "Users":
      return local.users;

    default:
      return text;
  }
}
