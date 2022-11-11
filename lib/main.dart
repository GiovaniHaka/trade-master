import 'package:flutter/material.dart';
import 'package:ricky_and_morty/common/constants/ui/custom_colors.dart';
import 'package:ricky_and_morty/navigator/routes.dart';
import 'package:ricky_and_morty/services/local_database/domain/usecases/initialize_local_database.dart';

void main() {
  InitializeLocalDatabaseImp().call();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: CustomColors.backgroundColor,
        scaffoldBackgroundColor: CustomColors.backgroundColor,
        appBarTheme: const AppBarTheme(
          color: CustomColors.backgroundColor,
          foregroundColor: CustomColors.pink,
          actionsIconTheme: IconThemeData(
            color: CustomColors.pink,
          ),
          elevation: 0,
        ),
      ),
      initialRoute: Routes.root,
      onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
    );
  }
}
