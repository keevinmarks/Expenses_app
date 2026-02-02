import 'package:expenses_app/components/transaction_form.dart';
import 'package:expenses_app/components/transaction_list.dart';
import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';

//Método main que roda a aplicação
main() {
  runApp(ExpensesApp());
}

//Classe inicial para exibir a HomePage da aplicação
class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomeApp(),
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 18,
            fontWeight: FontWeight.bold
          )
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        ),
      ),
    );
    //colorScheme: ColorScheme(brightness: brightness, primary: primary, onPrimary: onPrimary, secondary: secondary, onSecondary:onSecondary, error: error, onError: onError, surface: surface, onSurface: onSurface)
  }
}

//Classe responsável por exibir a estrutura da home page
class MyHomeApp extends StatefulWidget {
  @override
  State<MyHomeApp> createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  List<Transaction> transactions = [
    Transaction(
      id: 1,
      title: "Nova placa de vídeo",
      date: DateTime.now(),
      value: 1400.0,
    ),
    Transaction(id: 2, title: "Novo sapato", date: DateTime.now(), value: 80.0),
  ];

  void addTransaction(Transaction transaction) {
    setState(() {
      transactions.add(transaction);
    });

    Navigator.of(context).pop();
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(addTransaction, transactions.length);
      },
    );
  }

  //Criando uma lista simples do objeto transactions para usar como exemplo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Barra inical do aplicativo
      appBar: AppBar(
        title: Text(
          "Despesas pessoais",
          style: TextStyle(
            //color: Colors.white,
            //fontFamily: "OpenSans"
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: Icon(Icons.add),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),

      //Widget SingleChildScrollView, deixa o componente rolável(O componente pai precisa ter um tamanho definido)
      body: SingleChildScrollView(
        child: Column(
          //Atributos para modificar alinhamento nos eixos horizontal e vertical, com base nas regras de flexbox
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: Card(color: Colors.blue, child: Text("Grafico")),
            ),
            TransactionList(transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
