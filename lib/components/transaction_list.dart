import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  //Declaração das variáveis que serão utilizadas no componentes e que serão recebidas via construtor (instanciação)
  final List<Transaction> transactions;
  final void Function(Transaction) removeTransaction;

  //Recebendo a lista de transações e a função que remove uma transação da lista
  TransactionList(this.transactions, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        //Se estiver com conteúdo, então vou exibir uma imagem
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Container(
                child: Column(
                  children: [
                    //Widget para dá um afastamento entre os componentes
                    SizedBox(height: constraints.maxHeight * 0.05),
                    Container(
                      height: constraints.maxHeight * 0.22,
                      child: Text(
                        "Nenhuma transação cadastrada!",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    //Envolvendo a o componente Image em um Container para pode usar a propriedade fit:
                    Container(
                      height: constraints.maxHeight * 0.68,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        //Senão, vou usar o ListViem.builder para exibir somente o que for aparecer na tela
        : ListView.builder(
            //Ele precisa do tamnho da lista
            itemCount: transactions.length,
            //A função que é passada para o itemBuilder precisa do contexto e o index
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(child: Text("R\$${tr.value}")),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                  trailing: MediaQuery.of(context).size.width > 600
                      ? ElevatedButton(
                          onPressed: () => removeTransaction(tr),
                          child: Text("Remover item"),
                        )
                      : IconButton(
                          onPressed: () => removeTransaction(tr),
                          icon: Icon(Icons.delete),
                        ),
                ),
              );
            },
          );
  }
}
