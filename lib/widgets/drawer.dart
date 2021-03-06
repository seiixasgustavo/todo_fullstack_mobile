import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:todo_mobile_fullstack/providers/auth.dart' show Auth;
import 'package:todo_mobile_fullstack/providers/todos.dart';
import 'package:todo_mobile_fullstack/screens/login_page.dart';
import 'package:todo_mobile_fullstack/utils/url.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context, listen: false).user;
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 0.0),
                  colors: [
                    const Color(0xFF202020),
                    Colors.blueAccent,
                  ],
                  tileMode: TileMode.repeated,
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    SvgPicture.asset(
                      "images/male_avatar.svg",
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    SizedBox(height: 10),
                    Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.only(top: 10.0),
              child: ListView(
                children: [
                  ListTileWithIcon(
                    icon: FontAwesomeIcons.solidBell,
                    text: 'Notifications',
                    iconColor: Colors.blueAccent,
                    onPressed: () {},
                  ),
                  Divider(),
                  ListTileWithIcon(
                    icon: FontAwesomeIcons.solidUser,
                    text: 'User',
                    iconColor: Colors.deepOrange[400],
                    haveTrailing: true,
                    onPressed: () {},
                  ),
                  ListTileWithIcon(
                    icon: FontAwesomeIcons.solidCommentAlt,
                    text: 'Feedback',
                    iconColor: Colors.orange,
                    haveTrailing: true,
                    onPressed: () {},
                  ),
                  Divider(),
                  ListTileWithIcon(
                    icon: FontAwesomeIcons.github,
                    text: 'Github',
                    iconColor: Colors.blueGrey[700],
                    onPressed: () async {
                      if (await canLaunch(kGithubUrl)) {
                        await launch(kGithubUrl);
                      } else {
                        throw 'Could not launch $kGithubUrl';
                      }
                    },
                  ),
                  ListTileWithIcon(
                    icon: FontAwesomeIcons.linkedin,
                    text: 'Linkedin',
                    iconColor: Colors.blueGrey,
                    onPressed: () async {
                      if (await canLaunch(kLinkedinURL)) {
                        await launch(kLinkedinURL);
                      } else {
                        throw 'Could not launch $kLinkedinURL';
                      }
                    },
                  ),
                  Divider(),
                  ListTileWithIcon(
                    icon: FontAwesomeIcons.signOutAlt,
                    text: "Sign Out",
                    iconColor: Colors.red[500],
                    onPressed: () {
                      Provider.of<Auth>(context, listen: false).logout();
                      Provider.of<Todos>(context, listen: false).logout();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login-page', (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListTileWithIcon extends StatelessWidget {
  ListTileWithIcon({
    @required this.icon,
    @required this.text,
    @required this.iconColor,
    @required this.onPressed,
    this.haveTrailing = false,
  });

  final IconData icon;
  final String text;
  final Color iconColor;
  final Function onPressed;
  final bool haveTrailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onPressed();
      },
      leading: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: iconColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(
          icon,
          size: 20.0,
          color: Colors.white,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
      trailing: haveTrailing
          ? Icon(FontAwesomeIcons.chevronRight, size: 12.0)
          : SizedBox(),
    );
  }
}
