import 'package:expances_tracker/provider/expenses_app_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../CreateAccount/create_account.dart';
import '../Home/home_page.dart';

class LoginPageDesktop extends StatefulWidget {

  const LoginPageDesktop({Key? key}) : super(key: key);

  @override
  State<LoginPageDesktop> createState() => _LoginPageDesktopState();
}

class _LoginPageDesktopState extends State<LoginPageDesktop> {
  final _EmailFieldController=TextEditingController();
  final _PasswordFieldController=TextEditingController();
  String email="";
  String password="";
  bool isObuscure=true;

  allowLogIn() async{
    email=_EmailFieldController.text.trim();
    password=_PasswordFieldController.text.trim();
    final snackbar=SnackBar(content: Text(
        "Loading"
    ),duration: const Duration(seconds: 5),);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);

    User? currentUser;
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email:email,password: password).then((fauth){
        currentUser=fauth.user;
        Navigator.pushNamed(context, HomePage.routeName,arguments: currentUser);
      });

    }catch(onError){
      final snackbar=SnackBar(content: Text(
          "Error  ${onError.toString()}"
      ),duration: const Duration(seconds: 5),);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);

    }


  }

  void dispose() {
    // TODO: implement dispose
    _EmailFieldController.dispose();
    _PasswordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Card(
              color: Colors.transparent,
              elevation: 10,
              clipBehavior: Clip.none,
              child: Container(
                height: screen.height*.80,
                width: 500,
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: Text("Expense Tracker",style: TextStyle(color:appOrangeColor,fontSize: 30,fontWeight: FontWeight.bold),)),
                    ),
                    SizedBox(height:20,),
                    Container(
                      height: 60,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(.1),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Email id",
                            prefixIcon: Icon(Icons.email),
                          ),
                          controller: _EmailFieldController,

                        ),
                      ),
                    ),
                    SizedBox(height:20,),
                    Container(
                      height: 60,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(.1),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextField(
                          obscureText: isObuscure,
                          decoration: InputDecoration(
                            labelText: "Passsword",
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  isObuscure=!isObuscure;
                                });
                              },
                              icon: Icon(isObuscure?Icons.visibility:Icons.visibility_off),
                            )
                          ),
                          controller: _PasswordFieldController,

                        ),
                      ),
                    ),
                    SizedBox(height:20,),
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(.1),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextButton(
                            onPressed: (){

                              allowLogIn();
                            },
                            child: Text("Log In"),
                          )
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, CreateAccount.routeName);

                    }, child: Text("Create Account",style: TextStyle(letterSpacing: 2,fontWeight: FontWeight.bold),))

                  ],
                ),


              ),
            ),
          ),


        ],

      ),
    );
  }

}
