import 'package:expances_tracker/main.dart';
import 'package:expances_tracker/model/user_model.dart';
import 'package:expances_tracker/page/view/LogIN/log_in_page.dart';
import 'package:expances_tracker/page/view/add_income.dart';
import 'package:expances_tracker/provider/expenses_app_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../add_expenses.dart';
import 'home_page.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({Key? key}) : super(key: key);

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  String? userName="Unknown";
  final user=FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    userName=user?.email!;
    return Consumer<AppHalperProvider>(builder: (context,provider,_)=> Scaffold(
        appBar: AppBar(
          elevation: 5,
          title:Text("${userName}",style: TextStyle(
            color: Colors.white,
          ),),
          leading: Card(
            elevation: 5,
            child: Icon(Icons.person,color: Colors.orange,),
          ),
          actions: [
            IconButton(onPressed: ()async{
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, LoginPage.routeName);
            }, icon: Icon(Icons.login_outlined,color: Colors.white,))
          ],
        ),
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
                    width: screen.width*.80,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.monetization_on_outlined,size: 40,color: Colors.green,),
                              SizedBox(width: 10,),
                              Text("Total Money",style: TextStyle(fontSize: 30,wordSpacing: 1.25,fontWeight: FontWeight.bold),)
                            ],
                          ),
                          Card(
                            elevation: 10,
                            shadowColor: Colors.deepPurple,
                            child: Container(
                              width: screen.width/2,
                              height: screen.height/14,
                              child: Center(child: Text("${provider.totalmoney}",style: TextStyle(color:Colors.deepPurple,fontSize: 20,wordSpacing: 1.25,fontWeight: FontWeight.bold),)),

                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: screen.width/2.7,
                                child: Card(
                                  elevation: 5,
                                  clipBehavior: Clip.none,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.arrow_upward,color: Colors.green,),
                                          SizedBox(width: 2,),
                                          Text("Income : ${provider.totalincome}"),
                                        ],
                                      ),
                                      IconButton(onPressed: (){
                                        String income="income";
                                        Navigator.pushNamed(context, AddIncome.routeName,arguments:income );
                                      }, icon: Icon(Icons.add)),
                                    ],
                                  )
                                ),
                              ),
                              Container(
                                width: screen.width/2.7,
                                child: Card(
                                    elevation: 5,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.arrow_downward,color: Colors.red,),
                                            Text("Expenses : ${provider.totalexpances}"),
                                          ],
                                        ),
                                        IconButton(onPressed: (){
                                          String expenses="expances";
                                          Navigator.pushNamed(context, AddExpenses.routeName,arguments:expenses );
                                        }, icon: Icon(Icons.add)),
                                      ],
                                    )
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: 10),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text("Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize:25,color:appOrangeColor),),
                              Card(
                                color: Colors.white,
                                shadowColor: secondaryColor,

                                elevation: 10,
                                child: Container(
                                  height: screen.height*.35,
                                  width: screen.width*.70,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ListView.builder(itemCount: userDetailList.length,itemBuilder: (context,iteam){
                                      final listiteams=userDetailList[iteam];
                                      return Dismissible(
                                        key: ValueKey(listiteams.catagory),
                                        direction: DismissDirection.endToStart,
                                        confirmDismiss: _showConfirmationDialog,
                                        onDismissed: (direction) {
                                          provider.deleteContact(listiteams.money,listiteams.balanceType);
                                        },
                                        background: Container(
                                          alignment: Alignment.centerRight,
                                          color: Colors.red,
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: Card(
                                          elevation: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: ListTile(
                                              leading: Icon(Icons.circle,color:listiteams.balanceType=="2"? Colors.red:Colors.green,),
                                              title: Text("${listiteams.catagory}"),
                                              subtitle: Text("${listiteams.date}"),
                                              minVerticalPadding: 5,
                                              tileColor: Colors.white,
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text("${listiteams.money}"),
                                                  IconButton(onPressed: (){
                                                    print("press");
                                                  },
                                                    icon: Icon(Icons.edit),color: Colors.orange,),
                                                ],
                                              ),



                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  )
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                  ),
                ),
              ),


          ],

        )
      ),
    );
  }
  Future<bool?> _showConfirmationDialog(DismissDirection direction) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Content'),
          content: const Text('Are you sure to delete this data?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('NO'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('YES'),
            ),
          ],
        ));
  }
}
