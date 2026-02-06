import 'package:expenses_app/components/chart_bar.dart';
import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  //Declaração da lista que será utilizada no componente
  final List<Transaction> recentTransaction;

  //Recebendo a lista que com datas nos últimos 7 dias:
  Chart(this.recentTransaction){
    //print("Método construtor de Chart");
  }


  //Getter que vai retornar a soma total de todas as transações nos últimos 7 dias
  double get totalSemana {
    double sum = 0;
    recentTransaction.forEach((rct) {
      sum += rct.value as double;
    });
    return sum;
  }

  //Gerando um Map, com o dia da semana e o valor total gasto naquele dia
  List<Map<String, Object>> get groupedTransaction {
    //Utilizando o generete, que vai rodar 7 vezes, um para cada dia da semana, toda vez que ele é incrementado, ele representa um dia anterior ao dia que estava antes
    return List.generate(7, (index) {
      //Fazendo a subtração com base no index
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double sumTotal = 0;

      //Para cada transação, vou verificar se ela se encaixa nessa exata data do week.day
      for (int i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        //Se for exatamente o mesmo dia, pega o valor da transação e soma
        if (sameDay && sameMonth && sameYear) {
          sumTotal += recentTransaction[i].value as double;
        }
      }
      // recentTransaction.map((rctransac) {
      //   bool sameDay = rctransac.date.day == weekDay.day;
      //   bool sameMonth = rctransac.date.month == weekDay.month;
      //   bool sameYear = rctransac.date.year == weekDay.year;
      //   if (sameYear && sameMonth && sameDay) {
      //     sumTotal += rctransac.value as double;
      //   }
      // });

      //Aqui retorna o dia, com base no index do generate, e a soma do valor das transações nesse dia
      return {'day': DateFormat.E().format(weekDay), 'value': sumTotal};

      //Invertemos a lista para ficar com uma melhor vizualização no aplicativo
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    //print("build() Chart");
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          //Percorrendo os dias da semana dentro de groupedTransaction:
          children: groupedTransaction.map((tr) {
            //Flexible, para se "Encaixar melhor"
            return Flexible(
              fit: FlexFit.tight,
              //Chamando o ChartBar e passando seus parâmtros
              child: ChartBar(
                totalSemana,
                tr['value'] as double,
                tr['day'].toString(),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
