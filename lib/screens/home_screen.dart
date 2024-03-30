import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:police_app/Compo/ElevatedButton.dart';
import 'package:police_app/Compo/firebase.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../models/data_store.dart';
import '../services/join_service.dart';
import '../services/sdk_initializer.dart';
import 'live_screen.dart';
import 'package:http/http.dart' as http;
final TitleController = TextEditingController();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserDataStore _dataStore;
  bool _isLoading = false;

  @override
  void initState() {
    getPermissions();
    super.initState();
  }

  void getPermissions() async {
    await Permission.camera.request();
    await Permission.microphone.request();

    while ((await Permission.camera.isDenied)) {
      await Permission.camera.request();
    }
    while ((await Permission.microphone.isDenied)) {
      await Permission.microphone.request();
    }
  }

// Function to fetch all recording assets
  Future<List<Map<String, dynamic>>> getAllRecordingAssets(String managementToken) async {
    final String apiUrl = 'https://api.100ms.live/v2/recording-assets';

    try {
      // Make a GET request to fetch all recording assets
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $managementToken'},
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final List<dynamic> responseData = jsonDecode(response.body);
        // Map the JSON response to a list of recording assets
        return responseData.map((assetJson) => assetJson as Map<String, dynamic>).toList();
      } else {
        // If the server did not return a 200 OK response, throw an error with details
        throw Exception('Failed to load recording assets: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      throw Exception('Failed to load recording assets: $e');
    }
  }

// Function to fetch pre-signed URL for a recording asset
  Future<String> getPresignedURLForAsset(String assetId, String managementToken) async {
    final String apiUrl = 'https://api.100ms.live/v2/recording-assets/$assetId/presigned-url';

    try {
      // Make a GET request to fetch the pre-signed URL
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $managementToken'},
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        // Extract and return the pre-signed URL
        return responseData['url'];
      } else {
        // If the server did not return a 200 OK response, throw an error with details
        throw Exception('Failed to get pre-signed URL: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      throw Exception('Failed to get pre-signed URL: $e');
    }
  }

// Example usage
  void fetchPresignedURLForAsset() async {
    String managementToken='eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MTA5Mjg1ODAsImV4cCI6MTcxMTUzMzM4MCwianRpIjoiYzQwZWI4NzktOGNjOS00ODU2LTk1Y2YtMGMxMDU5N2U2NWEwIiwidHlwZSI6Im1hbmFnZW1lbnQiLCJ2ZXJzaW9uIjoyLCJuYmYiOjE3MTA5Mjg1ODAsImFjY2Vzc19rZXkiOiI2NWY1NmMwM2JhYmMzM2YwMGU0YWI2YTEifQ.Dcqj_95Ddn6WM30K88e0o78m_PkW3QOHNYISkwGdiu8';
    try {
      // Fetch all recording assets
      List<Map<String, dynamic>> assets = await getAllRecordingAssets(managementToken);
      if (assets.isNotEmpty) {
        // Choose the first asset (you may have a different method to select the asset)
        String assetId = assets.first['id'];
        // Fetch the pre-signed URL for the selected asset
        String presignedURL = await getPresignedURLForAsset(assetId, managementToken);
        // Do something with the pre-signed URL
        print('Pre-signed URL for asset $assetId: $presignedURL');
      } else {
        print('No recording assets found.');
      }
    } catch (e) {
      // Handle errors
      print('Error fetching pre-signed URL: $e');
    }
  }


  //Handles room joining functionality
  Future<bool> joinRoom({String role = "broadcaster"}) async {

    setState(() {
      _isLoading = true;
    });


    //Calling build method here
    await SdkInitializer.hmssdk.build();

    //The join method initialize sdk,gets auth token,creates HMSConfig and helps in joining the room
    bool isJoinSuccessful = await JoinService.join(SdkInitializer.hmssdk, role: role);
    if (!isJoinSuccessful) {
      return false;
    }
    _dataStore = UserDataStore();
    //Here we are attaching a listener to our DataStoreClass
    _dataStore.startListen();

    setState(() {
      _isLoading = false;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: 
        _isLoading?
        const CircularProgressIndicator(strokeWidth: 2,)
        :
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 70.0),
              child: Text("Report Live Incident",style: TextStyle(fontSize: 35
              ,fontWeight: FontWeight.w600,color: Color(0xFF442B2D)
              ),),
            ),
            DropdownMenuExample(
              onSelectionChanged: (newValue) {
                setState(() {
                  TitleController.text = newValue;
                });
              },
            ),
            SizedBox(height: 20,),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: TextField(
            //     controller: TitleController,
            //     decoration: InputDecoration(
            //       filled: true,
            //       fillColor: Color(0xFFD9C19D),
            //       hintText: 'TITLE',
            //       contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(25),),
            //     ),
            //   ),
            // ),
            SizedBox(width: MediaQuery.of(context).size.width,),
            const SizedBox(height: 30,),

           CustomElevatedButton(title: "Go Live !", color1: Color(0xFFD9C19D), color2: Color(0xFF442B2D), onPressed: () async {
        createDocument('65f56d9a8393cc22f0cdcdf5', TitleController.text);
        bool isJoined = await joinRoom();

        if (isJoined) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ListenableProvider.value(
                  value: _dataStore, child: const LiveScreen())));


        } else {
        }
      }, padh: 100, padv: 15),
           // Material(
           //   elevation: 5,
           //   borderRadius: BorderRadius.circular(20),
           //   color: Colors.transparent,
           //   child: OutlinedButton(
           //      style: ButtonStyle(
           //          backgroundColor: MaterialStateProperty.all(const Color(0xFF442B2D)),
           //          shape: MaterialStateProperty.all(
           //            RoundedRectangleBorder(
           //              borderRadius: BorderRadius.circular(40),
           //            ),
           //          )),
           //      onPressed: () async {
           //        createDocument('65f56d9a8393cc22f0cdcdf5', TitleController.text);
           //        bool isJoined = await joinRoom();
           //
           //        if (isJoined) {
           //          Navigator.of(context).push(MaterialPageRoute(
           //              builder: (_) => ListenableProvider.value(
           //                  value: _dataStore, child: const LiveScreen())));
           //
           //
           //        } else {
           //          const snackBar = SnackBar(
           //            content: Text('Error in joining room and streaming.'),
           //          );
           //          ScaffoldMessenger.of(context).showSnackBar(snackBar);
           //        }
           //      },
           //      child: const Padding(
           //        padding: EdgeInsets.symmetric(horizontal: 80,vertical: 15),
           //        child:Text('Go Live!',style: TextStyle(color: Colors.white),),
           //      ),
           //    ),
           // ),
            
            // ElevatedButton(
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 80,vertical: 15),
            //     child: const Text('Go Live!'),
            //   ),
            //   onPressed: () async {
            //     createDocument('65f56d9a8393cc22f0cdcdf5', TitleController.text);
            //     bool isJoined = await joinRoom();
            //
            //     if (isJoined) {
            //       Navigator.of(context).push(MaterialPageRoute(
            //           builder: (_) => ListenableProvider.value(
            //               value: _dataStore, child: const LiveScreen())));
            //
            //
            //     } else {
            //       const snackBar = SnackBar(
            //         content: Text('Error in joining room and streaming.'),
            //       );
            //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //     }
            //   },
            //   style: ElevatedButton.styleFrom(
            //     foregroundColor: Color(0xFFFEEAE6),
            //     backgroundColor: Color(0xFF442B2D),
            //     elevation: 8.0,
            //     shape: const BeveledRectangleBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //     ),
            //   ),
            // ),

            //Viewer
            const SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  final Function(String) onSelectionChanged;

  const DropdownMenuExample({required this.onSelectionChanged, Key? key}) : super(key: key);

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

List<String> list = <String>['TITLE','Fire', 'Robbery', 'Violence', 'Accident','Surveillance'];

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      width: 385,
      inputDecorationTheme: InputDecorationTheme(


        filled: true,
        fillColor: Color(0xFFD9C19D),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25),),
      ),
      initialSelection: list.first,
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
        widget.onSelectionChanged(dropdownValue); // Call the provided function
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}


//
// class _DropdownMenuExampleState extends State<DropdownMenuExample> {
//   String dropdownValue = list.first;
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownMenu<String>(
//       width: 385,
//       inputDecorationTheme: InputDecorationTheme(
//
//
//         filled: true,
//         fillColor: Color(0xFFD9C19D),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(25),),
//       ),
//       initialSelection: list.first,
//       onSelected: (String? value) {
//         // This is called when the user selects an item.
//         setState(() {
//           dropdownValue = value!;
//         });
//       },
//       dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
//
//         return DropdownMenuEntry<String>(value: value, label: value);
//       }).toList(),
//     );
//   }
// }
