import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:ui';
class Article {
  final String imagePath;
  final String name;
  final String title;
  final String subtitle;
  final String url;

  Article({
    required this.imagePath,
    required this.name,
    required this.title,
    required this.subtitle,
    required this.url,
  });
}

class Articles extends StatefulWidget {
  const Articles({Key? key}) : super(key: key);

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> with TickerProviderStateMixin {
  late final Map<int, AnimationController> _controllers;
  late final Map<int, Animation<Offset>> _animations;
  final List<Article> articles = [
    Article(
      imagePath: "assets/images/appo.jpg",
      name: "John Doe",
      title: "Car Crash on Main Street",
      subtitle: "Multiple vehicles involved in a collision, causing traffic delays.",
      url: "https://www.drishtiias.com/daily-updates",
    ),
    Article(
      imagePath: "assets/images/appo.jpg",
      name: "Jane Smith",
      title: "Fire Breaks Out in Downtown Building",
      subtitle: "Firefighters battling flames; residents evacuated safely.",
      url: "https://www.nidirect.gov.uk/articles/keeping-children-safe-while-out-and-about",
    ),
    Article(
      imagePath: "assets/images/fire.jpg",
      name: "Jane Smith",
      title: "Fire Breaks Out in Downtown Building",
      subtitle: "Firefighters battling flames; residents evacuated safely.",
      url: "https://timesofindia.indiatimes.com/topic/safety-rules/news",
    ),
    Article(
      imagePath: "assets/images/fire.jpg",
      name: "Pritesh Verma",
      title: "Gas Leak Reported in Residential Area",
      subtitle: "Emergency services respond to gas leak; precautionary measures taken.",
      url: "https://www.drishtiias.com/daily-updates/daily-news-analysis/ncrbs-crime-in-india-2022-report",
    ),
    Article(
      imagePath: "assets/images/appo.jpg",
      name: "Varun D. Soni",
      title: "Robbery at Local Bank",
      subtitle: "Authorities investigate bank robbery; suspects at large.",
      url: "https://www.nidirect.gov.uk/articles/keeping-children-safe-while-out-and-about",
    ),
    Article(
      imagePath: "assets/images/fire2.jpg",
      name: "Sharib Khan",
      title: "Building Collapse in City Center",
      subtitle: "Search and rescue operation underway after building collapse.",
      url: "https://timesofindia.indiatimes.com/topic/safety-rules/news",
    ),
    Article(
      imagePath: "assets/images/fire.jpg",
      name: "Harshvardhan Surve",
      title: "Heavy Rain Causes Flooding in Suburbs",
      subtitle: "Flash floods reported; residents urged to stay indoors.",
      url: "https://www.nidirect.gov.uk/articles/keeping-children-safe-while-out-and-about",
    ),
    Article(
      imagePath: "assets/images/appo.jpg",
      name: "Aryan Darade",
      title: "Power Outage Hits Neighborhood",
      subtitle: "Electricity outage affects thousands; restoration efforts ongoing.",
      url: "https://timesofindia.indiatimes.com/topic/safety-rules/news",
    ),
    // Add more articles here
  ];
  @override
  void initState() {
    super.initState();
    _controllers = {};
    _animations = {};
    for (int i = 0; i < articles.length; i++) {
      _controllers[i] = AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      );
      _animations[i] = Tween<Offset>(
        begin: const Offset(1.1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controllers[i]!,
          curve: Curves.easeInOut,
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 1,
          padding: const EdgeInsets.all(5.0),
          childAspectRatio: 9.2 / 8.0,
          children: <Widget>[
            for (int i = 0; i < articles.length; i++) buildArticleItem(i),
          ],
        ),
      ),
    );
  }

  Widget buildArticleItem(int index) {
    final article = articles[index];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => WebViewPage(
          //       url: article.url,
          //       title: article.title,
          //     ),
          //   ),
          // );
          _handleTap(index);
        },
        child: Material(
          elevation: 6.0,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              height: 420,
              width: 320,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        image: AssetImage(article.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFF442B2D),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(22),
                              bottomRight: Radius.circular(22),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Positioned(
                    bottom: 9,
                    left: 20,
                    child: Text(
                      'Author :   ${article.name}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
    SlideTransition(
    position: _animations[index]!,
    child: ClipRRect(
    clipBehavior: Clip.hardEdge,
    borderRadius: BorderRadius.circular(25),
    child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    child: Padding(
    padding: const EdgeInsets.only(left: 32.0, right: 32),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    SizedBox(height: 30),
    SelectableText(
    article.title,
    style: TextStyle(
    fontSize: 24,
    color: Color(0xFF442B2D),
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(height: 15),
    SelectableText(
    article.subtitle,
    style: TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    ),
    ),
    Expanded(
    child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
    ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewPage(
            url: article.url,
            title: article.title,
          ),
        ),
      );
    },
    style: ElevatedButton.styleFrom(
    foregroundColor: Color(0xFF442B2D),
    backgroundColor: Color(0xFFD9C19D),
    elevation: 8.0,
    shape: const BeveledRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(9.0)),
    ),
    ),
    child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 10),
    child: const Text(
    'learn more...',
    style: TextStyle(fontSize: 15),
    ),
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    ),
    IgnorePointer(
    child: SizedBox(
    width: 320,
    height: 420,
    child: DecoratedBox(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    ),
    ),
    ),
    ),// Rest of your UI code remains the same...
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _handleTap(int index) {
    for (int i = 0; i < articles.length; i++) {
      if (i == index) {
        if (_controllers[i]!.status == AnimationStatus.completed) {
          _controllers[i]!.reverse();
        } else {
          _controllers[i]!.forward();
        }
      } else {
        _controllers[i]!.reverse();
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  const WebViewPage({Key? key, required this.url, required this.title}) : super(key: key);

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
      body: Stack(
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
