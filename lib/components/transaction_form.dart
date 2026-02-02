import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

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
            ),
            TextField(
              //onChanged: (newValue) => title = newValue,
              controller: valueController,
              decoration: InputDecoration(labelText: "Valor R\$"),
            ),
            ElevatedButton(
              onPressed: () {},
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
