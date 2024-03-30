import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:police_app/Compo/ElevatedButton.dart';
import 'package:police_app/Pages/Wallet/Transactions.dart';
import 'package:police_app/Pages/Wallet/Wallet_Firebase.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  String? receiverID;
  int? amount;

  String? _selectedUser;
  List<String> _usersList = [];

  Future<void> _fetchUsersList() async {
    List<String> users = await getUsersList();
    setState(() {
      _usersList = users;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUsersList();
  }
  Future<void> _onConfirmTransaction() async {
    if (_selectedUser != null && amount != null) {
      // Convert selected username to user ID
      String? userID = await getUserIdFromUsername(_selectedUser!);
      if (userID != null) {
        await addTransactionBetweenWallets(userID, amount!);

        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Success!',
            message: 'Transaction successful.',
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error!',
            message: 'Failed to get user ID.',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } else {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error!',
          message: 'Please select a user and enter an amount.',
          contentType: ContentType.warning,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFD9C19D),
      appBar: AppBar(
        backgroundColor:Color(0xFFD9C19D),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF442B2D)), // Back icon
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        title: const Text('Make Transaction',style: TextStyle(color: Color(0xFF442B2D),fontSize: 20,fontWeight: FontWeight.w600),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: _selectedUser,
              borderRadius: BorderRadius.circular(20),
              elevation: 4,
              style: TextStyle(
                fontSize: 17
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedUser = newValue;
                  receiverID = null; // Set the receiver ID when dropdown value changes
                });
              },
              items: _usersList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Color(0xFF442B2D)), // Set text color to white
                  ),
                );
              }).toList(),
              hint: const Text('Select a user',style: TextStyle(color: Color(0xFF442B2D),fontSize: 20,fontWeight: FontWeight.w400),),
            ),
            const SizedBox(height: 20),
            // Text field to enter the amount
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter Amount',
                    labelStyle: TextStyle(color: Color(0xFF442B2D)), // Set label text color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xFF442B2D)), // Set border color
                    ),
                    prefixIcon: Icon(Icons.currency_rupee, color: Color(0xFF442B2D)), // Set icon color
                  ),
                  style: TextStyle(color: Color(0xFF442B2D),fontSize: 20), // Set input text color
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      amount = int.tryParse(value);
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 60),
            // ElevatedButton(
            //   onPressed: _onConfirmTransaction,
            //   style: ElevatedButton.styleFrom(
            //     padding: EdgeInsets.only(top: 15,bottom: 15,left: 30,right: 30),
            //     backgroundColor: Color(0xFF442B2D),
            //     shape: const BeveledRectangleBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(15.0)),
            //     ),
            //   ),
            //   child: const Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 60,vertical: 5),
            //     child:Text('Confirm Transaction',style: TextStyle(color: Color(0xFFFEEAE6),fontSize: 15),),
            //   ),
            // ),
            CustomElevatedButton(title: "Confirm Transaction", color1: Color(0xFFD9C19D), color2: Color(0xFF442B2D), onPressed: _onConfirmTransaction, padh: 40, padv: 15)
          ],
        ),
      ),
    );
  }
}
