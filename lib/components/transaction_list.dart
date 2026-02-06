import 'package:expenses_app/components/transaction_item.dart';
import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';


class TransactionList extends StatelessWidget {
  //Declaração das variáveis que serão utilizadas no componentes e que serão recebidas via construtor (instanciação)
  final List<Transaction> transactions;
  final void Function(Transaction) removeTransaction;

  //Recebendo a lista de transações e a função que remove uma transação da lista
  TransactionList(this.transactions, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    //print("build() TransactionList");
    return transactions.isEmpty
        //Se estiver com conteúdo, então vou exibir uma imagem
        ? Column(
            children: [
              //Widget para dá um afastamento entre os componentes
              SizedBox(height: 20),
              Text(
                "Nenhuma transação cadastrada!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 20),
              //Envolvendo a o componente Image em um Container para pode usar a propriedade fit:
              Container(
                height: 400,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        //Senão, vou usar o ListViem.builder para exibir somente o que for aparecer na tela
        : ListView.builder(
            //Ele precisa do tamnho da lista
            itemCount: transactions.length,
            //A função que é passada para o itemBuilder precisa do contexto e o index
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return TransactionItem(transaction: tr, removeTransaction: removeTransaction,);
            },
          );
  }
}
