import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'theme/cyber_theme.dart';
import 'providers/nutrition_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru', null);
  
  final provider = NutritionProvider();
  await provider.init();
  
  runApp(MyApp(provider: provider));
}

class MyApp extends StatelessWidget {
  final NutritionProvider provider;
  
  const MyApp({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: MaterialApp(
        title: 'Cyber Nutrition',
        theme: CyberTheme.theme,
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), 
          Locale('ru', ''),
        ],
        locale: const Locale('ru', ''), // Force Russian for demo
      ),
    );
  }
}
