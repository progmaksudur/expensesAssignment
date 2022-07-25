import 'package:expances_tracker/page/view/CreateAccount/create_account.dart';
import 'package:expances_tracker/page/view/Home/home_page.dart';
import 'package:expances_tracker/page/view/LogIN/log_in_page.dart';
import 'package:expances_tracker/page/view/add_expenses.dart';
import 'package:expances_tracker/page/view/add_income.dart';
import 'package:expances_tracker/page/widget_model/web_horaizontal_scroll.dart';
import 'package:expances_tracker/provider/expenses_app_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
        options: FirebaseOptions(apiKey: "AIzaSyDmVNGfvAaD58cSY5-60gHZCtEF4S3v_8o",
            appId: "1:371105123958:web:905ce5142566f1bf221957",
            messagingSenderId: "371105123958",
            projectId: "expenses-tracker-2e391")
    );
  }
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(create: (context)=>AppHalperProvider(),
      child: const MyApp()));
}
final Color primaryColor=Color(0xFF453745);
final Color secondaryColor=Color(0xFF8C12E5);
final Color appOrangeColor=Color(0xFFFB7B49);
final Color appSecondaryColor=Color(0xFF40354E);



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.orange,
      ),
      initialRoute:CreateAccount.routeName,
      routes: {
        LoginPage.routeName:(context)=>LoginPage(),
        CreateAccount.routeName:(context)=>CreateAccount(),
        HomePage.routeName:(context)=>HomePage(),
        AddExpenses.routeName:(context)=>AddExpenses(),
        AddIncome.routeName:(context)=>AddIncome(),

      },
    );
  }
}


