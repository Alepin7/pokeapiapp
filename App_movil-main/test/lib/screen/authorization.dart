import 'package:flutter/material.dart';
import 'package:test/main.dart';
import 'package:test/screen/Loginpage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:test/service/voter.dart';
import 'package:test/screen/Homepage.dart';

class AuthorizationScreen extends StatelessWidget {
  final String url;
  final String token;

  const AuthorizationScreen(
      {super.key, required this.url, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebView(
      initialUrl: url,
      userAgent: "Utem/1.0",
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) {
        controller.clearCache();
        CookieManager().clearCookies();
      },
      navigationDelegate: (delegate) async {
        final Uri responseUri = Uri.parse(delegate.url);
        final String path = responseUri.path;
        final bool ok = path.endsWith('/' + token + '/result');
        if (ok) {
          final jwt = await VoterService.getJwt(token);

          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ok
                      ? MyHomePage(
                          title: "UTEM",
                          jwt: jwt,
                        )
                      : const LoginScreen()));
        }

        return NavigationDecision.navigate;
      },
    ));
  }
}
