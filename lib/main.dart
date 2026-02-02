import 'package:expenses_app/components/transaction_user.dart';
import 'package:flutter/material.dart';

//Método main que roda a aplicação
main() {
  runApp(ExpensesApp());
}

//Classe inicial para exibir a HomePage da aplicação
class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomeApp());
  }
}

//Classe responsável por exibir a estrutura da home page
class MyHomeApp extends StatelessWidget {
  //Criando uma lista simples do objeto transactions para usar como exemplo
  

  final List<String> months = [
    'Jan',
    'Fev',
    'Mar',
    'Abr',
    'Mai',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Out',
    'Nov',
    'Dez',
  ];

  //Método que constroi o widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Barra inical do aplicativo
      appBar: AppBar(title: Text("Despesas pessoais")),
      body: Column(
        //Atributos para modificar alinhamento nos eixos horizontal e vertical, com base nas regras de flexbox
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            child: Card(color: Colors.blue, child: Text("Grafico")),
          ),
          TransactionUser()
        ],
      ),
    );
  }
}
