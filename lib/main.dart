import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

//When we are working with a single provider

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => ObjectProvider(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: const HomePage(),
//       ),
//     );
//   }
// }

// @immutable
// class BaseObject {
//   final String id;
//   final String lastUpdated;

//   //whenever an object would be created, it'll will have an uuid and current time
//   //we don't need to initialize these values by ourselves
//   BaseObject()
//       : id = const Uuid().v4(),
//         lastUpdated = DateTime.now().toIso8601String();

//   //we override == operator to check if two objects have same data or not
//   @override
//   bool operator ==(covariant BaseObject other) => id == other.id;

//   @override
//   int get hashCode => id.hashCode;
// }

// class ExpensiveObject extends BaseObject {}

// class CheapObject extends BaseObject {}

// //Provider Class
// class ObjectProvider extends ChangeNotifier {
//   late String id;
//   late CheapObject _cheapObject;
//   late StreamSubscription _cheapObjectStreamSubs;
//   late ExpensiveObject _expensiveObject;
//   late StreamSubscription _expensiveObjectStreamSubs;

//   CheapObject get cheapObject => _cheapObject;
//   ExpensiveObject get expensiveObject => _expensiveObject;

//   //Constructor
//   ObjectProvider()
//       : id = const Uuid().v4(),
//         _cheapObject = CheapObject(),
//         _expensiveObject = ExpensiveObject() {
//     start();
//   }

//   //whenever we call notifyListeners(), we will reset our "id" field
//   @override
//   void notifyListeners() {
//     id = const Uuid().v4();
//     super.notifyListeners();
//   }

//   void start() {
//     _cheapObjectStreamSubs = Stream.periodic(
//       const Duration(seconds: 1),
//     ).listen((_) {
//       _cheapObject = CheapObject();
//       notifyListeners();
//     });
//     _expensiveObjectStreamSubs = Stream.periodic(
//       const Duration(seconds: 10),
//     ).listen((_) {
//       _expensiveObject = ExpensiveObject();
//       notifyListeners();
//     });
//   }

//   void stop() {
//     _cheapObjectStreamSubs.cancel();
//     _expensiveObjectStreamSubs.cancel();
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(children: [
//         Row(
//           children: const [
//             Expanded(child: CheapWidget()),
//             Expanded(child: ExpensiveWidget())
//           ],
//         ),
//         Row(
//           children: const [Expanded(child: ObjectProviderWidget())],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             TextButton(
//               onPressed: () {
//                 context.read<ObjectProvider>().start();
//               },
//               child: const Text("Start"),
//             ),
//             TextButton(
//               onPressed: () {
//                 context.read<ObjectProvider>().stop();
//               },
//               child: const Text("Stop"),
//             ),
//           ],
//         ),
//       ]),
//     );
//   }
// }

// class CheapWidget extends StatelessWidget {
//   const CheapWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //here we have a selected a particular field to watch for changes and rebuild
//     //iteself if any change is encountered
//     final cheapObject = context.select<ObjectProvider, CheapObject>(
//       (provider) => provider.cheapObject,
//     );
//     return Container(
//       height: 100,
//       color: Colors.yellow,
//       child: Column(
//         children: [
//           const Text("Cheap Widget"),
//           const Text("Last Updated"),
//           Text(cheapObject.lastUpdated),
//         ],
//       ),
//     );
//   }
// }

// class ExpensiveWidget extends StatelessWidget {
//   const ExpensiveWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //here we have a selected a particular field to watch for changes and rebuild
//     //widget if any change is encountered
//     final expensiveObject = context.select<ObjectProvider, ExpensiveObject>(
//       (provider) => provider.expensiveObject,
//     );
//     return Container(
//       height: 100,
//       color: Colors.blue,
//       child: Column(
//         children: [
//           const Text("Expensive Widget"),
//           const Text("Last Updated"),
//           Text(expensiveObject.lastUpdated),
//         ],
//       ),
//     );
//   }
// }

// class ObjectProviderWidget extends StatelessWidget {
//   const ObjectProviderWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //here we are watching the whole provider
//     //Any change in the provider will make the widget to rebuild
//     final provider = context.watch<ObjectProvider>();
//     return Container(
//       height: 100,
//       color: Colors.purple,
//       child: Column(
//         children: [
//           const Text("Object Provider Widget"),
//           const Text("ID"),
//           Text(provider.id),
//         ],
//       ),
//     );
//   }
// }

//When we are working with MultiProvider

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

//function to get current date and time
String now() => DateTime.now().toIso8601String();

@immutable
class Seconds {
  final String value;
  Seconds() : value = now();
}

class SecondsWidget extends StatelessWidget {
  const SecondsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final seconds = context.watch<Seconds>();
    return Expanded(
        child: Container(
      height: 100,
      color: Colors.yellow,
      child: Text(seconds.value),
    ));
  }
}

class MinutesWidget extends StatelessWidget {
  const MinutesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final minutes = context.watch<Minutes>();
    return Expanded(
        child: Container(
      height: 100,
      color: Colors.blue,
      child: Text(minutes.value),
    ));
  }
}

@immutable
class Minutes {
  final String value;
  Minutes() : value = now();
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomePage")),
      body: MultiProvider(
        providers: [
          StreamProvider.value(
              value: Stream<Seconds>.periodic(
                  const Duration(seconds: 1), (_) => Seconds()),
              initialData: Seconds()),
          StreamProvider.value(
              value: Stream<Minutes>.periodic(
                  const Duration(minutes: 1), (_) => Minutes()),
              initialData: Minutes()),
        ],
        child: Column(
          children: [
            Row(children: const [SecondsWidget(), MinutesWidget()]),
          ],
        ),
      ),
    );
  }
}
