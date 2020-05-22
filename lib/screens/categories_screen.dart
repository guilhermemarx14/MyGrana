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

//todo refatorar a página
class _CategoriesScreenState extends State<CategoriesScreen> {
  bool _loading;
  double _progressValue;
  Orcamento orcamento;
  List<Transacao> transacoes = [];
  @override
  void initState() {
    _loading = false;
    _progressValue = 0.0;
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
      if (transacao.category == kSalario || transacao.category == kPensao)
        real[transacao.category] += transacao.value;
      else
        real[transacao.category] -= transacao.value;
    });
    double gasto = 100.0;
    double ganho = 50.0;
    double percent = gasto / ganho;
    return Scaffold(
      body: CategoryItem(category: 'Alimentaçao', real: 3000, planejado: 5000),
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
