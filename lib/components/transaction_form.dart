import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final int length;

  final void Function(Transaction) sendTransaction;

  TransactionForm(this.sendTransaction, this.length);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  void sendTransactionLocal() {
    final String title = titleController.text;
    final double value = double.tryParse(valueController.text) ?? 0;
    if (titleController.text.isEmpty || value <= 0) {return;}

    Transaction transac = Transaction(
      id: widget.length + 1,
      title: title,
      date: DateTime.now(),
      value: value,
    );
    //Propriedade widget: através dessa propriedade é possível acessar as proprieades do componente StatefulWidget, do qual essa classe foi herdada
    widget.sendTransaction(transac);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Column(
          children: [
            TextField(
              //onChanged: (newValue) => value = newValue,
              controller: titleController,
              decoration: InputDecoration(labelText: "Título"),

              //onSubmitted, quando o "enter" do teclado é pressionado
              onSubmitted: (_) => sendTransactionLocal(),
            ),
            TextField(
              //onChanged: (newValue) => title = newValue,
              controller: valueController,
              decoration: InputDecoration(labelText: "Valor R\$"),
              keyboardType: TextInputType.numberWithOptions(),
              onSubmitted: (_) => sendTransactionLocal(),
            ),
            ElevatedButton(
              onPressed: sendTransactionLocal,
              child: Text(
                "Nova transação",
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
