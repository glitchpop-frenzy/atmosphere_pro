import 'package:at_common_flutter/services/size_config.dart';
import 'package:atsign_atmosphere_pro/utils/colors.dart';
import 'package:atsign_atmosphere_pro/view_models/welcome_screen_view_model.dart';
import 'package:flutter/material.dart';

class SideBarItem extends StatelessWidget {
  final String? image;
  final String? title;
  final String? routeName;
  final Map<String, dynamic>? arguments;
  final bool showIconOnly, isDesktop;
  final WelcomeScreenProvider _welcomeScreenProvider = WelcomeScreenProvider();
  final Color displayColor;
  final bool isScale;
  final bool showNotificationDot;
  SideBarItem(
      {Key? key,
      this.image,
      this.title,
      this.routeName,
      this.arguments,
      this.showIconOnly = false,
      this.isScale = false,
      this.displayColor = ColorConstants.fadedText,
      this.showNotificationDot = false,
      this.isDesktop = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // since all arguments should be final in stateless widget
    bool _isScale = isScale;
    if (SizeConfig().isMobile(context)) {
      _isScale = false;
    }

    return InkWell(
      onTap: () {
        if (SizeConfig().isMobile(context) ||
            _welcomeScreenProvider.isExpanded) {
          Navigator.pop(context);
        }
        Navigator.pushNamed(context, routeName!, arguments: arguments ?? {});
      },
      child: Container(
        height: 50,
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(right: isDesktop ? 20 : 10),
                  child: Transform.scale(
                    scale: _isScale ? 1.2 : 1,
                    child: Image.asset(
                      image!,
                      height: SizeConfig().isTablet(context) ? 24 : 22.toHeight,
                      color: displayColor,
                    ),
                  ),
                ),
                if (showNotificationDot)
                  Positioned(
                    top: 0,
                    right: (isDesktop ? 20 : 10) - 4.toWidth,
                    child: Container(
                      width: 8.toWidth,
                      height: 8.toWidth,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  )
              ],
            ),
            !showIconOnly
                ? Expanded(
                    child: Text(
                      title!,
                      softWrap: true,
                      style: TextStyle(
                        color: displayColor,
                        letterSpacing: 0.1,
                        fontSize: 13.toFont,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  // this function isn't used
  // Future<void> _launchInBrowser(String url) async {
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(
  //       Uri.parse(url),
  //       // forceSafariVC: false,
  //       // forceWebView: false,
  //     );
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
