import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter_/oyrenci.dart';

//flutter packages pub run build_runner build
//6:00
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter('uygulama');
//encrypted box
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  var containsEncryptionKey = await secureStorage.containsKey(key: 'key');

  if (!containsEncryptionKey) {
    var key = Hive.generateSecureKey();
    await secureStorage.write(key: 'key', value: base64UrlEncode(key));
  }
  var encryptionKey =
      base64Url.decode(await secureStorage.read(key: 'key') ?? 'ohhhhhhhh');
  debugPrint('encryptionKey Key: $encryptionKey');

  var sifreliQutu = await Hive.openBox('ozel',
      encryptionCipher: HiveAesCipher(encryptionKey));
  await sifreliQutu.put('secret', 'hive is cool');
  await sifreliQutu.put('sifre', '12345');

  debugPrint(sifreliQutu.get('secret'));
  debugPrint(sifreliQutu.get('sifre'));

  await Hive.openBox('test');
  Hive.registerAdapter(OyrenciAdapter());
  Hive.registerAdapter(GozRengAdapter());
  await Hive.openBox<Oyrenci>('oyrenciler');
  await Hive.openLazyBox<int>('sayilar');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;

  void _incrementCounter() async {
    var box = Hive.box('test');
    await box.clear();
    box.add('elsen'); //index[0]key 0 value elsen
    box.add('Hesenov'); //index[1] key 1 value hesenov
    box.add(true);
    box.add(123); // index 3 key 3 value 123
    // box.addAll(['liste1', 'liste2', false, 9532]);

    await box.put('tc', '123456789');
    await box.put('tema', 'dark');
    //await box.putAll({'araba': 'reno', 'il': 2020});

    /* box.values.forEach((element) {
      debugPrint(element.toString());
    }); */
    debugPrint(box.toMap().toString());
    debugPrint(box.get('tema')); //key ile erisim
    debugPrint(box.getAt(0)); //index ile erisim
    debugPrint(box.get(0)); //index ile erisim
    debugPrint(box.get('tc')); //key ile erisim
    debugPrint(box.getAt(4)); //index ile erisim
    debugPrint(box.length.toString());
    await box.delete('tc');
    await box.deleteAt(0);
    debugPrint(box.toMap().toString());
    await box.putAt(0, 'yeni deyer');
    debugPrint(box.toMap().toString());
  }

  void _customData() async {
    var elsen = Oyrenci(14, 'elsen', GozReng.mavi);
    var elcin = Oyrenci(11, 'elcin', GozReng.yasil);
    var box = Hive.box<Oyrenci>('oyrenciler');
    await box.clear();
    box.add(elsen);
    box.add(elcin);

    box.put('elsen', elsen);
    box.put('elcin', elcin);
    debugPrint(box.toMap().toString());
  }

  void _lazyAndEncrytedBox() async {
    var sayilar = Hive.lazyBox<int>('sayilar');
    for (int i = 0; i < 50; i++) {
      debugPrint((await sayilar.getAt(i)).toString());
    }

    //debugPrint(sayilar.toMap().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _lazyAndEncrytedBox, //_customData //_incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
