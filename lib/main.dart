import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

void main() {
 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
 

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var afrTime;
  var afrLocation;
  var america;
  var japan;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tz.initializeTimeZones();
    var locations=tz.timeZoneDatabase.locations;
    afrLocation=locations['Africa/Abidjan'];
    america=locations['America/New_York'];
    japan=locations['Asia/Tokyo'];
 //afrTime=tz.TZDateTime.from(DateTime.now(), tz.getLocation(afrLocation.toString()));
    
    //print('africa $afrTime');
  }
  String timeDifference(DateTime formattedDate){
    var dur = DateTime.now().difference(formattedDate);
    var isSameDay=DateTime.now().day.compareTo(formattedDate.day);
    String text="";
    if(isSameDay==0){
      if(!dur.isNegative){
        text=' ${dur.inHours} hrs ${dur.inMinutes-dur.inHours*60} min behind ';
      }
      else{
        text=' ${-dur.inHours} hrs ${-dur.inMinutes+dur.inHours*60} min ahead ';
      }
    }
    else{
      if(!dur.isNegative){

        text='Yesterday, ${dur.inHours} hrs ${dur.inMinutes-dur.inHours*60} min behind ';
      }
      else{
        text='Tomorrow, ${-dur.inHours} hrs ${-dur.inMinutes+dur.inHours*60} min ahead ';
      }
    }
    return text;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Clock',style:TextStyle(color: Colors.white) ,),
      ),
      body: Container(
        color: Colors.black,
        child: ListView(  
          children: <Widget>[
            Container(height: 50,),
            TimerBuilder.periodic(
                  Duration(minutes: 1),
                  builder:(ctx) {
                    var frDateString=DateFormat('yyyy-MM-dd hh:mm:ss').parse(DateTime.now().toString());
                   var resdt=DateFormat('E,d MMM').format(frDateString);
                   var resTime=DateFormat('jm').format(frDateString);
                    return Center(
                    child: Column(
                      children:[
                        Text(' $resTime',style: TextStyle(fontSize: 50,color: Colors.lightBlue)),
                        Text(' $resdt',style: TextStyle(fontSize: 20,color: Colors.white),),
                      ]                    
                    )
                    );
              }
            ),
            Divider(thickness: 1,),
            TimerBuilder.periodic(
              Duration(minutes: 1),
               builder:(ctx){
                 var afTime=tz.TZDateTime.from(DateTime.now(), tz.getLocation(afrLocation.toString()));
                

                 var formattedDate=DateFormat('yyyy-MM-dd hh:mm:ss').parse(afTime.toString());
                //bool isAfter=DateTime.now().isAfter(formattedDate);
                
                
                 var frDateString=DateFormat('jm').format(formattedDate);
                 return Center(
                child: ListTile(
                  title: Text('Africa',style:TextStyle(color: Colors.white,fontSize: 20),),
                  subtitle: Text(timeDifference(formattedDate),style:TextStyle(color: Colors.grey)),
                      trailing: Text(
                    ' $frDateString ',style: TextStyle(fontSize: 30,color: Colors.white),
                  ),
                ),
              );}
            ),
            TimerBuilder.periodic(
              Duration(minutes: 1),
               builder:(ctx){
                 var afTime=tz.TZDateTime.from(DateTime.now(), tz.getLocation(america.toString()));
                

                 var formattedDate=DateFormat('yyyy-MM-dd hh:mm:ss').parse(afTime.toString());
                 
                 var frDateString=DateFormat('jm').format(formattedDate);
                 return Center(
                child: ListTile(
                  title: Text('New York',style:TextStyle(color: Colors.white,fontSize: 20)),
                  subtitle: Text(timeDifference(formattedDate),style:TextStyle(color: Colors.grey)),
                      trailing: Text(
                    ' $frDateString ',style: TextStyle(fontSize: 30,color: Colors.white),
                  ),
                ),
              );}
            ),
            TimerBuilder.periodic(
              Duration(minutes: 1),
               builder:(ctx){
                 var afTime=tz.TZDateTime.from(DateTime.now(), tz.getLocation(japan.toString()));
                

                 var formattedDate=DateFormat('yyyy-MM-dd hh:mm:ss').parse(afTime.toString());
                 
                 var frDateString=DateFormat('jm').format(formattedDate);
                 return Center(
                child: ListTile(
                  title: Text('Tokyo',style:TextStyle(color: Colors.white,fontSize: 20)),
                  subtitle: Text(timeDifference(formattedDate),style:TextStyle(color: Colors.grey)),
                      trailing: Text(
                    ' $frDateString ',style: TextStyle(fontSize: 30,color: Colors.white),
                  ),
                ),
              );}
            ),
            
          ],
        ),
      ),
      
    );
  }
}
