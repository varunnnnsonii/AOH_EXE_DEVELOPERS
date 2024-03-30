import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:police_app/Compo/user_controller.dart';
import 'package:police_app/Pages/TopnavPages/article.dart';
import 'package:police_app/Pages/TopnavPages/notification.dart';

import 'package:police_app/Profile/EditProfile.dart';
import 'package:video_player/video_player.dart';

import '../TopnavPages/news.dart';
import '../Wallet/Wallet_Firebase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.isNetworkImage = false});
  final bool isNetworkImage;



  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    _controller = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
   // _controller.setLooping(true);
    _controller.setVolume(1.0);
    initializeWalletsForAllUsers();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const News(),
    const Articles(),
    const Notifications(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final networkImage = controller.user.value.profilePicture;
    final image = networkImage.isNotEmpty? networkImage: 'assets/images/profile.png';

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFFFFFBFA),
        appBar:  AppBar(
          backgroundColor:const Color(0xFFD9C19D),
          title: const Row(
            children: [

              Text(
                'SafeCity',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,fontStyle:FontStyle.italic,
                  color: Color(0xFF442B2D),),
              ),
            ],
          ),

        actions: [GestureDetector(onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditProfile()),
          );
        },
          child: Container(width: 60,
            height: 60,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(100),
            ),child:  ClipRRect(

              borderRadius: BorderRadius.circular(200),
              child: Center(
                child: networkImage.isNotEmpty
                    ? CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: image,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
                    : Image(
                  fit: BoxFit.cover,
                  image: widget.isNetworkImage ? NetworkImage(image) : AssetImage(image) as ImageProvider,
                  height: 120,
                  width: 120,
                ),
              ),
            ),),
        ),
             const SizedBox(width: 20,)
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(icon: Icon(Icons.home,color: Color(0xFF442C2E),size: 27,), text: 'News',),
              Tab(icon: Icon(Icons.article_outlined,color:Color(0xFF442C2E),size: 27,), text: 'Article'),
              Tab(icon: Icon(Icons.person,color: Color(0xFF442C2E),size: 27,), text: 'Notification'),
            ],
          ),
        ),
        body:TabBarView(
          children: _tabs,
        ),

      ),
    );
  }
  // Future<void> onJoin() async{
  //   setState(() {
  //     myController.text.isEmpty
  //         ? _validateError = true
  //         : _validateError = false;
  //   });
  //   await _permissionHandler.requestPermissions([PermissionGroup.camera, PermissionGroup.microphone]);
  //
  //   Navigator.push(context,
  //       MaterialPageRoute(
  //         builder: (context)=> CallPage(channelName: myController.text, key: null,),)
  //   );
  // }
}
