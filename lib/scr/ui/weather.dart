

import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:mohamedElgamalWeatherTask/scr/ui/location.dart';
import '../../app_constants.dart';


enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class CurrentWeather extends StatefulWidget {

  @override
  WeatherDetails createState() => WeatherDetails();
}

class WeatherDetails extends State<CurrentWeather> {
  WeatherFactory weatherData;
  List<Weather> _data = [];
  AppState _state = AppState.NOT_DOWNLOADED;
  String cityName ;

  @override
  void initState() {
    super.initState();
    weatherData = new WeatherFactory(Keywether);
  }
 @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
          appBar: AppBar(
            title: Text(ParText),
            centerTitle: true,
                backgroundColor:App_BLUE_Color
          ),



          body: Column(
            children: <Widget>[
              _coordinateInputs(),
              _buttons(),
              
             

              
              Divider(
                height: 20.0,
                thickness: 2.0,
              ),
              Expanded(child: _resultView())
            ],
          ),
         
                   );
           }



  Widget _coordinateInputs() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              margin: EdgeInsets.all(5),
              child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: Enter_City_Name),
                     
                  keyboardType: TextInputType.name,
                  onChanged: _saveCity,
                  onSubmitted: _saveCity)),
        ),
    
      ],
    );
  }

  Widget _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          child: FlatButton(
            child: Text(
              Weather_Today,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: queryWeather,
            color: App_BLUE_Color,
          ),
        ),
        Container(
            margin: EdgeInsets.all(5),
            child: FlatButton(
              child: Text(
                Weather_the_Next_days,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: queryForecast,
              color:App_BLUE_Color,
            ))
      ],
    );
  }

      Widget _resultView() => _state == AppState.FINISHED_DOWNLOADING
      ? contentFinishedDownload()
      : _state == AppState.DOWNLOADING
          ? contentDownloading()
          : contentNotDownloaded();


  void queryForecast() async {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _state = AppState.DOWNLOADING;
    });

    List<Weather> forecasts = await weatherData.fiveDayForecastByCityName(cityName);
    setState(() {
      _data = forecasts;
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  void queryWeather() async {
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _state = AppState.DOWNLOADING;
    });

    Weather weather = await weatherData.currentWeatherByCityName(cityName);
    setState(() {
      _data = [weather];
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }
  Widget contentFinishedDownload() {

    return
     Container(
    padding: new EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
    margin: EdgeInsets.symmetric(vertical: 6.0),

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: Colors.black),
    ),      child: ListView.separated(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return   GestureDetector(
               onTap: () {

            var cityName =  _data[index].areaName ;
            var latitude =  _data[index].latitude ;
            var longitude =  _data[index].longitude ;

              Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (_, __, ___) =>
                                         LocationPage( lat: latitude,long :longitude,cityName:"$cityName" ),
                  transitionsBuilder: (_, anim, __, child) =>
                      Container(child: child),
                  transitionDuration: Duration(seconds: 1)));

                
               },
               child: ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage(Earth_Image),),
            selected: true,
            title: _data[index] == null ? Text("") :
 Directionality(
                textDirection: TextDirection.rtl,
child:  Column(
     mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center
   ,
  children: [
                    Text("$Location : ${_data[index].areaName.toString()} ${_data[index].country.toString()} \n ", style: TextStyle(color: App_BLUE_Color).copyWith(fontSize: 19.0),textAlign :TextAlign.right )  ,
                    Text("$Temperature_Min ${_data[index].tempMin.toString()}", style: TextStyle().copyWith(fontSize: 19.0),textAlign :TextAlign.right ),
                    Text("$Temperature_Max ${_data[index].tempMax.toString()}", style: TextStyle().copyWith(fontSize: 19.0),textAlign :TextAlign.right ),
                    Text("$Weather_Description : ${_data[index].weatherDescription.toString()} \n $Date : ${_data[index].date.toString()}", style: TextStyle().copyWith(fontSize: 19.0),textAlign :TextAlign.right ),
                    Text("$Wind_Speed : ${_data[index].windSpeed.toString()}", style: TextStyle().copyWith(fontSize: 19.0),textAlign :TextAlign.right ) 
               

                
  ],))


          )
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),);
  
  }

  Widget contentDownloading() {
    return Container(
        margin: EdgeInsets.all(25),
        child: Column(children: [
          Text(
           Loading_Weather,
            style: TextStyle(fontSize: 20),
          ),
          Container(
              margin: EdgeInsets.only(top: 50),
              child: Center(child: CircularProgressIndicator(strokeWidth: 10)))
        ]));
  }

  Widget contentNotDownloaded() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
           Press_to_download,
          ),
        ],
      ),
    );
  }

 



  void _saveCity(String input) {
    cityName = input ;
   
    print(cityName);
  }
 
}