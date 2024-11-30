import 'dart:convert';
import 'package:autonoma_1/navigation/drawer.dart';
import 'package:flutter/material.dart';

class MiLista1 extends StatelessWidget {
  const MiLista1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListaLoL(),
    );
  }
}

class ListaLoL extends StatelessWidget {
  const ListaLoL({super.key});

  Future<List<dynamic>> cargarJson(BuildContext context) async {
    final String response =
        await DefaultAssetBundle.of(context).loadString('assets/personajes.json');
    return json.decode(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personajes de League of Legends"),
      ),
      body: FutureBuilder(
        future: cargarJson(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final personaje = data[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(
                      personaje["imagen"],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(personaje["nombre"]),
                    subtitle: Text(personaje["descripcion"]),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No se encontraron datos"));
          }
        },
      ),
      drawer: MiDrawer(),
    );
  }
}
