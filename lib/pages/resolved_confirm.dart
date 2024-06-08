import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/auth/database_helpher.dart';
import 'package:demo/utils/routes.dart';
import 'package:firebase_database/firebase_database.dart';

void deleteCardData(String caseId) {
  final databaseReference = FirebaseDatabase.instance.reference();
  databaseReference.child('uniqueId').child(caseId).remove();
}
class Verify extends StatelessWidget {
  final Function(String caseId) onCardResolved;
  final String caseId;
  final String animalName;
  final String severity;
  final String location;

  Verify({
    Key? key,
    required this.onCardResolved,
    required this.caseId,
    required this.animalName,
    required this.location,
    required this.severity,
  }) : super(key: key);

  void _handleResolved(BuildContext context) async {
  deleteCardData(caseId); // Delete the card from the database
  onCardResolved(caseId); // Notify the parent widget to update the card list
  Navigator.pushNamed(context, MyRoutes.homeRoute); // Navigate back to the homepage
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Case'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Verify Case ID: $caseId',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Animal Name: $animalName'),
            Text('Location: $location'),
            Text('Severity: $severity'),
            ElevatedButton(
              onPressed: () => _handleResolved(context),
              child: Text('Resolved'),
            ),
          ],
        ),
      ),
    );
  }
}
