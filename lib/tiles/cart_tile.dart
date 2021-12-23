
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CartTile extends StatelessWidget {

  CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context){

    Widget _buildContent(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            width: 100.0,
            height: 120.0,
            child: Image.network(
              cartProduct.productData!.images[0],
              fit: BoxFit.cover,  
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(cartProduct.productData!.title, 
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),),
                  Text("Tamanho: ${cartProduct.size}", 
                    style: TextStyle(fontWeight: FontWeight.w300),),
                  Text("R\$ ${cartProduct.productData!.price.toStringAsFixed(2)}", 
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: cartProduct.quantity > 1 ? (){} : null, 
                        icon: Icon(Icons.remove),
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(cartProduct.quantity.toString()),
                      IconButton(
                        onPressed: (){}, 
                        icon: Icon(Icons.add),
                        color: Theme.of(context).primaryColor
                      ),
                      TextButton(
                        onPressed: (){}, 
                        child: Text("Remover")
                      )
                    ],
                  )
                ],
              ),
            ) 
          )
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: cartProduct.productData == null 
      ?
      FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection("products").doc(cartProduct.category)
          .collection("items").doc(cartProduct.pid).get(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            cartProduct.productData = ProductData.fromDocument(snapshot.data!);
            return _buildContent();
          } else {
            return Container(
              height: 70.0,
              child: CircularProgressIndicator(),
              alignment: Alignment.center,
            );
          }
        }
      )
      : 
      _buildContent(),
    );
  }


}