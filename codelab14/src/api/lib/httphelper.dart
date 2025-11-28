import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pizza.dart';

class HttpHelper {
  // PENTING: Ganti dengan domain WireMock milikmu sendiri!
  final String authority = 'm9y0e.wiremockapi.cloud'; 
  
  final String path = 'pizzalist';
  final String postPath = 'pizza';
  final String putPath = 'pizza';
  final String deletePath = 'pizza';

  // GET (Read)
  Future<List<Pizza>> getPizzaList() async {
    final Uri url = Uri.https(authority, path);
    final http.Response result = await http.get(url);

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      List<Pizza> pizzas =
          jsonResponse.map<Pizza>((i) => Pizza.fromJson(i)).toList();
      return pizzas;
    } else {
      return [];
    }
  }

  // POST (Create)
  Future<String> postPizza(Pizza pizza) async {
    String post = json.encode(pizza.toJson());
    Uri url = Uri.https(authority, postPath);
    http.Response result = await http.post(url, body: post);
    return result.body;
  }

  // PUT (Update)
  Future<String> putPizza(Pizza pizza) async {
    String put = json.encode(pizza.toJson());
    Uri url = Uri.https(authority, putPath);
    http.Response result = await http.put(url, body: put);
    return result.body;
  }

  // DELETE (Delete) - Praktikum 4
  Future<String> deletePizza(int id) async {
    // Di real API biasanya ID dikirim lewat URL (ex: /pizza/1), 
    // tapi kita ikuti tutorial WireMock yang menggunakan path /pizza saja.
    Uri url = Uri.https(authority, deletePath);
    http.Response result = await http.delete(url);
    return result.body;
  }
}