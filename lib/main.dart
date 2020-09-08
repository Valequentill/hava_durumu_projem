import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'utils.dart' as util;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(
    new MaterialApp(
      title: 'Hava Durumu',
      home: new HavaDurumu(),
    )
  );
}

class HavaDurumu extends StatefulWidget {
  @override
  _HavaDurumuState createState() => _HavaDurumuState();
}

class _HavaDurumuState extends State<HavaDurumu> {
  final _cityName = TextEditingController();
  var gunler = ['1 gun', '5 gun', '16 gun'];
  var aktifgun = '1 gun';

  getItemAndNavigate(BuildContext context){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Sonuc(
              sehiradi : _cityName.text,
              gunsec: aktifgun,
            ))
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(brightness: Brightness.light,
        title: new Text('Hava Durumu'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset('assets/foto1.png',
            width: 500.0,
            height: 1200.0,
            fit: BoxFit.fill,),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 150.0, 0.0, 0.0),
            child: new Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: new Column(
                  children: <Widget>[
                    new ListTile(
                      title: new TextField(cursorColor: Colors.white,controller: _cityName,
                      decoration: new InputDecoration(
                        labelText: '                Şehir Adı Giriniz',
                        labelStyle: TextStyle(color: Colors.black)
                      ),),
                    ),
                    new DropdownButton<String>(iconEnabledColor: Colors.black,
                        items: gunler.map((String dropDownStringItem){
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (String newValueSelected){
                          _onDropDownItemSelected(newValueSelected);
                        },
                    value: aktifgun,),
                    new ListTile(
                      title: new RaisedButton(
                        onPressed: ()=> getItemAndNavigate(context),
                        child: new Text('Bul!'),
                        textColor: Colors.white,
                        color: Colors.blueAccent,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,);
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this.aktifgun = newValueSelected;
    });
  }

}




class Sonuc extends StatelessWidget {
  var sehiradi;
  var gunsec;
  final now = DateTime.now();
  get bugun => DateTime(now.year, now.month, now.day);
  get bugunarti1 => DateTime(now.year, now.month, now.day + 1);
  get bugunarti2 => DateTime(now.year, now.month, now.day + 2);
  get bugunarti3 => DateTime(now.year, now.month, now.day + 3);
  get bugunarti4 => DateTime(now.year, now.month, now.day + 4);
  get bugunarti5 => DateTime(now.year, now.month, now.day + 5);
  get bugunarti6 => DateTime(now.year, now.month, now.day + 6);
  get bugunarti7 => DateTime(now.year, now.month, now.day + 7);
  get bugunarti8 => DateTime(now.year, now.month, now.day + 8);
  get bugunarti9 => DateTime(now.year, now.month, now.day + 9);
  get bugunarti10 => DateTime(now.year, now.month, now.day + 10);
  get bugunarti11 => DateTime(now.year, now.month, now.day + 11);
  get bugunarti12 => DateTime(now.year, now.month, now.day + 12);
  get bugunarti13 => DateTime(now.year, now.month, now.day + 13);
  get bugunarti14 => DateTime(now.year, now.month, now.day + 14);
  get bugunarti15 => DateTime(now.year, now.month, now.day + 15);





  Sonuc({
    Key key, @required this.sehiradi,
    this.gunsec
    
}) : super(key: key);
  
  goBack(BuildContext context){
    Navigator.pop(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.purple,
          title: Center(child: Text("Sonuç Ekranı")),
        ),
        body: new Stack(
          children: <Widget>[
            new Container(
              child: new FutureBuilder(
                future: HavaDurumuBul(util.apiId, sehiradi),
              builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
                  if(snapshot.hasData&& gunsec== '1 gun'){
                    Map content = snapshot.data;
                    return new Container(
                      child: new Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 150.0, 0.0, 0.0),
                            child: new ListTile(
                              title: new Text('Şehir: '+content['location']['name']+ '                         ' 'Tarih: '+ content['location']['localtime'] + '                ' + 'Sıcaklık: ' + content['current']['temp_c'].toString()+ '°C'+ '             Hissedilen Sıcaklık: '+content['current']['feelslike_c'].toString()+ '°C',
                              style: new TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 30.0,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w500
                              ),),
                            ),
                          )
                        ],
                      ),
                    );
                  }else if(snapshot.hasData&& gunsec == '5 gun'){
                    Map content = snapshot.data;
                    return new Container(
                      child: new Column(
                        children: <Widget>[
                          new Stack(
                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('Tarih: '+ bugun.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'En Düşük: '+content["list"][0]["main"]["temp_min"].toString()+ '°C'+'                          '+'En Yüksek: '+content["list"][0]["main"]["temp_max"].toString()+ '°C'+'  ''Hissedilen: '+content["list"][0]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  )
                                ],
                              ),
                              new Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('Tarih: '+ bugunarti1.day.toString() + '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'En Düşük: '+content["list"][8]["main"]["temp_min"].toString()+ '°C'+'                          '+'En Yüksek: '+content["list"][8]["main"]["temp_max"].toString()+ '°C'+'  ''Hissedilen: '+content["list"][8]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  )
                                ],
                              ),
                              new Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 140.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('Tarih: '+ bugunarti2.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'En Düşük: '+content["list"][16]["main"]["temp_min"].toString()+ '°C'+'                          '+'En Yüksek: '+content["list"][16]["main"]["temp_max"].toString()+ '°C'+'  ''Hissedilen: '+content["list"][16]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  )
                                ],
                              ),
                              new Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 210.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('Tarih: '+ bugunarti3.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'En Düşük: '+content["list"][24]["main"]["temp_min"].toString()+ '°C'+'                          '+'En Yüksek: '+content["list"][24]["main"]["temp_max"].toString()+ '°C'+'  '+'Hissedilen: '+content["list"][24]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  )
                                ],
                              ),
                              new Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 280.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('Tarih: '+ bugunarti4.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'En Düşük: '+content["list"][32]["main"]["temp_min"].toString()+ '°C'+'                          '+'En Yüksek: '+content["list"][32]["main"]["temp_max"].toString()+ '°C'+'  ''Hissedilen: '+content["list"][32]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ) ,
                    );

                  }else if(snapshot.hasData&& gunsec == '16 gun'){
                    Map content = snapshot.data;
                    return new Container(
                      child: new Column(
                        children: <Widget>[
                          new Stack(
                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Container(
                                    child: new Text('  Tarih: '+ bugun.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'Sıcaklık: '+content["list"][0]["main"]["feels_like"].toString() + '°C',
                                      style: new TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 20.0,
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.w500
                                      ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('  Tarih: '+ bugunarti1.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'Sıcaklık: '+content["list"][2]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('   Tarih: '+ bugunarti2.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'Sıcaklık: '+content["list"][4]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('   Tarih: '+ bugunarti3.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'Sıcaklık: '+content["list"][6]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('   Tarih: '+ bugunarti4.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'Sıcaklık: '+content["list"][8]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('   Tarih: '+ bugunarti5.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'Sıcaklık: '+content["list"][10]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('    Tarih: '+ bugunarti6.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'Sıcaklık: '+content["list"][12]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('Tarih: '+ bugunarti7.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'Sıcaklık: '+content["list"][14]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('    Tarih: '+ bugunarti8.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'Sıcaklık: '+content["list"][16]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('    Tarih: '+ bugunarti9.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'Sıcaklık: '+content["list"][18]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('    Tarih: '+ bugunarti10.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'Sıcaklık: '+content["list"][20]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('    Tarih: '+ bugunarti11.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'Sıcaklık: '+content["list"][22]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('    Tarih: '+ bugunarti12.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'Sıcaklık: '+content["list"][24]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('    Tarih: '+ bugunarti13.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'Sıcaklık: '+content["list"][26]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('Tarih: '+ bugunarti14.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'Sıcaklık: '+content["list"][28]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    child: new Container(
                                      child: new Text('    Tarih: '+ bugunarti15.day.toString()+ '.'+ bugun.month.toString()+ '.'+ bugun.year.toString() +'   '+'Sıcaklık: '+content["list"][30]["main"]["feels_like"].toString() + '°C',
                                        style: new TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500
                                        ),),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }

                  else{
                    return new Container();
                  }
              },),
            ),

            new Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 500.0, 0.0, 0.0),
                child: Center(
                  child: RaisedButton(
                    onPressed: ()=> goBack(context),
                    color: Colors.lightBlue,
                    textColor: Colors.white,
                    child: Text('Yeni Şehir İçin Tıklayın!'),

                  ),

                ),
              ),
            ),
          ],
        ),backgroundColor: Colors.black,

    );
  }
  Future<Map> HavaDurumuBul(String apiId, String _cityName) async {
    if (gunsec == '1 gun') {
      String apiUrl = 'http://api.weatherapi.com/v1/current.json?key=${util.apiId}&q=$_cityName&lang=tr';



      http.Response response = await http.get(apiUrl);
      return jsonDecode(response.body);
    }
    else if (gunsec == '5 gun'){
      String apiUrl = 'http://api.openweathermap.org/data/2.5/forecast?q=$_cityName&appid=${util.apiId2}&lang=tr&units=metric';

      http.Response response = await http.get(apiUrl);
      return jsonDecode(response.body);

    }

    else if (gunsec == '16 gun'){
      String apiUrl = 'http://api.openweathermap.org/data/2.5/forecast?q=$_cityName&appid=${util.apiId2}&lang=tr&units=metric';

      http.Response response = await http.get(apiUrl);
      return jsonDecode(response.body);
    }
  }
}

