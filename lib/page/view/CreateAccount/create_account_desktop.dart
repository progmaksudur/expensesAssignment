import 'package:expances_tracker/page/view/LogIN/log_in_page.dart';
import 'package:expances_tracker/provider/expenses_app_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

class CreateAccountDesktop extends StatefulWidget {
  const CreateAccountDesktop({Key? key}) : super(key: key);

  @override
  State<CreateAccountDesktop> createState() => _CreateAccountDesktopState();
}

class _CreateAccountDesktopState extends State<CreateAccountDesktop> {

  final _EmailFieldController=TextEditingController();
  final _PasswordFieldController=TextEditingController();
  final _ConfirmPasswordFieldController=TextEditingController();
  bool isObuscure=true;
  bool isConObuscure=true;
  String email="";
  String password="";
  String confirmpass="";

  allowSingun() async{
    confirmpass=_ConfirmPasswordFieldController.text.trim();
    email=_EmailFieldController.text.trim();
    password=_PasswordFieldController.text.trim();
    if(password==confirmpass){
      final snackbar=SnackBar(content: Text(
          "Saving"
      ),duration: const Duration(seconds: 5),);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email:email,password: password).then((fauth){
          Navigator.pushNamed(context, LoginPage.routeName);
        });

      }catch(onError){
        final snackbar=SnackBar(content: Text(
            "Error  ${onError.toString()}"
        ),duration: const Duration(seconds: 5),);
        ScaffoldMessenger.of(context).showSnackBar(snackbar);

      }

    }

  }

  void dispose() {
    // TODO: implement dispose
    _EmailFieldController.dispose();
    _PasswordFieldController.dispose();
    _ConfirmPasswordFieldController.dispose();
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
                    SizedBox(height:10,),
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
                    SizedBox(height:10,),
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
                              labelText: "Password",
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
                    SizedBox(height:10,),
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
                          obscureText: isConObuscure,
                          decoration: InputDecoration(
                              labelText: "Confirm Passsword",
                              prefixIcon: Icon(Icons.password),
                              suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    isConObuscure=!isConObuscure;
                                  });
                                },
                                icon: Icon(isConObuscure?Icons.visibility:Icons.visibility_off),
                              )
                          ),
                          controller: _ConfirmPasswordFieldController,

                        ),
                      ),
                    ),
                    SizedBox(height:10,),
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
                            allowSingun();



                          },

                          child: Text("Save"),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, LoginPage.routeName);

                    }, child: Text("Already have account",style: TextStyle(letterSpacing: 2,fontWeight: FontWeight.bold),))






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
