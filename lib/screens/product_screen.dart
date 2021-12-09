import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';


class ProductScreen extends StatefulWidget{

  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(this.product);

}

class _ProductScreenState extends State<ProductScreen>{

  final ProductData product;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product.title),
      ),
    );
  }

}