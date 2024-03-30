import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationScreen extends StatefulWidget {
  final double lat;
  final double lng;
  NavigationScreen(this.lat, this.lng, {super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _launchNavigation();
          },
          child: const Text('Navigate'),
        ),
      ),
    );
  }

  Future<void> _launchNavigation() async {
    String googleMapsUrl = 'https://www.google.com/maps/dir/?api=1&destination=' +
        '${widget.lat},${widget.lng}';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }
}
