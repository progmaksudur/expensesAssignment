
import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expances_tracker/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppHalperProvider extends ChangeNotifier{
  late  List<UserDetails> userDetailList=[];
  String dropdownvalue="Salary";
  String dropdownExvalue="Water Bill";
  List<String> incomeList=["Salary","Others"];
  List<String> expenseCatagory=["House Rent","Water Bill","Electric Bill","Groceries","Uber","Medications","Other"];
  double totalmoney=0.0;
  double totalexpances=0.0;
  double totalincome=0.0;
  String catagory="others";
  String date="1/01/2022";
  double singledata=0.0;





  void dropdownvalueChange(String newValue){
    dropdownvalue = newValue;
    notifyListeners();
  }
  void dropDownvalueChange(String newValue){
    dropdownExvalue = newValue;
    notifyListeners();
  }

  ShowDate(dynamic context) async {
   DateTime? selectedTime= await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1940), lastDate: DateTime.now());
    if(selectedTime!=null){
        date=DateFormat("dd/MM/yyyy").format(selectedTime);
    }
    notifyListeners();
  }

  void addincome(String catagory,String money,String date) async{
    final subincome=double.parse(money);
    final income=UserDetails(balanceType: "1", catagory: catagory, date: date, money: money);
    userDetailList.add(income);
    await addDatabase(userDetails: income);
    totalincome=totalincome+subincome;
    totalmoney=totalincome-totalexpances;
    notifyListeners();
  }
  void addexpenses(String catagory,String money,String date) async{
    final subexpenses=double.parse(money);
    final expenses=UserDetails(balanceType: "2", catagory: catagory, date: date, money: money);
    userDetailList.add(expenses);
    await addDatabase(userDetails: expenses);
    totalexpances=totalexpances+subexpenses;
    totalmoney=totalincome-totalexpances;
    notifyListeners();
  }
  
  
  Future addDatabase({required UserDetails userDetails})async{
        final user=FirebaseAuth.instance.currentUser;
        final docUser=FirebaseFirestore.instance.collection('user').doc();
        final json={
              'balanceType':userDetails.balanceType,
              'catagory':userDetails.catagory,
              'date':userDetails.date,
              'money':userDetails.money,
        };
        await docUser.set(json);
  }


    void deleteContact(UserDetails userDetails) async {
      final docUser=FirebaseFirestore.instance.collection('user').doc();
      docUser.update({
      'balanceType':FieldValue.delete(),
      'catagory':FieldValue.delete(),
      'date':FieldValue.delete(),
      'money':FieldValue.delete(),

      });
      double submoney=0.0;
      print(submoney);
      if(userDetails.money!=null) {
        userDetailList.removeWhere((element) => element.money==userDetails.money);
        if(userDetails.balanceType=="1"){
          submoney=double.parse(userDetails.money);
          totalincome=totalincome-submoney;
          totalmoney=totalmoney-submoney;

        }
        else if(userDetails.balanceType=="2"){
          submoney=double.parse(userDetails.money);
          totalexpances=totalexpances-submoney;
          totalmoney=totalmoney+submoney;
        }

        notifyListeners();
      }
    }










}