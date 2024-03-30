
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



String? user = FirebaseAuth.instance.currentUser?.uid;




// Function to add wallet data

Future<void> addWalletData(String userID, int amount, List<Map<String, dynamic>> transactions) async {
  try {
    await FirebaseFirestore.instance.collection('Wallet').doc(userID).set({
      'UserID': userID,
      'Amount': amount,
      'Transactions': transactions,
    });
    print('Wallet data created successfully!');
  } catch (e) {
    print('Error creating wallet data: $e');
  }
}

// Function to add transaction data to a specific wallet


Future<void> addTransactionBetweenWallets( String receiverID, int amount) async {
  try {

    // Get sender's wallet data
    DocumentSnapshot senderSnapshot = await FirebaseFirestore.instance.collection('Wallet').doc(user).get();
    Map<String, dynamic> senderData = senderSnapshot.data() as Map<String, dynamic>;

    // Get receiver's wallet data
    DocumentSnapshot receiverSnapshot = await FirebaseFirestore.instance.collection('Wallet').doc(receiverID).get();
    Map<String, dynamic> receiverData = receiverSnapshot.data() as Map<String, dynamic>;

    // Check if sender has sufficient balance
    int senderBalance = senderData['Amount'];
    if (senderBalance < amount) {
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error!',
          message: 'Please select a user and enter an amount.',
          contentType: ContentType.warning,
        ),
      );
      // Snackbar().red(context as BuildContext,'Sender does not have sufficient balance.');

      return;
    }

    // Update sender's wallet - debit amount
    await FirebaseFirestore.instance.collection('Wallet').doc(user).update({
      'Amount': senderBalance - amount,
      'Transactions': FieldValue.arrayUnion([
        {
          'TransactionType': 'debit',
          'Amount': amount,
          'Time': DateTime.now(),
          'ClientID': receiverID,
        }
      ]),
    });
    // Update receiver's wallet - credit amount
    await FirebaseFirestore.instance.collection('Wallet').doc(receiverID).update({
      'Amount': receiverData['Amount'] + amount,
      'Transactions': FieldValue.arrayUnion([
        {
          'TransactionType': 'credit',
          'Amount': amount,
          'Time': DateTime.now(),
          'ClientID': user,
        }
      ]),
    });
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Successssss!',
        message: 'Transaction successful.',
        contentType: ContentType.success,
      ),
    );
    // Snackbar().green(context as BuildContext, 'Transaction completed successfully!');
    print('Transaction completed successfully!');
    print('Transaction completed successfully!');

    print('Transaction completed successfully!');

  } catch (e) {
    print('Error completing transaction: $e');
  }
}

Future<void> initializeWalletsForAllUsers() async {
  try {
    // Retrieve all users from the "Users" collection
    QuerySnapshot usersSnapshot = await FirebaseFirestore.instance.collection('Users').get();

    // Loop through each user and initialize their wallet if it doesn't exist
    for (QueryDocumentSnapshot userSnapshot in usersSnapshot.docs) {
      String userID = userSnapshot.id;
      await checkAndInitializeWallet(userID);
    }

    print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized'); print('initialized');



  } catch (e) {
    print('Error initializing wallets for all users: $e');
  }
}

Future<void> checkAndInitializeWallet(String userID) async {
  try {
    // Check if the user's wallet exists
    DocumentSnapshot walletSnapshot = await FirebaseFirestore.instance.collection('Wallet').doc(userID).get();
    if (!walletSnapshot.exists) {

      // If wallet doesn't exist, initialize it
      await initializeWallet(userID);
    } else {
      print('User already has a wallet.');
    }
  } catch (e) {
    print('Error checking wallet: $e');
  }
}
// Example usage:
Future<void> initializeWallet(String userID) async {
  await addWalletData(
    userID,
    0,
    [],
  );
}
Future<String?> getUserIdFromUsername(String username) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users').where('UserName', isEqualTo: username).get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    } else {
      return null;
    }
  } catch (e) {
    print('Error fetching user ID: $e');
    return null;
  }
}
String formatTimeAgo(DateTime transactionTime) {
  Duration difference = DateTime.now().difference(transactionTime);
  if (difference.inDays >= 365) {
    int years = (difference.inDays / 365).floor();
    return '$years ${years == 1 ? 'year' : 'years'} ago';
  } else if (difference.inDays >= 30) {
    int months = (difference.inDays / 30).floor();
    return '$months ${months == 1 ? 'month' : 'months'} ago';
  } else if (difference.inDays >= 7) {
    int weeks = (difference.inDays / 7).floor();
    return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
  } else if (difference.inDays >= 1) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
  } else if (difference.inHours >= 1) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
  } else if (difference.inMinutes >= 1) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
  } else {
    return 'Just now';
  }
}
Future<String?> getUsernameFromUserId(String userId) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users').where(FieldPath.documentId, isEqualTo: userId).get();
    if (querySnapshot.docs.isNotEmpty) {
      Map<String, dynamic>? userData = querySnapshot.docs.first.data() as Map<String, dynamic>?;
      if (userData != null && userData.containsKey('UserName')) {
        return userData['UserName'];
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    print('Error fetching username: $e');
    return null;
  }
}