import 'package:flutter/material.dart';

class CustomUI extends StatefulWidget {
  final Function press;
  final ValueChanged<String> onChnaged;
  final List<String> brands;
  final ValueChanged<String> onBrandChanged;
  final String selectedBrandValue;
  final List<String> model;
  final ValueChanged<String> onModelChanged;
  final String selectedModelValue;
  final String image;
  final String textNumberPlate;
  final String textNumberPlate1;

  const CustomUI({
    Key key,
    this.press,
    this.image,
    this.onChnaged,
    this.onBrandChanged,
    this.brands,
    this.selectedBrandValue,
    this.model,
    this.onModelChanged,
    this.selectedModelValue,
    this.textNumberPlate,
    this.textNumberPlate1
  }):super(key: key);

  @override
  _CustomUIState createState() => _CustomUIState();
}

class _CustomUIState extends State<CustomUI> {
  String brandName;
  String modelName;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 400,
            width: 450,
            child: Image.asset(widget.image,height: 32,width:32),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 190,
              width: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200],
                        offset: Offset(1,0.7),
                        blurRadius: 6,
                        spreadRadius: 0.5
                    ),
                  ]
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 90,top: 15),
                    child: Text(widget.textNumberPlate,style: TextStyle(fontSize: 19,color: Colors.blue),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 5),
                    child: Text('We will only share with passengers who will book your ride',style: TextStyle(fontSize: 16,color: Colors.grey),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 170,top: 20),
                    child: Text(widget.textNumberPlate1,style: TextStyle(fontSize: 14,color: Colors.grey),),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,bottom: 20),
                    child: Container(
                      height: 30,
                      child: TextField(
                        onChanged: widget.onChnaged,
                        autofocus: false,
                      ),
                    ),
                  )




                ],
              ),

            ),

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,top: 20),
                child: Text('Select Brand',style: TextStyle(fontSize: 17),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            offset: Offset(1,0.7),
                            blurRadius: 6,
                            spreadRadius: 0.5
                        ),
                      ]
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child:  DropdownButton(
                        hint: Text("Select Brand"), // Not necessary for Option 1
                        value: widget.selectedBrandValue,

                        onChanged: widget.onBrandChanged,
                        items:widget.brands.map((location) {
                          return DropdownMenuItem(
                            child: new Text(location),
                            value: location,
                          );
                        }).toList(),
                      )
                  ),
                ),
              ),


            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,top: 20),
                child: Text('Select Model',style: TextStyle(fontSize: 17),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            offset: Offset(1,0.7),
                            blurRadius: 6,
                            spreadRadius: 0.5
                        ),
                      ]
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: DropdownButton(
                        hint: Text("Select Model"), // Not necessary for Option 1
                        value: widget.selectedModelValue,

                        onChanged: widget.onModelChanged,
                        items:widget.model.map((location) {
                          return DropdownMenuItem(
                            child: new Text(location),
                            value: location,
                          );
                        }).toList(),
                      )
                  ),
                ),
              ),


            ],
          ),
          Container(
              height: 50,
              width: 500,
              margin: EdgeInsets.only(top: 25),
              child: FlatButton(
                child: Text("Register"),
                textColor: Colors.white,
                color: Colors.redAccent,
                onPressed: widget.press,
              )
          )





        ],
      ),
    );
  }
}
