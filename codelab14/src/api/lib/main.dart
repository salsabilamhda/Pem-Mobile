import 'package:flutter/material.dart';
import 'httphelper.dart';
import 'pizza.dart';
import 'pizza_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Soal 1: Identitas
      title: 'Flutter JSON Demo - Salsa',
      theme: ThemeData(
        // Soal 1: Warna Deep Orange
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Gunakan variabel future agar tidak reload terus menerus
  late Future<List<Pizza>> futurePizzas;

  @override
  void initState() {
    super.initState();
    futurePizzas = callPizzas();
  }

  Future<List<Pizza>> callPizzas() async {
    HttpHelper helper = HttpHelper();
    List<Pizza> pizzas = await helper.getPizzaList();
    return pizzas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Soal 1: Identitas di AppBar
        title: const Text('JSON - Salsa'),
      ),
      body: FutureBuilder(
        future: futurePizzas,
        builder: (BuildContext context, AsyncSnapshot<List<Pizza>> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: (snapshot.data == null) ? 0 : snapshot.data!.length,
            itemBuilder: (BuildContext context, int position) {
              // Praktikum 4 & Soal 4: Widget Dismissible untuk hapus
              return Dismissible(
                key: Key(snapshot.data![position].id.toString()),
                onDismissed: (direction) {
                  HttpHelper helper = HttpHelper();
                  // Hapus di backend
                  helper.deletePizza(snapshot.data![position].id);
                  // Hapus di list lokal
                  snapshot.data!.removeAt(position);
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Pizza deleted")),
                  );
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: ListTile(
                  title: Text(snapshot.data![position].pizzaName),
                  // Soal 2: Menampilkan Kategori
                  subtitle: Text(
                    '${snapshot.data![position].category} - ${snapshot.data![position].description} - € ${snapshot.data![position].price}',
                  ),
                  leading: const Icon(Icons.local_pizza),
                  onTap: () {
                    // Edit Mode (isNew: false)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PizzaDetailScreen(
                          pizza: snapshot.data![position],
                          isNew: false,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      // Tombol Tambah (isNew: true)
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PizzaDetailScreen(
                pizza: Pizza(
                  id: 0,
                  pizzaName: '',
                  description: '',
                  price: 0.0,
                  imageUrl: '',
                  category: '',
                ),
                isNew: true,
              ),
            ),
          );
        },
      ),
    );
  }
}