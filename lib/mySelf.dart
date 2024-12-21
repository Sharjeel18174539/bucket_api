
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MySelf extends StatefulWidget {
  const MySelf({super.key});

  @override
  State<MySelf> createState() => _MySelfState();
}

class _MySelfState extends State<MySelf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Row(
          children: [
            IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const FaIcon(FontAwesomeIcons.arrowLeft),),
            const SizedBox(width: 30,),
            const Text('Meri Pyari si jaan')
          ],
        ),
      ),
      body:  DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/romantic.png'),
            fit: BoxFit.cover,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            children: [
              const Center(child: Text('Zumeen ❤️ Sharjeel', style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold,),)),
              const SizedBox(height: 15,),
              const Row(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('images/Mycvimage.png'),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('images/love_sign.png'),
                  ),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('images/miss.jpg'),
                  ),

                ],
              ),
              const SizedBox(height: 40,),
              const Text('', style: TextStyle(color: Colors.red , fontSize: 20),),
              const SizedBox(height: 15,),
              const Text(' ', style: TextStyle(color: Colors.red , fontSize: 20),),
              const SizedBox(height: 15,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
                ),
                  onPressed: (){
                  showModalBottomSheet(
                      context: context, builder: (context){
                        return Container(
                          color: Colors.pinkAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(" ", style: TextStyle(color: Colors.white),),
                          ),
                        );
                  });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text("click me " , style: TextStyle(color: Colors.white),),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
