import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:homework/model/model_bird.dart';
import 'package:homework/service/service_bird.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BirdAdapter());
  await Hive.openBox<Bird>('birds');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BirdScreen(),
    );
  }
}

class BirdScreen extends StatefulWidget {
  @override
  _BirdScreenState createState() => _BirdScreenState();
}

class _BirdScreenState extends State<BirdScreen> {
  final Box<Bird> birdBox = Hive.box<Bird>('birds');
  List<Bird> birdList = [];
  int displayCount = 5;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

void fetchData() async {
  try {
    List<Bird> birds = await apiService.fetchBirds();

    // Check if fetched birds list is empty
    if (birds.isEmpty) {
      throw Exception('Empty response from API');
    }

    print('Fetched birds: $birds');
    await birdBox.clear();
    await birdBox.addAll(birds);
    setState(() {
      birdList = birds;
    });
  } catch (e) {
    print('Error fetching birds from API: $e');
    print('Fetching data from Hive');
    setState(() {
      birdList = birdBox.values.toList();
    });
  }
  print('Bird list after fetch: $birdList');
}


  void loadMore() {
    setState(() {
      displayCount += 5;
    });
    print('Display count after load more: $displayCount');
  }

  void clearData() {
    setState(() {
      birdList = [];
      birdBox.clear();
    });
    print('Bird list after clear: $birdList');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Birds'),
      ),
      body: birdList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: birdList.length > displayCount ? displayCount : birdList.length,
              itemBuilder: (context, index) {
                final bird = birdList[index];
                return ListTile(
                  title: Text(bird.name),
                  subtitle: Text('${bird.family} - ${bird.order}'),
                );
              },
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: loadMore,
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: clearData,
            child: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
