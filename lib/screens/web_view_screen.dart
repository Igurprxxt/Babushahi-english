// This Screen will be shown when a user want to read full news in the app.

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home.dart';

class FullNews extends StatelessWidget {
  const FullNews({super.key, required this.url, required this.isNotification});
  final String url;
  final bool isNotification;

  @override
  Widget build(BuildContext context) {
    _launchURL(Uri url) async {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    }

    final _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            print('init ' + url);
          },
          onPageFinished: (String url) {
            print('finished ' + url);
          },
          onNavigationRequest: (NavigationRequest request) {
            // prevent navigation to youtube
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            // For whatsapp launch it as a external application
            print("request url" + request.url.toString());

            if (request.url.startsWith('whatsapp')) {
              print('blocking navigation to $request}');
              List<String> urlSplitted = request.url.split("text=");

              String message =
                  urlSplitted.last.toString().replaceAll("%20", " ");
              _launchURL(Uri.parse("https://wa.me/?text=$message"));
              return NavigationDecision.prevent;
            }
            // Also launch url for twitter
            else if (request.url.startsWith('https://twitter.com/')) {
              print('blocking navigation to $request}');
              _launchURL(Uri.parse(request.url));
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            print('error aa gai' + error.description);
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffE8ECF0),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              if (isNotification) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
