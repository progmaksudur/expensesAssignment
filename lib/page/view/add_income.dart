import 'package:expances_tracker/page/view/Home/home_page.dart';
import 'package:expances_tracker/provider/expenses_app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddIncome extends StatefulWidget {
  static const String routeName="/addincome";
  const AddIncome({Key? key}) : super(key: key);

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final _MoneyTextFieldController=TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _MoneyTextFieldController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Consumer<AppHalperProvider>(
      builder:(context,provider,_)=> Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Card(
                color: Colors.transparent,
                elevation: 10,
                child: Container(
                  height: screen.height*.80,
                  width: screen.width*.70,
                  color: Colors.white,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Card(
                              elevation: 5,
                              color: Colors.white,
                              child: Container(
                                  height: screen.height*.1,
                                  width: screen.width*.6,
                                  child: Center(child: Text("Income",style: TextStyle(fontSize: 30,wordSpacing: 1.25,fontWeight: FontWeight.bold,color: Colors.orange),)))),
                          SizedBox(height: 20,),
                          Card(
                            elevation: 10,
                            color: Colors.white,
                            child: Container(
                              height: screen.height*.6,
                              width: screen.width*.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Card(
                                    elevation: 5,
                                    clipBehavior: Clip.none,
                                    child: Container(
                                      height: 60,
                                      width: screen.width*.4,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: DropdownButton(
                                          iconSize: 20,
                                          value: provider.dropdownvalue,
                                          icon: const Icon(Icons.keyboard_arrow_down),
                                          items: provider.incomeList.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),

                                          onChanged: (String? newValue) {
                                            provider.dropdownvalueChange(newValue!);

                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Card(
                                    elevation: 5,
                                    clipBehavior: Clip.none,
                                    child: Container(
                                      height: 60,
                                      width: screen.width*.4,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                                        child: TextField(
                                          decoration: InputDecoration(
                                            labelText: "Amount",
                                            prefixIcon: Icon(Icons.monetization_on_outlined),
                                          ),
                                          controller: _MoneyTextFieldController,

                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Card(
                                    elevation: 5,
                                    clipBehavior: Clip.none,
                                    child: Container(
                                      height: screen.height*.2,
                                      width: screen.width*.4,
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextButton.icon(onPressed: (){
                                              provider.ShowDate(context);
                                            }, icon:Icon(Icons.date_range), label:const Text("Select Date ")),
                                            Chip(backgroundColor: Colors.purple.shade900.withOpacity(.4),
                                                label:provider.date==null? Text("No Date Chosen"):Text(provider.date)),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(onPressed: (){
                                    String catagory=provider.dropdownvalue;
                                    String  money= _MoneyTextFieldController.text;
                                    String date=provider.date;
                                    provider.addincome(catagory,money, date);
                                    Navigator.pop(context);
                                  }, child: Text("Save",style: TextStyle(color: Colors.white),)),
                                ],
                              ),
                            ),
                          ),



                        ]

                    ),

                  ),

                ),
              ),
            ),




          ],

        ),

      ),
    );
  }
}
