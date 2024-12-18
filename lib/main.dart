import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
void main() =>  runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<dynamic> bucketListData=[];

  Future<void> getData() async {
    try{
      Response response= await Dio().get('https://flutterapitest-e8d15-default-rtdb.firebaseio.com/bucketlist.json');
      bucketListData=response.data;

      setState(() {

      });

    }catch(e){
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bucket List'),

      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: getData,
              child: const Text("Get Data")
          ),
          Expanded(
            child: ListView.builder(
              itemCount: bucketListData.length,
                itemBuilder: (BuildContext context, int index){
              return ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(bucketListData[index]['image'] ?? " "),
                ),
                title: Text(bucketListData[index]['item'] ?? " "),
                trailing: Text(bucketListData[index]['cost'].toString() ?? " "),
              );
            }),
          )
        ],
      ),
    );
  }
}
