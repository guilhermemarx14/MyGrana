import 'package:flutter/material.dart';
import 'package:flutter_app/components/category_item.dart';
import 'package:flutter_app/model/orcamento.dart';
import 'package:flutter_app/model/transacao.dart';
import 'package:flutter_app/util/Database2.dart';
import 'package:flutter_app/util/constants.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Orcamento orcamento;
  List<Transacao> transacoes = [];
  @override
  void initState() {
    DBProvider2.db.getOrcamento().then((item) {
      setState(() {
        orcamento = item;
      });
    });

    DBProvider2.db
        .consultaTransacao(TODOS, DateTime.now().month.toString(),
            DateTime.now().year.toString())
        .then((list) {
      setState(() {
        list.forEach((element) => transacoes.add(element));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<int> planejado, real;
    if (orcamento != null) planejado = orcamento.getBudget();
    real = [];
    if (planejado != null)
      for (int i = 0; i < planejado.length; i++) real.add(0);
    transacoes.forEach((transacao) {
      if (transacao.category == kSalario ||
          transacao.category == kPensao ||
          transacao.category == kBolsaAuxilio)
        real[transacao.category] += transacao.value;
      else
        real[transacao.category] -= transacao.value;
    });

    List<Widget> cardsGanhos = [];
    List<Widget> cardsGastos = [];
    for (int i = 0; i < real.length; i++) {
      if (i == kSalario || i == kPensao || i == kBolsaAuxilio)
        cardsGanhos.add(
          CategoryItem(
            category: kListaCategorias[i],
            real: real[i].toDouble(),
            planejado: planejado[i].toDouble(),
          ),
        );
      else
        cardsGastos.add(
          CategoryItem(
            category: kListaCategorias[i],
            real: real[i].toDouble(),
            planejado: (planejado[i] != 0) ? -planejado[i].toDouble() : 0.0,
          ),
        );
    }

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Categorias',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              'Ganhos',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: cardsGanhos,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Gastos',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: cardsGastos,
            )
          ],
        ),
      ),
    );
    /*return Scaffold(
      backgroundColor: Colors.blue.shade700,
      appBar: AppBar(
        title: Text(
          'Categorias',
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(8.0),
        itemCount: real.length + 1,
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: kWhite,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'CATEGORIA',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'REAL',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        FontAwesomeIcons.angleDoubleRight,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ),
                    Container(
                      width: 120,
                      child: Text(
                        'PLANEJADO',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                    )
                  ],
                )
              ],
            );
          }

          return ListCategory(
              category: index - 1,
              planejado: planejado[index - 1],
              real: real[index - 1]);
        },
      ),
    );*/
  }
}
