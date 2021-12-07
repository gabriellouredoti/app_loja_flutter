import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context){

    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // ignore: prefer_const_constructors
            Color.fromARGB(255, 211, 118, 130),
            Color.fromARGB(255, 253, 101, 168)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      ),
    );
  
    return Stack(
      children: [
        _buildBodyBack()
      ],
    );
  }
}