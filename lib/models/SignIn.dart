class ProductModel {
  final String phonenumber;


  ProductModel({this.phonenumber});

  Map<String, dynamic> toMap()
  {
    return{
      "data":this.phonenumber,
    };
  }



}

class Registerdata{
  final String phonenumber1;
  final String first_name;
  final String last_name;

  Registerdata({this.phonenumber1,this.first_name,this.last_name});


  Map<String, dynamic> toMap()
  {
    return{
      "phone_number":this.phonenumber1,
      "firstname":this.first_name,
      "lastname":this.last_name,
    };
  }
}



class matchdata{
  final String pick;
  final String drop;
  final String date;

  matchdata({this.date,this.drop,this.pick});


  Map<String, dynamic> toMap()
  {
    return{
      "datetime":this.date,
      "destination":this.drop,
      "pickup":this.pick,
    };
  }
}