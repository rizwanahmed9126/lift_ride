import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_login/screens/Preferences.dart';
import 'dart:async';

import 'package:lift_login/login/Login.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class Start_slider extends StatefulWidget {

   @override
   _Start_sliderState createState() => _Start_sliderState();
}

class _Start_sliderState extends State<Start_slider> {
   int _currentPage=0;
   // SharedPreferences logindata;
   bool newuser;





   final PageController _pagecontroller=PageController(
       initialPage: 0
   );

   // void check_if_already_login() async {
   //   logindata = await SharedPreferences.getInstance();
   //   newuser = (logindata.getBool('login') ?? true);
   //   print(newuser);
   //   if (newuser == false) {
   //     Navigator.pushReplacement(
   //         context, new MaterialPageRoute(builder: (context) => Preferences()
   //       // SideBarLayout()
   //     ));
   //   }
   // }

   void initState() {

      super.initState();
      //check_if_already_login();
      Timer.periodic(Duration(seconds: 5), (Timer timer) {
         if(_currentPage<2){
            _currentPage++;
         }
         else{
            _currentPage=0;
         }
         _pagecontroller.animateToPage(
             _currentPage,
             duration: Duration(milliseconds: 300),
             curve: Curves.easeIn
         );

      });
   }

   @override
   void dispose() {
      super.dispose();
      _pagecontroller.dispose();
   }
   _onPageChanged(int index){
      setState(() {
         _currentPage=index;
      });
   }


   @override
   Widget build(BuildContext context) {

      Size size=MediaQuery.of(context).size;
      return Scaffold(

         body: Container(
            color: Colors.white,
            child: Column(
               children: [


                  Expanded(
                      child:Stack(
                         alignment: AlignmentDirectional.bottomCenter,
                         children: [
                            PageView.builder(
                               scrollDirection: Axis.horizontal,
                               onPageChanged: _onPageChanged,
                               controller: _pagecontroller,
                               itemCount: slideList.length,
                               itemBuilder: (ctx,i) => SlideItem(index: i,),

                            ),
                            Stack(
                               alignment: AlignmentDirectional.topStart,
                               children: [
                                  Container(
                                     margin: EdgeInsets.only(bottom: 35),
                                     child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        //mainAxisAlignment: MainAxisAlignment.center,

                                        children: [
                                           for(int i=0; i<slideList.length; i++)
                                              if(i==_currentPage)
                                                 SlideDots(true)
                                              else
                                                 SlideDots(false)

                                        ],
                                     ),
                                  )
                               ],
                            )
                         ],
                      )




                  ),
                  Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [

                           GestureDetector(
                              onTap: (){

                                 Navigator.push(context, MaterialPageRoute(
                                     builder: (context){
                                        return LoginScreen();
                                     }
                                 ));

                              },
                              child: Row(
                                 children: [
                                    Image.asset('assets/pakistan.png',height: 32,width:32),
                                    SizedBox(),
                                    Text("+92",style: TextStyle(fontSize: 20),),
                                    SizedBox(width: 10,),
                                    Text("Enter your mobile number",style: TextStyle(fontSize: 20,color: Colors.grey.shade400,),),


                                 ],
                              ),
                           ),
                           Divider(
                              height:  10,
                              thickness: 0.5,
                              color: Colors.black.withOpacity(0.3),
                              indent: 85,
                              endIndent: 10,
                           ),

                           //SizedBox(height: size.height*0.1,),
                           Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 Text("By continuing, I agree Lift-Ride "),
                                 Text("Terms",style: TextStyle(decoration: TextDecoration.underline,),)
                              ],
                           )
                        ],
                     ),
                  )

               ],

            ),
         ),

      );
   }
}

//-------------------------SlideItem
class SlideItem extends StatelessWidget {


   final int index;
   SlideItem({this.index});
   @override
   Widget build(BuildContext context) {
      return SingleChildScrollView(
        child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
           // crossAxisAlignment: CrossAxisAlignment.center,
           children: [
              Container(

                 width:900,
                 height: 400,
                 decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(slideList[index].imageUrl,),
                       //fit: BoxFit.cover
                    ),

                 ),
              ),
              SizedBox(height: 10,),

              Container(

                 child:Text(


                    slideList[index].title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                       fontSize: 22,
                       color: Colors.black,




                    ),
                 ),
              ),
              SizedBox(height: 50,),
              Container(

                  child:Text(
                     slideList[index].description,
                     textAlign: TextAlign.center,
                     style: TextStyle(
                         fontSize: 15,

                         color: Colors.grey
                     ),

                  )
              )
//          ],
//        )
           ],
        ),
      );
   }
}
//------------------------Slide
class Slide{
   final String imageUrl;
   final String title;
   final String description;

   Slide({
      @required this.imageUrl,
      @required this.title,
      @required this.description});
}
final slideList=[
   Slide(
      imageUrl: 'assets/pic2.png',
      title: 'Start Xpool ',
      description: 'Commute with verified professionals and take one vehicle off the road today \n\n Share seats. Save Money. Save Environment ',
   ),
   Slide(
      imageUrl: 'assets/pic1.png',
      title: 'Easy Commute',
      //title: 'Start Xpool ',
      description: 'Share empty car/bike seats on your route, at your\ntime and contribute fare    ',
   ),
   Slide(
      imageUrl: 'assets/pic5.png',
      title: 'Find Rides ',
      description: 'Get safe, comfortable & economical rides within the city or outstation at low at Rs 3/km  ',
   )
];

class SlideDots extends StatelessWidget {
   bool isActive;
   SlideDots(this.isActive);

   @override
   Widget build(BuildContext context) {
      return AnimatedContainer(
         duration: Duration(milliseconds: 150),
         margin: const EdgeInsets.symmetric(horizontal: 4),
         height: isActive ? 9 : 6,
         width: isActive ? 9 : 6,
         decoration: BoxDecoration(
            color: isActive ? Colors.redAccent : Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(12)),
         ),
      );
   }
}