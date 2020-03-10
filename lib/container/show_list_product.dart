import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ShowListProduct extends StatefulWidget {
  @override
  _ShowListProductState createState() => _ShowListProductState();
}

class _ShowListProductState extends State<ShowListProduct> {

//field

String urlAPI = 'http://jsonplaceholder.typicode.com/photos';



//method

@override
void initState(){

  super.initState();
  readJSON();


}

Future<void> readJSON()async{

  try {
    
   Response response = await Dio().get(urlAPI);
   print('response = $response');

  } catch (e) {
  }
}


  @override
  Widget build(BuildContext context) {
    return Text('Ths is ListProduct');
  }
}
