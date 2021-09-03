import 'package:bedrive/config/app-config.dart';
import 'package:bedrive/config/dynamic-menu.dart';
import 'package:bedrive/drive/http/app-http-client.dart';
import 'package:bedrive/drive/screens/settings-screen/sections/section-title.dart';
import 'package:bedrive/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSection extends StatefulWidget {
  @override
  _AboutSectionState createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  String version;

  @override
  void initState() {
    super.initState();
    version = context.read<AppConfig>().version;
  }

  @override
  Widget build(BuildContext context) {
    final menu = context.select((AppConfig c) => c.menus[MenuPosition.aboutSection]);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(name: 'About'),
        ListTile(
          title: text('Version'),
          subtitle: text(version, translate: false),
        ),
        Divider(),
        ..._getMenuItems(context, menu),
      ],
    );
  }

  List<ListTile> _getMenuItems(BuildContext context, DynamicMenu menu) {
    final http = context.select((AppHttpClient s) => s);
    List<ListTile> items = [
      ListTile(
        title: text('View Licenses'),
        onTap: () => showLicensePage(context: context),
      )
    ];
    if (menu == null) return items;
    menu.items.forEach((i) {
      items.insert(0, ListTile(
        title: text(i.label),
        onTap: () async {
          final url = http.prefixUrl(i.action);
          if (await canLaunch(url)) {
            launch(url);
          }
        },
      ));
    });
    return items;
  }
}

