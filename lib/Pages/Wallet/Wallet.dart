import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:police_app/Compo/ElevatedButton.dart';
import 'package:police_app/Pages/Wallet/Wallet_Transactions.dart';
import 'Wallet_Firebase.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  _WalletPageState createState() => _WalletPageState();
}



class _WalletPageState extends State<WalletPage> {
  String? userID = FirebaseAuth.instance.currentUser?.uid;

  int balance=5;
  @override
  void initState() {
    super.initState();
    getCurrentUserBalance(); 
  }

  void getCurrentUserBalance() async {
    int amount=5;
    try {
      // Get the current user's ID
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      print(userId);
      if (userId != null) {
        // Reference to the Firestore collection
        CollectionReference walletCollection = FirebaseFirestore.instance.collection('Wallet');

        // Query for the specific document with the current user's ID
        DocumentSnapshot walletDoc = await walletCollection.doc(userId).get();

        // Check if the document exists
        if (walletDoc.exists) {
          // Cast the data to Map<String, dynamic>
          Map<String, dynamic> data = walletDoc.data() as Map<String, dynamic>;

          // Retrieve the amount from the document data after null check
          amount = data['Amount'] ?? 0.0;

          // Return the amount
          print('yesssssss');
          print('yesssssss');
          print('yesssssss');
          print('yesssssss');
          print('yesssssss');
          print('yesssssss');
          print('yesssssss');
          print(amount);

          balance=amount;
          print( balance);

        } else {
          print('hmmm');        print('hmmm');
          print('hmmm');
          print('hmmm');
          print('hmmm');
          print('hmmm');



          // If the document doesn't exist, return 0

        }
      } else {
        print('on');      print('on');
        print('on');
        print('on');
        print('on');
        print('on');

        // If user is not logged in, return 0

      }
    } catch (e) {
      // Handle any errors
      print("Error retrieving amount: $e");

    }
    setState(() {
      balance = amount;
    });
  }





  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFFFFBFA),
      // appBar:  AppBar(
      //   backgroundColor:const Color(0xFF442B2D),
      //   title: const Text(
      //     'Wallet',
      //     style: TextStyle(fontSize: 20,
      //         color: Color(0xFFFEDBD0)),
      //   ),
      // ),
      body: Column(
          children: [
            const SizedBox(height: 60,),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 230,
                width: 400,
                decoration: const BoxDecoration(

                  gradient:LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF442B2D),
                        Color(0xFFD9C19D),
                        Color(0xFFD9C19D),
                  ]),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                      SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                         SizedBox(width: 300,
                         height: 130,
              child:Padding(
                padding: const EdgeInsets.only(left: 19.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Current Balance',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w800),),
                SizedBox(height: 20,),

                Text('₹ $balance',style: TextStyle(color: Colors.black,fontSize: 40,fontWeight: FontWeight.w800),)//balance
                  ],
                ),
              ),
                         ),
                    ],

                      ),
                      height: 130,
                    ),
                    // ElevatedButton(
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 13.0,horizontal: 50),
                    //     child: const Text('Send Badges'),
                    //   ),
                    //   onPressed: () async {          Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) =>  TransactionPage()),
                    //   );
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     foregroundColor: Color(0xFF442B2D),
                    //     backgroundColor: Color(0xFFFEEAE6),
                    //     elevation: 8.0,
                    //     shape: const BeveledRectangleBorder(
                    //       borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    //     ),
                    //   ),
                    // ),
                    CustomElevatedButton(title: 'Send Badges', color1: Color(0xFF442B2D), color2: Color(0xFFD9C19D), onPressed: () async { Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  TransactionPage()),
      );
      }, padh: 70, padv: 14),
                  //  CustomElevatedButton(title: 'Ref', color1:  Colors.black, color2:  Colors.black, onPressed: getCurrentUserBalance, padh: 40, padv: 10),

                    // OutlinedButton(
                    //
                    //   style: ButtonStyle(
                    //
                    //       backgroundColor: MaterialStateProperty.all(const Color(0xff4A8CB0)),
                    //       shape: MaterialStateProperty.all(
                    //         RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(40),
                    //         ),
                    //       )),
                    //   onPressed: () async {          Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) =>  TransactionPage()),
                    //   );
                    //   },
                    //   child: const Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 128,vertical: 15),
                    //     child:Text('Send Badges',style: TextStyle(color: Colors.white),),
                    //   ),
                    // ),

                  ],
                ),


              ),
            ),
            const SizedBox(height: 0,),

            Expanded(
              child:  _buildTransactionList(context),
            )
          ],
        ),









    );
  }

  Widget _buildTransactionList(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('Wallet').doc(userID).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Check if the document exists
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(
            child: Text('No transactions found.'),
          );
        }

        // Get the list of transactions from the document
        List<Map<String, dynamic>> transactions = List<Map<String, dynamic>>.from(snapshot.data!['Transactions']);

        if (transactions.isEmpty) {
          return const Center(
            child: Text('No transactions found.'),
          );
        }
        transactions.sort((a, b) => b['Time'].compareTo(a['Time']));

        // Build the ListView of transactions
        return ListView.builder(
          itemCount: transactions.length,

          itemBuilder: (context, index) {
            Map<String, dynamic> transaction = transactions[index];
            return      Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 145.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: const Color(0xFF442B2D),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  border: Border.all(
                    color: Color(0xFFFEEAE6),
                    width: 2.0,
                  ),
                ),
                child: ListTile(
                  title:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 60.0,
                                  height: 60.0,
                                  // decoration: BoxDecoration(
                                  //   border: Border.all(
                                  //     color: Color(0xFFFEEAE6),
                                  //     width: 2.0,
                                  //   ),
                                  //   color: transaction['TransactionType'] == 'credit' ? Colors.green : Colors.red,
                                  // ),
                                  child: Icon(
                                    Icons.account_balance_wallet_outlined,
                                    size: 40,
                                    color: transaction['TransactionType'] == 'credit' ? Colors.green : Colors.red,
                                  ),

                                ),
                                SizedBox(height: 5,),
                                Text('${formatTimeAgo(transaction['Time'].toDate())}',style:const TextStyle(color:Color(0xFFFEEAE6),fontSize: 12.5,fontWeight: FontWeight.w700))

                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                height: 30,
                                width: 165,
                                child: FutureBuilder<String?>(

                                  future: getUsernameFromUserId(transaction['ClientID']),
                                  builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(child: Text('Loading...'));
                                    } else if (snapshot.hasError) {
                                      return Center(child: Text('Error: ${snapshot.error}'));
                                    } else {
                                      String? username = snapshot.data;
                                      return Center(child: Text(username ?? 'Unknown User',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Color(0xFFFEEAE6)),));
                                    }
                                  },
                                ),),
                            ),
                          ],
                        ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('₹${transaction['Amount']}',style: const TextStyle(fontSize: 28,fontWeight: FontWeight.w400,color: Color(0xFFFEEAE6),),),
                  ),
                  //Text('Transaction Type: ${transaction['TransactionType']}'),

                  //Text('${formatTimeAgo(transaction['Time'].toDate())}',style:const TextStyle(color:Colors.black26,fontSize: 14.5,fontWeight: FontWeight.w700))


                ],
              ),


                ],

                ),










                ),

              ),
            );

          },
        );
      },
    );
  }
}
