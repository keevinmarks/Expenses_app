import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  DateTime _selectDate = DateTime.now();

  void sendTransactionLocal() {
    final String title = titleController.text;
    final double value = double.tryParse(valueController.text) ?? 0;
    if (titleController.text.isEmpty || value <= 0 || _selectDate == null) {
      return;
    }

    Transaction transac = Transaction(
      id: widget.length + 1,
      title: title,
      date: _selectDate,
      value: value,
    );
    //Propriedade widget: através dessa propriedade é possível acessar as proprieades do componente StatefulWidget, do qual essa classe foi herdada
    widget.sendTransaction(transac);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(3000),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10 + MediaQuery.of(context).viewInsets.right,
            left: 10 + MediaQuery.of(context).viewInsets.left,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom
          ),
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectDate == null
                            ? "Nenhuma data selecionada"
                            : DateFormat("dd/MM/y").format(_selectDate),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _showDatePicker,
                      child: Text(
                        "Selecionar data",
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: sendTransactionLocal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: Text(
                  "Nova transação",
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
