
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {

  late String id;
  // String category;

  late String description;
  late String title;

  late double price;

  late List images;
  late List sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.id;
    description = snapshot["description"];
    title = snapshot["title"];
    price = snapshot["price"] + 0.0;
    // category = snapshot["category"];
    images = snapshot["images"];
    sizes = snapshot["sizes"];
  }

}