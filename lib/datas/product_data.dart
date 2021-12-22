import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {

  late String id;
  late String category;

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
    images = snapshot["images"];
    sizes = snapshot["sizes"];
  }

  Map<String, dynamic> toResumeMap(){
    return {
      "title": title,
      "description": description,
      "price": price
    };
  }

}