import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ViewItem extends StatefulWidget {
  String title;
  String image;
  String details;
  int index;
   ViewItem({super.key, required this.title, required this.image, required this.details, required this.index});

  @override
  State<ViewItem> createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  Future<void> deleteData() async {
    Navigator.pop(context);
    try {
      Response response = await Dio().delete(
          'https://flutterapitest-e8d15-default-rtdb.firebaseio.com/bucketlist/${widget.index}.json');
      Navigator.pop(context, "refresh");
    } catch (e) {
      print("error");
    }
  }

  Future<void> markAsComplete() async {
    Navigator.pop(context);
    try{
      Map<String, dynamic> data={
        "completed":true
      };
      Response response= await Dio().patch('https://flutterapitest-e8d15-default-rtdb.firebaseio.com/bucketlist/${widget.index}.json');
      Navigator.pop(context , "refresh");
    }catch(e){
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
              icon: const FaIcon(FontAwesomeIcons.arrowLeft),),
            const SizedBox(width: 50,),
            Text("${widget.title}")
          ],
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value){
              if(value==1){
                 showDialog(
                     context: context, builder: (context){
                       return AlertDialog(
                         title: const Text('Are you sure to delete'),
                         actions: [
                           InkWell(
                             onTap:(){
                               Navigator.pop(context);
                             },
                               child: const Text('cancel')
                           ),
                           InkWell(
                             onTap:deleteData,
                               child: const Text('confirm')
                           ),
                         ],
                       );
                 });
              }
              if(value==2){
                markAsComplete();
              }
            },
              itemBuilder: (context){
                return[
                  const PopupMenuItem(value:1 ,child: Text('Delete')),
                  const PopupMenuItem(value: 2,child: Text('Mark as done'))
                ];
              }
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                  image: NetworkImage(widget.image))
            ),
          ),
          const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.details, style: const TextStyle(fontSize: 20 , fontStyle: FontStyle.italic),),
          )
        ],
      ),
    );
  }
}
