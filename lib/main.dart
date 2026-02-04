import 'package:expenses_app/components/chart.dart';
import 'package:expenses_app/components/transaction_form.dart';
import 'package:expenses_app/components/transaction_list.dart';
import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Método main que roda a aplicação
main() {
  runApp(ExpensesApp());
}

//Classe inicial para exibir a HomePage da aplicação
class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Trava a rotação do celular e deixa somente no modo vertical
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      home: MyHomeApp(),
      //Temas gerais (styles) para minha aplicação:
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
    //colorScheme: ColorScheme(brightness: brightness, primary: primary, onPrimary: onPrimary, secondary: secondary, onSecondary:onSecondary, error: error, onError: onError, surface: surface, onSurface: onSurface)
  }
}

//Classe responsável por exibir a estrutura da home page State
class MyHomeApp extends StatefulWidget {
  @override
  State<MyHomeApp> createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  //Minha lista principal de transações:
  List<Transaction> transactions = [];

  //Getter que retornas as transações de até 7 dias atras:
  List<Transaction> get _recentTransaction {
    return transactions.where((transac) {
      return transac.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  //Função para adicionar uma nova transação na lista, usando o setState
  void addTransaction(Transaction transaction) {
    setState(() {
      transactions.add(transaction);
    });

    //Após adicionar, remove o modal da tela:
    Navigator.of(context).pop();
  }

  //Função para remover uma transação da lista
  void _removeTransaction(Transaction transa) {
    setState(() {
      transactions.remove(transa);
    });
  }

  //Função para abrir o modal de formulário:
  void _openTransactionFormModal(BuildContext context) {
    //Função própria para a abertura de formulário:
    showModalBottomSheet(
      context: context,
      builder: (_) {
        //Aqui retornamos o componentes que estará no modal, com seus respectivos parâmetros
        return TransactionForm(addTransaction, transactions.length);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        "Despesas pessoais",
        style: TextStyle(
          //Tamanho da fonte de acordor com as configurações do sistema (acessibilidade)
          //fontSize: 20 * MediaQuery.of(context).textScaleFactor
          //color: Colors.white,
          //fontFamily: "OpenSans"
        ),
      ),
      //Action com botão abrir o modal
      actions: [
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: Icon(Icons.add),
        ),
      ],
      backgroundColor: Theme.of(context).primaryColor,
    );

    final avaliableHeight =
        MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      //Barra inical do aplicativo
      appBar: appBar,

      //Widget SingleChildScrollView, deixa o componente rolável(O componente pai precisa ter um tamanho definido)
      body: SingleChildScrollView(
        child: Column(
          //Atributos para modificar alinhamento nos eixos horizontal e vertical, com base nas regras de flexbox
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Gráfico que recebe a lista de transações dos últimos 7 dias:
            Container(
              height: avaliableHeight * 0.22,
              child: Chart(_recentTransaction),
            ),

            //Componente que exibi todas as transações feitas:
            Container(
              height: avaliableHeight * 0.68,
              child: TransactionList(transactions, _removeTransaction),
            ),
          ],
        ),
      ),
      //Atributo do Scaffold para adicionar um botão no fim da tela
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        //Executando a função que chama a função de abrir o formulário:
        onPressed: () => _openTransactionFormModal(context),
      ),
      //Atributo do Scaffold para definir a posição do botão na tela
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
