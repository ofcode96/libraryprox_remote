// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:libraryprox_remote/apis/test_apis.dart';
import 'package:libraryprox_remote/common/helpers/ip_handler.dart';
import 'package:libraryprox_remote/common/helpers/shared_prefrences.dart';
import 'package:libraryprox_remote/common/widgets/custom_text_field.dart';
import 'package:libraryprox_remote/constents/globales.dart';
import 'package:libraryprox_remote/enums/auth_enum.dart';
import 'package:libraryprox_remote/features/auth/screens/auth_qr_screen.dart';
import 'package:libraryprox_remote/features/auth/services/auth_service.dart';

import '../widgets/login_button.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthScreen extends StatefulWidget {
  static const String routerName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Auth Type
  Auth _auth = Auth.init;

  // Chek if Ip Server is working
  bool ipIsWorking = false;

  // Form Key
  final _loginFormKey = GlobalKey<FormState>();
  // final _fastLoginFormKey = GlobalKey<FormState>();

  // Form Controllers
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Call  Auth services
  AuthService authService = AuthService();

  // Classical Login
  void classicLogin() async {
    await IpHandler.init();
    authService.login(
      username: _userNameController.text,
      password: _passwordController.text,
      context: context,
    );
  }

  @override
  void dispose() {
    super.dispose();

    //dispose controllers
    _ipController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    double screenWidth = screen.width;
    double screenHeight = screen.height;
    AppLocalizations? local = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // White Space

                SizedBox(
                  height: screenHeight * .16,
                ),
                SvgPicture.asset(
                  'assets/images/login.svg',
                  width: screenWidth * .6,
                ),

                // Logo With Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/logolibrary.svg',
                      width: screenWidth * .05,
                      color: Globals.primaryColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'LibraryProX',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * .03,
                ),
                LoginButton(
                  onPressed: () {
                    setState(() {
                      if (_auth == Auth.login) {
                        _auth = Auth.init;
                      } else {
                        _auth = Auth.login;
                      }
                    });
                  },
                  width: screenWidth * .8,
                  height: screenHeight * .07,
                  text: local.login,
                  color: Globals.primaryColor,
                ),
                SizedBox(
                  height: screenHeight * .02,
                ),

                // Form Login
                if (_auth == Auth.login)
                  Form(
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        // IP
                        CustomTextField(
                          style: TextStyle(
                              color: !ipIsWorking ? Colors.red : Colors.green),
                          hintText: "IP (192.186.....)",
                          controller: _ipController,
                          onChanged: (String text) async {
                            Response response = await TestApi.test(text);
                            if (response.statusCode == 200) {
                              await SharedPrefrencesServices.storeData(
                                  "IP", text);
                              setState(() {
                                ipIsWorking = true;
                              });
                            } else {
                              setState(() {
                                ipIsWorking = false;
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: screenHeight * .01,
                        ),
                        // User Name
                        CustomTextField(
                          hintText: local.userName,
                          controller: _userNameController,
                        ),
                        SizedBox(
                          height: screenHeight * .01,
                        ),
                        // Password
                        CustomTextField(
                          obscureText: true,
                          hintText: local.password,
                          controller: _passwordController,
                        ),
                        SizedBox(
                          height: screenHeight * .01,
                        ),
                        // Login Button
                        ElevatedButton(
                          onPressed: () {
                            if (_loginFormKey.currentState!.validate()) {
                              classicLogin();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(screenWidth * .7, screenHeight * .08)),
                          child: Text(
                            local.login,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * .03,
                        ),
                      ],
                    ),
                  ),

                // Login Button QR
                LoginButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      QrScreen.routerName,
                      (route) => false,
                    );
                    setState(() {
                      _auth = Auth.loginFast;
                    });
                  },
                  width: screenWidth * .8,
                  height: screenHeight * .07,
                  text: local.fastLogin,
                  color: const Color.fromARGB(255, 25, 215, 117),
                ),

                // Button To Login Fast
                // Login Form
              ],
            ),
          ),
        ),
      ),
    );
  }
}
