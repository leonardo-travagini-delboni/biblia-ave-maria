import 'package:biblia/config.dart';
import 'package:biblia/components.dart';
import 'package:biblia/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BibliaScreen extends StatefulWidget {
  const BibliaScreen({super.key});

  @override
  State<BibliaScreen> createState() => _BibliaScreenState();
}

class _BibliaScreenState extends State<BibliaScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    BibliaProvider bibliaProvider = Provider.of<BibliaProvider>(context);
    String testamento = bibliaProvider.testamento;
    List<String> livros = bibliaProvider.livrosDisponiveis;
    String book = bibliaProvider.book;
    String chapter = bibliaProvider.chapter;
    List<Map<String, dynamic>> versiculos = bibliaProvider
        .versiculosDisponiveis(testamento, book, chapter);
    String title = 'Bíblia Sagrada';
    Widget body = Placeholder();
    dp('Biblia Screen - Test: $testamento, Book: $book, Chapter: $chapter');

    // ESCOLHA DO TESTAMENTO
    if (testamento.isEmpty) {
      title = 'Bíblia Sagrada Ave Maria';
      body = Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/nsa.png',
                fit: BoxFit.contain,
                width: 300,
                height: 300,
              ),
              SizedBox(height: 20),
              Text(
                'Qual o testamento?',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      dp('Bíblia: Antigo Testamento tapped');
                      bibliaProvider.setTestamento('antigoTestamento');
                    },
                    icon: Icon(Icons.book),
                    label: Text('ANTIGO'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      dp('Bíblia: Novo Testamento tapped');
                      bibliaProvider.setTestamento('novoTestamento');
                    },
                    icon: Icon(Icons.book),
                    label: Text('NOVO'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    }
    // ESCOLHA DO LIVRO
    else if (book.isEmpty) {
      title = bibliaProvider.nomeAmigavelTestamento(testamento);
      body = Container(
        width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'assets/nsa.png',
                  fit: BoxFit.contain,
                  width: 300,
                  height: 300,
                ),
                SizedBox(height: 20),
                Text(
                  'Qual livro você deseja?',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: livros
                      .map(
                        (l) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 350,
                              child: ListTile(
                                title: Text(l),
                                leading: Icon(Icons.book),
                                onTap: () {
                                  dp('Bíblia: Livro $l tapped');
                                  bibliaProvider.setBook(l);
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      dp('Bíblia: Voltar to testamento selection');
                      bibliaProvider.clearAll();
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text('Voltar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    // ESCOLHA DO CAPÍTULO
    else if (chapter.isEmpty) {
      title = book;
      body = Container(
        width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'assets/nsa.png',
                  fit: BoxFit.contain,
                  width: 300,
                  height: 300,
                ),
                SizedBox(height: 20),
                Text(
                  'Qual capítulo de $book?',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20),
                Column(
                  children: bibliaProvider.capitulosDisponiveisString
                      .map(
                        (c) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 350,
                              child: ListTile(
                                title: Text('Capítulo $c'),
                                leading: Icon(Icons.book),
                                onTap: () {
                                  dp('Bíblia: Capítulo $c tapped');
                                  bibliaProvider.setChapter(c);
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      bibliaProvider.setBook('');
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text('Voltar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    // EXIBIÇÃO DO CAPÍTULO ESCOLHIDO
    else {
      title = '$book - Cap. $chapter';
      body = Container(
        width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'assets/nsa.png',
                  fit: BoxFit.contain,
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 20),
                for (var v in versiculos)
                  ListTile(
                    title: Text('${v['versiculo']}. ${v['texto']}'),
                    leading: Icon(Icons.book),
                  ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      bibliaProvider.setChapter('');
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text('Voltar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Estrutura da tela
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, title: title),
      body: body,
      bottomNavigationBar: footer(context),
    );
  }
}
