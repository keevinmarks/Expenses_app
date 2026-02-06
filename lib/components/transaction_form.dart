import 'package:expenses_app/components/adaptative_button.dart';
import 'package:expenses_app/components/adaptative_data_picker.dart';
import 'package:expenses_app/components/adaptative_text_field.dart';
import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final int length;

  final void Function(Transaction) sendTransaction;

  TransactionForm(this.sendTransaction, this.length) {
    print("Constructor TransactionForm");
  }

  @override
  State<TransactionForm> createState() {
    print("createState TransactionForm");
    return _TransactionFormState();
  }
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime _selectDate = DateTime.now();

  _TransactionFormState() {
    print("Constructor _TransactionFormState");
  }

  //Executado antes do build
  @override
  void initState(){
    print("initState() _TransactionFormState");
    super.initState();
  }

  //Quando uma alteração no widget é feita, passando o widget antigo
  @override
  void didUpdateWidget(TransactionForm oldWidget){
    print("didUpdateWidget() _TransactionFormState");
    super.didUpdateWidget(oldWidget);
  }

  //Quando um widget finaliza
  @override
  void dispose(){
    print("dispose() _TransactionFormState");
    super.dispose();
  }

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

  void onDateChanged(DateTime newDate) {
    setState(() {
      _selectDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build() _TransactionFormState");
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Column(
          children: [
            AdaptativeTextField(
              placeholder: "Titulo",
              controller: titleController,
              submitAction: (_) => sendTransactionLocal(),
            ),
            AdaptativeTextField(
              placeholder: "Valor R\$",
              controller: valueController,
              keyBoardType: TextInputType.numberWithOptions(),
              submitAction: (_) => sendTransactionLocal(),
            ),
            AdaptativeDataPicker(
              selectedDate: _selectDate,
              onDateChanged: onDateChanged,
            ),
            AdaptativeButton(
              label: "Nova transação",
              onPressed: sendTransactionLocal,
              textColor: Colors.amber,
              backGroundColor: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
