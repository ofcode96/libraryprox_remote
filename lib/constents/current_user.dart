import 'package:flutter/material.dart';
import 'package:libraryprox_remote/models/user_model.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

User currentUser(BuildContext context) {
  return Provider.of<UserProvider>(context).user;
}
