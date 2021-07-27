import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/counter_notifier.dart';
import 'package:provider_example/time_notifier.dart';
import 'package:provider_example/user_notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (_) => CounterNotifier(),
        ),
        FutureProvider(
          create: (_) => getUser(),
          initialData: "Fetching user data...",
        ),
      ], child: MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<String>(
          builder: (_, user, __) {
            return Text(user);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamProvider(
              create: (_) => getCurrentTime(),
              initialData: "Fetching current time...",
              child: Consumer<String>(
                builder: (_, currentTime, __) {
                  return Text(currentTime);
                },
              ),
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer<CounterNotifier>(
              builder: (_, notifier, __) {
                return Text(
                  notifier.counter.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CounterNotifier>(context, listen: false).increment();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
