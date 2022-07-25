import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expances_tracker/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppHalperProvider extends ChangeNotifier{
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
  void catagoryView(){

  }
  void addincome(String catagory,String money,String date){
    final subincome=double.parse(money);
    final income=UserDetails(balanceType: "1", catagory: catagory, date: date, money: money);
    userDetailList.add(income);
    totalincome=totalincome+subincome;
    totalmoney=totalincome-totalexpances;
    notifyListeners();
  }
  void addexpenses(String catagory,String money,String date){
    final subexpenses=double.parse(money);
    final expenses=UserDetails(balanceType: "2", catagory: catagory, date: date, money: money);
    userDetailList.add(expenses);
    totalexpances=totalexpances+subexpenses;
    totalmoney=totalincome-totalexpances;
    notifyListeners();
  }


    deleteContact(String money,String val) async {
      double submoney=0.0;
      print(submoney);
      if(money!=null) {
        userDetailList.removeWhere((element) => element.money==money);
        if(val=="1"){
          submoney=double.parse(money);
          totalincome=totalincome-submoney;
          totalmoney=totalmoney-submoney;

        }
        else if(val=="2"){
          submoney=double.parse(money);
          totalexpances=totalexpances-submoney;
          totalmoney=totalmoney+submoney;
        }

        notifyListeners();
      }
    }





}