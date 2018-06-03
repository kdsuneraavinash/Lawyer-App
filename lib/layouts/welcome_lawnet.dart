import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:flutter/material.dart';

class WelcomeLawnet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: "https://www.lawnet.gov.lk",
    );
  }

}
