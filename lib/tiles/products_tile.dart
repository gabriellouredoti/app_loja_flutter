import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  ProductsTile(this.snapshot);

  @override
  Widget build(BuildContext context){
    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot["icon"]),
      ),
      title: Text(snapshot["title"]),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){

      }
    );
  }
}