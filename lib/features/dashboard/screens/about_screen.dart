// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/link.dart';

import 'package:libraryprox_remote/common/helpers/transelator.dart';
import 'package:libraryprox_remote/common/widgets/custom_app_bar.dart';
import 'package:libraryprox_remote/common/widgets/custom_drawer.dart';

class AboutSceen extends StatelessWidget {
  static const String routerName = "/dashboard/about";
  const AboutSceen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    double screenWidth = screen.width;

    return Scaffold(
      appBar:
          CustumAppBar(title: transelator(context, "About"), context: context),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            SvgPicture.asset("assets/images/about.svg", width: screenWidth),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    transelator(context, "About Discription"),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              // width: MediaQuery.of(context).size.width * .8,
              child: Card(
                elevation: 14,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "ofcode@".toUpperCase(),
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 11, 178, 184)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialIcon(
                  icon: Icons.email,
                  isUrl: false,
                  url: "mailto:ofcode96@gmail.com?subject:From LibraryProX ",
                ),
                SocialIcon(
                  icon: Icons.phone,
                  isUrl: false,
                  url: "tel:+213773939838",
                ),
                SocialIcon(
                  icon: Icons.facebook,
                  isUrl: true,
                  // url: "https://www.facbook.com/ofcode23",
                  url: "https://facebook.com/ofcode23",
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  const SocialIcon({
    Key? key,
    required this.icon,
    required this.url,
    required this.isUrl,
  }) : super(key: key);

  final IconData? icon;
  final String url;
  final bool isUrl;

  @override
  Widget build(BuildContext context) {
    // late Uri _url;
    // if (isUrl) {
    //   _url = Uri.parse(url);
    // }

    return Link(
      uri: Uri.parse(url),
      target: LinkTarget.blank,
      builder: (context, followLink) {
        return Card(
          child: InkWell(
            onTap: followLink,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(icon),
            ),
          ),
        );
      },
    );
  }
}
