import 'package:expenses_app/components/chart.dart';
import 'package:expenses_app/components/transaction_form.dart';
import 'package:expenses_app/components/transaction_list.dart';
import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

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

  final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
  final iconChart = Platform.isIOS ? CupertinoIcons.refresh : Icons.pie_chart;

  //Variável que vai controlar a exibição do gráfico:
  bool _showChart = false;

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
    //Verifica se a orientação da tela está em landscape (tela vertical)

    Widget _getIconButton(Function() fn, IconData icon) {
      return Platform.isIOS
          ? GestureDetector(onTap: fn, child: Icon(icon))
          : IconButton(onPressed: fn, icon: Icon(icon));
    }

    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Despesas pessoais"),
            trailing: Row(
              children: [
                _getIconButton(
                  () => _openTransactionFormModal(context),
                  Platform.isIOS ? CupertinoIcons.add : Icons.add,
                ),
                if (isLandscape)
                  _getIconButton(() {
                    setState(() {
                      _showChart = !_showChart;
                    });
                  }, _showChart ? iconChart : iconList),
              ],
            ),
          )
        : AppBar(
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
              _getIconButton(
                () => _openTransactionFormModal(context),
                Icons.add,
              ),
              if (isLandscape)
                _getIconButton(() {
                  setState(() {
                    _showChart = !_showChart;
                  });
                }, _showChart ? Icons.list : Icons.pie_chart),
            ],
            backgroundColor: Theme.of(context).primaryColor,
          );
    final avaliableHeight =
        mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          //Atributos para modificar alinhamento nos eixos horizontal e vertical, com base nas regras de flexbox
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //if (isLandscape)
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text("Exibir gráfico"),
            //     //.adaptive, estiliza o switch de acordo com a plataforma
            //     Switch.adaptive(
            //       value: _showChart,
            //       onChanged: (value) {
            //         setState(() {
            //           _showChart = value;
            //         });
            //       },
            //     ),
            //   ],
            // ),
            //Gráfico que recebe a lista de transações dos últimos 7 dias:
            _showChart
                ? Container(
                    height: isLandscape
                        ? avaliableHeight
                        : avaliableHeight * 0.22,
                    child: Chart(_recentTransaction),
                  )
                :
                  //if(!_showChart)
                  //Componente que exibi todas as transações feitas:
                  Container(
                    height: isLandscape
                        ? avaliableHeight
                        : avaliableHeight * 0.68,
                    child: TransactionList(transactions, _removeTransaction),
                  ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text("Despesas pessoias"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _getIconButton(
                    () => _openTransactionFormModal(context),
                    Icons.add,
                  ),
                  if (isLandscape)
                    _getIconButton(() {
                      setState(() {
                        _showChart = !_showChart;
                      });
                    }, _showChart ? Icons.list : Icons.pie_chart),
                ],
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            //Barra inical do aplicativo
            appBar: appBar,

            //Widget SingleChildScrollView, deixa o componente rolável(O componente pai precisa ter um tamanho definido)
            body: bodyPage,
            //Atributo do Scaffold para adicionar um botão no fim da tela
            floatingActionButton:
                Platform
                    .isIOS //Verificando se a plataforma é IOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    //Executando a função que chama a função de abrir o formulário:
                    onPressed: () => _openTransactionFormModal(context),
                  ),
            //Atributo do Scaffold para definir a posição do botão na tela
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
