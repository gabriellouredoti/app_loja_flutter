import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle:  true,
        actions: [
          TextButton(
            onPressed: (){}, 
            child: Text(
              "CRIAR CONTA",
              style: TextStyle(fontSize: 15.0,),
            ),
            style: TextButton.styleFrom(primary: Colors.white)
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "E-mail"
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (text){
                if(text!.isEmpty || !text.contains("@")) return "E-mail inválido";
              },
            ),
            SizedBox(height: 16.0,),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Senha"
              ),
              obscureText: true,
              validator: (text){
                if(text!.isEmpty || text.length < 6) return "Senha inválida";
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){},
                child: Text("Esqueci minha senha", textAlign: TextAlign.right,),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
              ),
            ),
            SizedBox(height: 16.0,),
            //uso para deixar o botão mais alto
            SizedBox(
              height: 44.0,
              child: ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    
                  }
                }, 
                child: Text("Entrar",
                  style: TextStyle(fontSize: 18.0,),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}