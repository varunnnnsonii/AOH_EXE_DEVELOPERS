import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class News extends StatelessWidget {
  const News({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(6.0),
          childAspectRatio: 7.2 / 8,
          children: <Widget>[
            for (int i = 0; i < 8; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => _openWebView(context, _getUrlForIndex(i + 1), _getTitleForIndex(i)), // Open WebView with URL on tap
                  child: Material(
                    elevation: 4.0, // Adjust elevation as needed
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 14.0 / 10.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(9),
                                  child: Image.asset(
                                    _getImageForIndex(i),
                                    height: 170.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                _getTitleForIndex(i),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _openWebView(BuildContext context, String url, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebViewPage(url: url, title: title)),
    );
  }

  String _getImageForIndex(int index) {
    switch (index) {
      case 0:
        return 'assets/images/fire2.jpg';
      case 1:
        return 'assets/images/fire.jpg';
      case 2:
        return 'assets/images/appo.jpg';
      case 3:
        return 'assets/images/fire2.jpg';
      case 4:
        return 'assets/images/fire.jpg';
      case 5:
        return 'assets/images/appo.jpg';
      case 6:
        return 'assets/images/fire2.jpg';
      case 7:
        return 'assets/images/fire.jpg';
      default:
        return '';
    }
  }

  String _getTitleForIndex(int index) {
    switch (index) {
      case 0:
        return 'Car Crash on Main Street';
      case 1:
        return 'Fire Breaks Out in Downtown Building';
      case 2:
        return 'Gas Leak Reported in Residential Area';
      case 3:
        return 'Robbery at Local Bank';
      case 4:
        return 'Building Collapse in City Center';
      case 5:
        return 'Heavy Rain Causes Flooding in Suburbs';
      case 6:
        return 'Power Outage Hits Neighborhood';
      case 7:
        return 'Traffic Accident on Highway';
      default:
        return '';
    }
  }

  String _getUrlForIndex(int index) {
    switch (index) {
      case 1:
        return 'https://www.drishtiias.com/daily-updates';
      case 2:
        return 'https://www.nidirect.gov.uk/articles/keeping-children-safe-while-out-and-about';
      case 3:
        return 'https://timesofindia.indiatimes.com/topic/safety-rules/news';
      case 4:
        return 'https://www.drishtiias.com/daily-updates/daily-news-analysis/ncrbs-crime-in-india-2022-report';
      case 5:
        return 'https://www.nidirect.gov.uk/articles/keeping-children-safe-while-out-and-about';
      case 6:
        return 'https://timesofindia.indiatimes.com/topic/safety-rules/news';
      case 7:
        return 'https://www.nidirect.gov.uk/articles/keeping-children-safe-while-out-and-about';
      case 8:
        return 'https://timesofindia.indiatimes.com/topic/safety-rules/news';
      default:
        return '';
    }
  }
}

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  const WebViewPage({required this.url, required this.title});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  var loadingPercentage = 0;
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse(widget.url),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFFD9C19D),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF442B2D)), // Back icon
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        title: Text(widget.title,style: TextStyle(color: Color(0xFF442B2D),fontSize: 20,fontWeight: FontWeight.w600),),
      ),
      // body: WebView(
      //   initialUrl: url,
      //   javascriptMode: JavascriptMode.unrestricted,
      // ),
      body:Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
        ],
      ),
    );
  }
}
