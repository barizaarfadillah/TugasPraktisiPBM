import 'package:flutter/material.dart';
import 'package:flutter_application_1/weather.dart';
import 'data_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController controller = TextEditingController();
  DataService dataService = DataService();
  Weather weather = Weather();
  bool isFetch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isFetch
                ? Column(
                    children: [
                      Image.network(
                          'https://openweathermap.org/img/wn/${weather.icon}@2x.png'),
                      Text('${weather.temp}° F',
                          style: Theme.of(context).textTheme.headlineLarge),
                      Text(weather.description,
                          style: Theme.of(context).textTheme.headlineMedium)
                    ],
                  )
                : SizedBox(),
            Container(
              width: 150,
              padding: EdgeInsets.symmetric(vertical: 50),
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: "City"),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  isFetch = true;
                  weather = await dataService.fetchData(controller.text);
                  setState(() {});
                },
                child: Text('Search'))
          ],
        )));
  }
}
