import 'package:biblia/config.dart';
import 'package:biblia/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// HEADER
AppBar header(BuildContext context, {String title = ''}) {
  ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
  double screenHeight = MediaQuery.of(context).size.height;
  return AppBar(
    toolbarHeight: screenHeight * 0.08,
    title: FittedBox(
      fit: BoxFit.contain,
      child: Text(
        title,
        overflow: TextOverflow.visible,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    centerTitle: true,
    actions: [
      IconButton(
        icon: const Icon(Icons.color_lens),
        onPressed: () async {
          dp('Header: Theme switch button tapped');
          await themeProvider.switchTheme();
        },
      ),
      IconButton(
        icon: const Icon(Icons.info),
        onPressed: () async {
          dp('Header: Credits button tapped');
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                'Créditos',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bíblia Sagrada Ave Maria',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Versão: $appVersion', textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  Text('Lançamento: $releaseDate', textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  const Text(
                    'Sem direitos autorais reservados.',
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Domínio totalmente público.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  const Text(
                    'O Desenvolvedor',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text(
                      'Leonardo Delboni',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    dense: true,
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text(
                      'leonardodelboni@gmail.com',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    dense: true,
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text(
                      '+55 (11) 99442-1880',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    dense: true,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Fechar'),
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}

// FOOTER
Widget footer(BuildContext context, {String title = ''}) {
  int curYear = DateTime.now().year;
  double screenHeight = MediaQuery.of(context).size.height;
  if (title.isEmpty) {
    title =
        '© 2026 - $curYear Bíblia Sagrada Versão Ave Maria. By Leonardo Delboni';
  }
  return SafeArea(
    top: false,
    child: Container(
      height: screenHeight * 0.08,
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).appBarTheme.foregroundColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          softWrap: true,
          overflow: TextOverflow.visible,
        ),
      ),
    ),
  );
}
