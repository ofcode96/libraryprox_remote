import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:libraryprox_remote/features/auth/screens/auth_srceen.dart';
import 'package:libraryprox_remote/features/auth/services/auth_service.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QrScreen extends StatefulWidget {
  static const String routerName = "/qr";
  const QrScreen({Key? key}) : super(key: key);

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  AuthService authService = AuthService();

  MobileScannerController mobileScannerController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    AppLocalizations? local = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black.withOpacity(.5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, AuthScreen.routerName, (route) => false),
        ),
        title: Text(local.scanQr),
      ),
      // backgroundColor: Colors.black.withOpacity(.8),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 3,
              child: MobileScanner(
                controller: mobileScannerController,
                onDetect: (barcodes) {
                  final data = jsonDecode(barcodes.barcodes.first.rawValue!);
                  authService.loginQr(context, data["ip"], data["token"]);
                },
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );

    // Scaffold(
    //   extendBodyBehindAppBar: true,
    //   appBar: AppBar(
    //       elevation: 0,
    //       backgroundColor: Colors.transparent.withOpacity(0),
    //       leading: IconButton(
    //         iconSize: 35,
    //         icon: const Icon(
    //           Icons.arrow_back,
    //           color: Color.fromARGB(255, 71, 176, 225),
    //         ),
    //         onPressed: () {
    //           Navigator.pushNamedAndRemoveUntil(
    //               context, AuthScreen.routerName, (route) => false);
    //         },
    //       )),
    //   body: Stack(
    //     alignment: Alignment.center,
    //     children: [
    //       QRView(
    //         key: qrCode,
    //         onQRViewCreated: qrActions,
    //         overlay: QrScannerOverlayShape(
    //             borderWidth: 10,
    //             borderColor: const Color.fromARGB(255, 73, 195, 202)),
    //       ),
    //     ],
    //   ),
    // );
  }
}
