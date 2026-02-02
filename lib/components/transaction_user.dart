import 'package:expenses_app/components/transaction_form.dart';
import 'package:expenses_app/components/transaction_list.dart';
import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/widgets.dart';

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  List<Transaction> transactions = [
    Transaction(
      id: "t1",
      title: "Nova placa de vídeo",
      date: DateTime.now(),
      value: 1400.0,
    ),
    Transaction(
      id: "t2",
      title: "Novo sapato",
      date: DateTime.now(),
      value: 80.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        TransactionList(transactions),
        TransactionForm()
      ],
    );
  }
}
