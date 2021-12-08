import 'package:flutter/material.dart';

//componentes criados
import 'package:loja_virtual/tabs/home_tab.dart';
import 'package:loja_virtual/widgets/custom_drawer.dart';
import 'package:loja_virtual/tabs/produtcs_tab.dart';
class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController)
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
        ),
        Container(color: Colors.purple,),
        Container(color: Colors.blue,),
      ],
    );
  }
}