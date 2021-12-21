import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context){
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle:  true,
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignUpScreen())
                );
              }, 
              child: Text(
                "CRIAR CONTA",
                style: TextStyle(fontSize: 15.0,),
              ),
              style: TextButton.styleFrom(primary: Colors.white)
            )
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){

            if(model.isLoading)
              return Center(child: CircularProgressIndicator(),);

            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _mailController,
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
                    controller: _passwordController,
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
                        model.signIn(
                          email: _mailController.text,
                          password: _passwordController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail,
                        );
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
            );
          },
        ),
      ),
    );
  }

  void _onSuccess(){
    Navigator.of(context).pop();
  }

  void _onFail(){
    _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text("Falha ao realizar login"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 9),
      ),
    );
  }

}