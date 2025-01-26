import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

import 'home.dart';

class FullNews extends StatefulWidget {
  const FullNews({super.key, required this.url, required this.isNotification});
  final String url;
  final bool isNotification;

  @override
  State<FullNews> createState() => _FullNewsState();
}

class _FullNewsState extends State<FullNews> {
  late final WebViewController _controller;
  bool _isLoading = true; // Track loading state
  Timer? _loadingTimer;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
            // Start a timer to handle cases where onPageFinished isn't called quickly.
            _loadingTimer?.cancel();
            _loadingTimer = Timer(Duration(seconds: 10), () {
              if (_isLoading) {
                setState(() {
                  _isLoading = false;
                });
              }
            });
          },
          onPageFinished: (String url) {
            print('finished ' + url);
            _loadingTimer?.cancel(); // Cancel timer if page finishes first

            // Add a small delay to give time for resources to load
            Future.delayed(Duration(milliseconds: 100), () {
              if (_isLoading) {
                setState(() {
                  _isLoading = false;
                });
              }
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            print("request url" + request.url.toString());

            if (request.url.startsWith('whatsapp')) {
              print('blocking navigation to $request}');
              List<String> urlSplitted = request.url.split("text=");

              String message =
                  urlSplitted.last.toString().replaceAll("%20", " ");
              _launchURL(Uri.parse("https://wa.me/?text=$message"));
              return NavigationDecision.prevent;
            } else if (request.url.startsWith('https://twitter.com/')) {
              print('blocking navigation to $request}');
              _launchURL(Uri.parse(request.url));
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            print('error aa gai' + error.description);
            if (_isLoading) {
              setState(() {
                _isLoading = false;
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void dispose() {
    _loadingTimer?.cancel();
    super.dispose();
  }

  _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
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
              if (widget.isNotification) {
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
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading)
              Container(
                color: Colors.white.withOpacity(0.7),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
