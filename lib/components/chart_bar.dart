import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double totalSemana;
  final double dayValue;
  final String dayText;

  ChartBar(this.totalSemana, this.dayValue, this.dayText);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            //FittedBox, diminui o tamanho do conteúdo para caber
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text("${dayValue.toStringAsFixed(2)}")),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              alignment: Alignment.bottomCenter,
              width: 10,
              height: constraints.maxHeight * 0.6,
              //O Componente Stack permite colocar um componente em cima do outro
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: totalSemana != 0 ? dayValue / totalSemana : 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(dayText))),
          ],
        );
      },
    );
  }
}
