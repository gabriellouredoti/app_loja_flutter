import 'package:flutter/material.dart';
import 'package:loja_virtual/tiles/cart_tile.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';


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
          ),
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model){
          if(model.isLoading && UserModel.of(context).isLoggedIn()){
            return Center(child: CircularProgressIndicator(),);
          }else if(!UserModel.of(context).isLoggedIn()){
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: 16.0,),
                  Text("Faça o login para adicionar produtos",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0,),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                    }, 
                    child: Text("Entrar", style: TextStyle(fontSize: 18.0),),
                  )
                ],
              ),
            );
          }else if(model.products == null || model.products.isEmpty){
            return Center(
              child: Text(
                "Nenhum produto adicionado ao carrinho", 
                style: TextStyle(fontSize: 20.0, 
                fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          }else{
            return ListView(
              children: [
                Column(
                  children: model.products.map(
                    (product){
                      return CartTile(product);
                    }
                  ).toList(),
                ),
              ],
            );
          }
        },
      ), 
    );  
  }
}