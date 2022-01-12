import 'package:flutter/material.dart';
import 'package:lift_login/screens/bookSeats.dart';

Widget icontext( String name, IconData icon){
  return RichText(
    text: TextSpan(
      children: [
        WidgetSpan(
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(icon,size: 17),
          ),
        ),
        TextSpan(text: name,style: TextStyle(color: Colors.black)),
      ],
    ),
  );
}

Widget title(String name){
  return  Text(name,style: TextStyle(fontSize: 20,),);
}


Widget showRide(BuildContext context,String name, String fare,String rating,String date,String time,String seats,String pickup,String destination,String booked){
  return  GestureDetector(
    onTap: (){
      int remiaingSeats=int.parse(seats)-int.parse(booked);
      Navigator.push(context, MaterialPageRoute(
        builder: (context)=> BookSeats(name: name, travelDate: date,travelTime: time,availableSeats: remiaingSeats.toString(),pick: pickup,destination: destination,)
      ));


    },
    child: Card(
        child: Column(
          children: [

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 20),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage('assets/car.png'),
                  ),
                ),
                SizedBox(width: 20,),
                title(name),
                SizedBox(width: 90,),
                title(fare),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 7,bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  icontext(pickup, Icons.location_on),
                  SizedBox(height: 5,),
                  icontext(destination, Icons.local_taxi)
                ],
              ),
            ),

            Divider(height: 2,),
            Padding(
              padding: const EdgeInsets.only(bottom: 15,top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  icontext(rating, Icons.star),
                  icontext(time, Icons.alarm),
                  icontext(date, Icons.calendar_today),
                  icontext(seats, Icons.airline_seat_recline_extra_sharp),
                ],
              ),
            )
          ],
        )
    ),
  );
}

