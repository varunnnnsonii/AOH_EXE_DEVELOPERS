import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:police_app/Compo/user_controller.dart';
import 'package:police_app/Profile/EditProfile.dart';
import 'package:video_player/video_player.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key, this.isNetworkImage = false});
  final bool isNetworkImage;

  @override
  State<Notifications> createState() => _ApplicaState();
}

class _ApplicaState extends State<Notifications> {
  late VideoPlayerController _controller;


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      body: ListView(
          // Padding to adjust content position
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          children: <Widget>[
        // Container for Low balance alert notification
        Material(
          elevation: 5.0, // Adjust elevation as needed
          borderRadius: BorderRadius.circular(20.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFF442B2D),
              ),
            child: Padding(
              padding: const EdgeInsets.only(top: 13.0,bottom: 13.0,left: 8,right: 8),
              child: const Row(
                children: <Widget>[
                  SizedBox(width: 5.0),
                  Icon(
                Icons.account_balance_wallet,
                color: Color(0xFFFBB8AC),
                size: 30.0,
              ),
              SizedBox(width: 30.0),
              Expanded(
                child: Text(
                  'Low balance alert: Check your account.',
                  style: TextStyle(color: Colors.red,
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Icon(Icons.chevron_right, color: Colors.grey,size: 35,),
                  SizedBox(width: 10.0),
                ],
                    ),
            ),
                ),
          ),
        ),
    const SizedBox(height: 10.0),

    // Container for New transaction: Received funds notification
    Material(
      elevation: 5.0, // Adjust elevation as needed
      borderRadius: BorderRadius.circular(20.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFF442B2D),
          ),
        child: Padding(
          padding: const EdgeInsets.only(top: 13.0,bottom: 13.0,left: 8,right: 8),
          child: const Row(
          children: <Widget>[
            SizedBox(width: 5.0),
          Icon(
          Icons.attach_money,
            color: Color(0xFFFBB8AC),
          size: 30.0,
          ),
            SizedBox(width: 30.0),
          Expanded(
          child:Text(
            'Low balance alert: Check your account.',
            style: TextStyle(color: Colors.greenAccent,
              fontSize: 16.0,
            ),
          ),
          ),
          SizedBox(width: 10.0),
          Icon(Icons.chevron_right, color: Colors.grey,size: 35,),
            SizedBox(width: 10.0),
          ],
          ),
        ),
        ),
      ),
    ),
    const SizedBox(height: 10.0),


    // Container for Transaction history updated notification
    Material(
      elevation: 5.0, // Adjust elevation as needed
      borderRadius: BorderRadius.circular(20.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFF442B2D),
          ),
        child: Padding(
          padding: const EdgeInsets.only(top: 13.0,bottom: 13.0,left: 8,right: 8),
          child: const Row(
          children: <Widget>[
            SizedBox(width: 5.0),
            Icon(
          Icons.history,
              color: Color(0xFFFBB8AC),
          size: 30.0,
          ),
          SizedBox(width: 30.0),
          Expanded(
          child: Text(
            'Low balance alert: Check your account.',
            style: TextStyle(color: Colors.blueAccent,
              fontSize: 16.0,
            ),
          ),
          ),
          SizedBox(width: 10.0),
          Icon(Icons.chevron_right, color: Colors.grey,size: 35,),
            SizedBox(width: 10.0),
          ],
          ),
        ),
        ),
      ),
    ),
    const SizedBox(height: 10.0),

    // Container for Transaction confirmed: Payment sent notification
    Material(
      elevation: 5.0, // Adjust elevation as needed
      borderRadius: BorderRadius.circular(20.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFF442B2D),
          ),
        child: Padding(
          padding: const EdgeInsets.only(top: 13.0,bottom: 13.0,left: 8,right: 8),
          child: const Row(
          children: <Widget>[
            SizedBox(width: 5.0),
            Icon(
          Icons.send,
              color: Color(0xFFFBB8AC),
          size: 30.0,
          ),
          SizedBox(width: 30.0),
          Expanded(
          child:Text(
            'Low balance alert: Check your account.',
            style: TextStyle(color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          ),
          SizedBox(width: 10.0),
          Icon(Icons.chevron_right, color: Colors.grey,size: 35,),
            SizedBox(width: 10.0),
          ],
          ),
        ),
        ),
      ),
    ),
    const SizedBox(height: 10.0),

            Material(
              elevation: 5.0, // Adjust elevation as needed
              borderRadius: BorderRadius.circular(20.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF442B2D),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 13.0,bottom: 13.0,left: 8,right: 8),
                    child: const Row(
                      children: <Widget>[
                        SizedBox(width: 5.0),
                        Icon(
                          Icons.history,
                          color: Color(0xFFFBB8AC),
                          size: 30.0,
                        ),
                        SizedBox(width: 30.0),
                        Expanded(
                          child: Text(
                            'Low balance alert: Check your account.',
                            style: TextStyle(color: Colors.blueAccent,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Icon(Icons.chevron_right, color: Colors.grey,size: 35,),
                        SizedBox(width: 10.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),

            Material(
              elevation: 5.0, // Adjust elevation as needed
              borderRadius: BorderRadius.circular(20.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF442B2D),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 13.0,bottom: 13.0,left: 8,right: 8),
                    child: const Row(
                      children: <Widget>[
                        SizedBox(width: 5.0),
                        Icon(
                          Icons.attach_money,
                          color: Color(0xFFFBB8AC),
                          size: 30.0,
                        ),
                        SizedBox(width: 30.0),
                        Expanded(
                          child:Text(
                            'Low balance alert: Check your account.',
                            style: TextStyle(color: Colors.greenAccent,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Icon(Icons.chevron_right, color: Colors.grey,size: 35,),
                        SizedBox(width: 10.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),

            const SizedBox(height: 20.0),// Adjust spacing as needed
    ],
    ),
    );
  }
}


