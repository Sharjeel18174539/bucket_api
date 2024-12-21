
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddBucketList extends StatefulWidget {
  int newIndex;
   AddBucketList({super.key , required this.newIndex});

  @override
  State<AddBucketList> createState() => _AddBucketListState();
}

class _AddBucketListState extends State<AddBucketList> {

  TextEditingController itemText= TextEditingController();
  TextEditingController costText= TextEditingController();
  TextEditingController imageUrlText= TextEditingController();
  TextEditingController detailText= TextEditingController();

  Future<void> addData() async {

    try{
      Map<String, dynamic> data={

          "item": itemText.text,
          "cost": costText.text,
          "image": imageUrlText.text,
          "detail": detailText.text,
          "completed":false

      };
      Response response= await Dio().patch('https://flutterapitest-e8d15-default-rtdb.firebaseio.com/bucketlist/${widget.newIndex}.json' ,data: data);
      Navigator.pop(context , "refresh");
    }catch(e){
      print("error");
    }
  }


  @override
  Widget build(BuildContext context) {
    var addForm = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: FaIcon(FontAwesomeIcons.arrowLeft),),
             SizedBox(width: 35,),
             Text('BucketList'),

          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: addForm,
          child: Column(
            children: [
              TextFormField(
                validator: (value){
                  if(value.toString().length<3){
                    return "must be greater than 3 words";
                  }
                  if(value == null || value.isEmpty){
                    return "This must not be empty";
                  }
                },
                controller: itemText,
                decoration: InputDecoration(
                  labelText: "item"
                ),
              ),
              SizedBox(height: 25,),
              TextFormField(
                validator: (value){
                  if(value.toString().length<3){
                    return "must be greater than 3 words";
                  }
                  if(value == null || value.isEmpty){
                    return "This must not be empty";
                  }
                },
                controller: costText,
                decoration: InputDecoration(
                    labelText: "Estimated cost"
                ),
              ),
              SizedBox(height: 25,),
              TextFormField(
                validator: (value){
                  if(value.toString().length<3){
                    return "must be greater than 3 words";
                  }
                  if(value == null || value.isEmpty){
                    return "This must not be empty";
                  }
                },
                controller: imageUrlText,
                decoration: InputDecoration(
                    labelText: "Image url"
                ),
              ),
              SizedBox(height: 25,),
              TextFormField(
                validator: (value){
                  if(value.toString().length<3){
                    return "must be greater than 3 words";
                  }
                  if(value == null || value.isEmpty){
                    return "This must not be empty";
                  }
                },
                controller: detailText,
                decoration: InputDecoration(
                    labelText: "Enter description"
                ),
              ),
              SizedBox(height: 25,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: (){
                          if(addForm.currentState!.validate()){
                            addData();
                          }
                        },
                        child: Text('Add data')
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
