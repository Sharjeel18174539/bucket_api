import 'package:bucket_api/bucketList.dart';
import 'package:bucket_api/mySelf.dart';
import 'package:bucket_api/viewItem.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<dynamic> bucketListData=[];
  bool isLoading=false;
  bool isError=false;

  Future<void> getData() async {

    setState(() {
      isLoading=true;
    });
    try{
      Response response= await Dio().get('https://flutterapitest-e8d15-default-rtdb.firebaseio.com/bucketlist.json');
      bucketListData=response.data;
      isLoading=false;
      isError=false;
      setState(() {

      });

    }catch(e){
      isLoading=false;
      isError=true;
      setState(() {});
      print("Invalid response");
      print(e);

    }
  }
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return  AddBucketList(newIndex: bucketListData.length,);
          }));
        },
        child:  const Icon(FontAwesomeIcons.plus),
        shape: const CircleBorder(),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title:  Row(
          children: [
            Builder(
              builder: (context) => IconButton(
                icon: const Image(
                    image: AssetImage('images/menu.png'),
                  height: 25,
                  width: 35,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
             const SizedBox(width: 45,),
             const Center(child: Text('Our Tour List'))
          ],
        ),
        actions: [
          InkWell(
            onTap: getData,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(FontAwesomeIcons.refresh),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
             const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child:Text('SZ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              accountName: Text('Shameen Farooqui'),
              accountEmail: Text('shameenfarooqui19@gmail.com'),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.heart),
              title: const Text("Zumeen Sharjeel Farooqui"),
               onTap: (){
                   Navigator.push(context,MaterialPageRoute(builder: (context) =>const MySelf()));
               },

            )

          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          getData(); },
        child:isLoading?const Center(
            child: CircularProgressIndicator()): 
        isError? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FontAwesomeIcons.warning),
              const SizedBox(height: 5,),
              const Text("error to fetch tour list"),
              const SizedBox(height: 5,),
              ElevatedButton(
                  onPressed: getData,
                  child: const Text('Try Again '),
              )

            ],
          ),
        ) :
        ListView.builder(
            itemCount: bucketListData.length,
            itemBuilder: (BuildContext context, int index){
              return (bucketListData[index] is Map && (!bucketListData[index]["completed"])) ? ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return  ViewItem(
                      index: index,
                      title: bucketListData[index]['item'] ?? "",
                      image: bucketListData[index]['image'] ?? " ",
                      details: bucketListData[index]['detail'] ?? " ",
                    );
                  })).then((value){
                    if(value=="refresh"){
                      getData();
                    }
                  });
                },
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(bucketListData[index]?['image'] ?? " "),
                ),
                title: Text(bucketListData[index]?['item'] ?? " "),
                trailing: Text(bucketListData[index]?['cost'].toString() ?? " "),
              )
              : const SizedBox();
            }),
      ),
    );
  }
}
