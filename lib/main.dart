import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: surahscreen(),
    );
  }
}
class surahscreen extends StatefulWidget {
  const surahscreen({super.key});

  @override
  State<surahscreen> createState() => _surahscreenState();
}

class _surahscreenState extends State<surahscreen> {
    Map map={};
    List list=[];

    void callapi() async{
      http.Response myresponse = await http.get(Uri.parse("https://api.alquran.cloud/v1/surah"));
       if(myresponse.statusCode==200){
          setState(() {
        map = jsonDecode(myresponse.body);
        list = map["data"];
      });

  }
      
    }
  @override

void initState() {
  super.initState();
  callapi();
}

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      centerTitle: true,
    title:  Text('سورۃ قرآن'),
        
        backgroundColor: Color(0xFF00acc2),
        foregroundColor: Colors.white,
      ),
body: ListView.builder(
  itemCount: list.length,
  itemBuilder: (context, index){
   return ListTile(
 onTap: (){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>detailsurahscreen(list[index]["number"]),));
 },
 leading: CircleAvatar( backgroundColor: Color(0xFF00acc2),child: Text("${index+1}"),),
 title: Text(list[index]["name"] + " | " + list[index]["englishName"]),
subtitle: Text(list[index]["englishNameTranslation"]),

 trailing: Column(children: [
  list[index]["revelationtype"]== "Meccan"?
     Image.asset("assets/images/Makkah.png" ,width: 30,height: 30,)
    :Image.asset("assets/images/madina.png" ,width: 30,height: 30),
  Text("verses ${list[index]["numberOfAyahs"]}"),
  ],),
   );
},),
    );
  }
}

class detailsurahscreen extends StatefulWidget {
  var surahnum;
   detailsurahscreen(this.surahnum,{super.key});

  @override
  State<detailsurahscreen> createState() => _detailsurahscreenState();
}

class _detailsurahscreenState extends State<detailsurahscreen> {
Map map={};
List list=[];
void callapi() async{
  http.Response myresponse =await http.get(Uri.parse("https://api.alquran.cloud/v1/surah/${widget.surahnum}"));
if(myresponse.statusCode==200){
   setState(() {
     map=jsonDecode(myresponse.body);
     list =map["data"]["ayahs"];
   });
}

}
  @override
@override
void initState() {
  super.initState();
  callapi();
}

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
        title: const Text("تفصیل سورۃ"),
        backgroundColor: Color(0xFF00acc2),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
        return ListTile(
          title: Text(list[index]["text"],  textAlign: TextAlign.right,),
          
        );
      },),
    );
  }
}