import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TransactionItem extends StatelessWidget{
  final Transaction transaction;
  final Function(Transaction) removeTransaction;

  TransactionItem({required this.transaction, required this.removeTransaction});

  @override
  Widget build(BuildContext context){
    return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(child: Text("R\$${transaction.value}")),
                    ),
                  ),
                  title: Text(
                    transaction.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(DateFormat('d MMM y').format(transaction.date)),
                  trailing: IconButton(
                    onPressed: () => removeTransaction(transaction),
                    icon: Icon(Icons.delete),
                  ),
                ),
              );
  }
}