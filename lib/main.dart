import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PokemonScreen(),
    );
  }
}

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  String name = "";
  String image = "";

  Future<void> fetchPokemon() async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/pikachu');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        name = data['name'];
        image = data['sprites']['front_default'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Pokémon'),
      ),
      body: Center(
        child: name.isEmpty
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name.toUpperCase(),
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Image.network(image),
                ],
              ),
      ),
    );
  }
}