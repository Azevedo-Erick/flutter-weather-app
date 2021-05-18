import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      title: 'Weater App',
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var city;

  Future getWeather({String id}) async {
    http.Response response =
        await http.get(Uri.parse("https://api.hgbrasil.com/weather?woeid=$id"));
    //Woeid -> https://console.hgbrasil.com/documentation/weather/tools
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['results']['temp'];
      this.description = results['results']['description'];
      this.currently = results['results']['forecast'][0]['description'];
      this.humidity = results['results']['humidity'];
      this.windSpeed = results['results']['wind_speedy'];
      this.city = results['results']['city'];
    });
    setBgColor();
  }

  Color setBgColor() {
    if (this.temp > 25) {
      return Colors.red;
    } else if (this.temp <= 25 && this.temp > 10) {
      return Colors.blue;
    } else {
      return Colors.blue.shade900;
    }
  }

  @override
  void initState() {
    super.initState();
    this.getWeather(id: '455819');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              color: setBgColor(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    city != null ? city.toString() : "Carregando...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Carregando...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    currently != null ? currently.toString() : "Carregando...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(children: <Widget>[
              ListTile(
                leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                title: Text("Temperatura"),
                trailing: Text(temp != null
                    ? temp.toString() + "\u00B0"
                    : "Carregando..."),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.cloud),
                title: Text("Clima"),
                trailing: Text(description != null
                    ? description.toString()
                    : "Carregando..."),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.sun),
                title: Text("Umidade"),
                trailing: Text(
                    humidity != null ? humidity.toString() : "Carregando..."),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.wind),
                title: Text("Velocidade do vento"),
                trailing: Text(
                    windSpeed != null ? windSpeed.toString() : "Carregando..."),
              )
            ]),
          )),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                ListTile(
                  tileColor: Colors.white54,
                  leading: FaIcon(FontAwesomeIcons.home),
                  title: Text("Açailândia - MA"),
                  trailing: GestureDetector(
                    onTap: () {
                      getWeather(id: '456011');
                    },
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Colors.cyanAccent.shade700,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  tileColor: Colors.white54,
                  leading: FaIcon(FontAwesomeIcons.home),
                  title: Text("Palmas - TO"),
                  trailing: GestureDetector(
                    onTap: () {
                      getWeather(id: '457721');
                    },
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Colors.cyanAccent.shade700,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  tileColor: Colors.white54,
                  leading: FaIcon(FontAwesomeIcons.home),
                  title: Text("São Paulo - SP"),
                  trailing: GestureDetector(
                    onTap: () {
                      getWeather(id: '455827');
                    },
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Colors.cyanAccent.shade700,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  tileColor: Colors.white54,
                  leading: FaIcon(FontAwesomeIcons.home),
                  title: Text("Gramado - RS"),
                  trailing: GestureDetector(
                    onTap: () {
                      getWeather(id: '457224');
                    },
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Colors.cyanAccent.shade700,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
