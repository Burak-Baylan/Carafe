import 'package:url_launcher/url_launcher.dart';

Future goToLink(String url) async =>
    await canLaunch(url) ? await launch(url) : null;
