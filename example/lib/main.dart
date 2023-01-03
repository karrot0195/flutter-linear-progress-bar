import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Builder(
          builder: (context) => const Scaffold(body: Sample()),
        ),
      ),
    );
  }
}

class Sample extends HookWidget {
  const Sample({Key? key}) : super(key: key);

  Widget get spaceH10 => const SizedBox(
        height: 10,
      );

  @override
  Widget build(BuildContext context) {
    final step = useState(0);
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text("step: ${step.value}"),
          ),
          spaceH10,
          LinearProgressBar(
            icons: const [
              Icon(Icons.list),
              Icon(Icons.book),
              Icon(Icons.heart_broken),
              Icon(Icons.phone),
              Icon(Icons.bookmark),
              Icon(Icons.add_a_photo),
              Icon(Icons.file_copy),
              Icon(Icons.public),
            ],
            currentIndex: step.value,
          ),
          spaceH10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => step.value = step.value - 1,
                child: const Text('Prev'),
              ),
              ElevatedButton(
                onPressed: () => step.value = step.value + 1,
                child: const Text('Next'),
              )
            ],
          )
        ],
      ),
    );
  }
}
