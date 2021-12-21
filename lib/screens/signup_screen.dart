import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget{
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();


  final _nameController = TextEditingController();
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        // criando uma key para modificar propriedades do scaffold
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle:  true,
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
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Nome Completo"
                    ),
                    validator: (text){
                      if(text!.isEmpty || text.length < 6) return "Nome inválido";
                    },
                  ),
                  SizedBox(height: 16.0,),
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
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      hintText: "Endereço"
                    ),
                    validator: (text){
                      if(text!.isEmpty) return "Endereço inválido";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  //uso para deixar o botão mais alto
                  SizedBox(
                    height: 44.0,
                    child: ElevatedButton(
                      onPressed: (){

                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _mailController.text,
                          "address": _addressController.text
                        };

                        if(_formKey.currentState!.validate()){
                          model.signUp(
                            userData: userData, 
                            pass: _passwordController.text, 
                            onSuccess: _onSucess, 
                            onFail: _onFail
                          );
                        }
                      }, 
                      child: Text("Criar Conta",
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
        )
      )
    );
  }

  void _onSucess(){
    _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text("Usuário criado com sucesso!"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 9),
      )
    );
    Future.delayed(Duration(seconds: 2)).then((_) => Navigator.of(context).pop());
  }

  void _onFail(){
    print("======>fail");
    _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text("Falha ao criar o usuário!"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 9),
      ),
    );
  }


}