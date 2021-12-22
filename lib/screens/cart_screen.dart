import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:loja_virtual/models/cart_model.dart';


class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState(); 
}

class _CartScreenState extends State<CartScreen> {
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        actions: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8.0),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model){

                int p = model.products.length;

                return Text("${p} ${p == 1 ? "ITEM" : "ITENS"}");

              },
            ),
          )
        ],
      ),
    );  
  }
}