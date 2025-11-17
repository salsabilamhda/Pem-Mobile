import 'package:flutter/material.dart';
// Langkah 2: Lakukan Import
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Storage Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SecureStorageScreen(),
    );
  }
}

class SecureStorageScreen extends StatefulWidget {
  const SecureStorageScreen({super.key});

  @override
  State<SecureStorageScreen> createState() => _SecureStorageScreenState();
}

class _SecureStorageScreenState extends State<SecureStorageScreen> {
  // Langkah 3: Tambahkan Variabel dan Controller
  final pwdController = TextEditingController();
  String myPass = '';

  // Langkah 4: Inisialisasi Secure Storage
  final storage = const FlutterSecureStorage();
  final myKey = 'myPass';
  
  // Langkah 5: Buat Method writeToSecureStorage()
  Future<void> writeToSecureStorage() async {
    // Menulis konten dari TextEditingController ke secure storage
    await storage.write(key: myKey, value: pwdController.text);
    // Kosongkan input setelah menyimpan
    pwdController.clear(); 
  }

  // Langkah 6: Buat Method readFromSecureStorage()
  Future<String> readFromSecureStorage() async {
    // Membaca data dari secure storage. Gunakan ?? '' untuk mengembalikan string kosong jika null.
    String? secret = await storage.read(key: myKey);
    return secret ?? '';
  }

  @override
  void dispose() {
    pwdController.dispose();
    super.dispose();
  }

  // Langkah 7 & 8: Perbarui build() untuk UI dan Logic
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secure Storage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Text Field untuk input kata sandi
            TextField(
              controller: pwdController,
              decoration: const InputDecoration(
                labelText: 'Enter secret value (e.g., password)',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),

            // Tombol "Save Value" (Langkah 7)
            ElevatedButton(
              onPressed: writeToSecureStorage,
              child: const Text('Save Value'),
            ),
            const SizedBox(height: 10),

            // Tombol "Read Value" (Langkah 8)
            ElevatedButton(
              onPressed: () {
                readFromSecureStorage().then((value) {
                  setState(() {
                    myPass = value;
                  });
                });
              },
              child: const Text('Read Value'),
            ),
            const SizedBox(height: 40),

            // Menampilkan nilai yang dibaca
            const Text(
              'Value Read from Secure Storage:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              myPass.isEmpty ? '(No value saved or read yet)' : myPass,
              style: TextStyle(fontSize: 18, color: myPass.isEmpty ? Colors.grey : Colors.green),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}