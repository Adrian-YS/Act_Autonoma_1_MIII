import 'package:autonoma_1/navigation/drawer.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; 

class MiLista2 extends StatelessWidget {
  const MiLista2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Video Juegos"),
          Expanded(child: videoJuegos("https://jritsqmet.github.io/web-api/video_juegos.json"))
        ],
      ),
      drawer: MiDrawer(),
    );
  }
}

Future <List> jsonVideoJuegos(url) async{
  final response = await http.get(Uri.parse(url));
  if(response.statusCode == 200){
   final data = json.decode(response.body);
   return data['videojuegos'];
  }else{
    throw Exception("ERROR");
  }
}

Widget videoJuegos(url){
  return FutureBuilder(future: jsonVideoJuegos(url), builder: (context, snapshot){
    if(snapshot.hasData){
      final data = snapshot.data!;
      return ListView.builder(itemCount: data.length, itemBuilder: (context, index){
        final item = data[index];
        return ListTile(
          title: Column(
            children: [
              Text("${item['titulo']}"),
              Image.network(item['imagen'], width: 100)
            ],
          ),
        );
      });
    }else{
      return Text("Data no Encontrada");
    }
  });
}