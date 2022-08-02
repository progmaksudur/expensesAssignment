

class UserDetails{
  String balanceType;
  String catagory;
  String date;
  String money;

  UserDetails({required this.balanceType,required this.catagory,required this.date,required this.money});
  static UserDetails fromJson(Map<String,dynamic>json)=>UserDetails(
      balanceType: json['balanceType'],
      catagory: json['catagory'], date: json['date'], money: json['money']);

}
