import 'dart:developer' as developer;

import 'package:app_template/features/demo/data/demo_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/share/widgets/sized_spaces.dart';
import '../../../../core/share/widgets/waiting_view.dart';
import '../../data/CurrentWeatherData.dart';
import '../../domain/get_current_weather_data.dart';
import '../../providers/location_helpers.dart';

class DemoPage extends ConsumerStatefulWidget {
  const DemoPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  ConsumerState<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends ConsumerState<DemoPage> {
  int _counter = 0;
  bool _showFloatingButton = true;

  // final GetCurrentWeatherDataArgs _getCurrentWeatherDataArgs =
  //     const GetCurrentWeatherDataArgs();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    // _placesFilteringArgs = widget.placesFilterArgs ??
    //     PlacesFilterArgs(mode: PlacesFilterMode.upcoming);
    ref.read(positionProvider);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<Position> currentPosition = ref.watch(positionProvider);

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // mainAxisAlignment: MainAxisAlignment.center,
        // children: <Widget>[
        child: currentPosition.when(
          loading: () => const CircularProgressIndicator(),
          //const Expanded(child: WaitingView()),
          error: (error, stack) {
            setState(() {
              _showFloatingButton = false;
            });
            return Expanded(
                child: WaitingView(
              message: "Error: ${error.toString()}",
              // duration: const Duration(seconds: 1),
              color: Colors.red,
              infoIcon: const WarningSign(
                color: Colors.red,
              ),
            ));
          },
          data: (currentPosition) {
            final getCurrentWeatherDataArgs = GetCurrentWeatherDataArgs(
                latitude: currentPosition.latitude,
                longitude: currentPosition.longitude);
            AsyncValue<CurrentWeatherData> currentWeatherData = ref.watch(
                getCurrentWeatherDataProvider(getCurrentWeatherDataArgs));
            return currentWeatherData.when(
                data: (currentWeatherData) {
                  return Column(
                    children: [
                      const Text("Your geo position is:"),
                      Text(
                          "latitude: ${DemoConfig.lastKnownPosition?.latitude}"),
                      Text(
                          "longitude: ${DemoConfig.lastKnownPosition?.longitude}"),
                      const VSpacer(20),
                      const Text("Current weather is:"),
                      Text("City: ${currentWeatherData.name}"),
                      Text("Temp: ${currentWeatherData.main?.temp}"),
                      const VSpacer(20),
                      const Text(
                        'You have pushed the button this many times:',
                      ),
                      Text(
                        '$_counter',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const VSpacer(20),
                      _buildWaitingViewButton(context),
                      _buildWaitingViewWithDurationButton(context),
                      _buildWaitingViewLongMessageErrorButton(context),
                    ],
                  );
                },
                error: (error, stack) {
                  setState(() {
                    _showFloatingButton = false;
                  });
                  return Expanded(
                    child: WaitingView(
                      message: "Error: ${error.toString()}",
                      // duration: const Duration(seconds: 1),
                      color: Colors.red,
                      infoIcon: const WarningSign(
                        color: Colors.red,
                      ),
                    ),
                  );
                },
                loading: () => const CircularProgressIndicator());
          },
        ),
        // ],
      ),
      floatingActionButton: Visibility(
        visible: _showFloatingButton,
        replacement: Container(),
        child: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildWaitingViewLongMessageErrorButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          final arguments = WaitingViewArgs(
            message: """
Test waiting view as warning message
     Test waiting view as warning message
              Test waiting view as warning message
                              Test waiting view as warning message
Test waiting view as warning message
  Test waiting view as warning message
    Test waiting view as warning message
Test waiting view as warning message. Test waiting view as warning message. Test waiting view as warning message. Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
     Test waiting view as warning message
              Test waiting view as warning message
                              Test waiting view as warning message
Test waiting view as warning message
  Test waiting view as warning message
    Test waiting view as warning message
Test waiting view as warning message. Test waiting view as warning message. Test waiting view as warning message. Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
     Test waiting view as warning message
              Test waiting view as warning message
                              Test waiting view as warning message
Test waiting view as warning message
  Test waiting view as warning message
    Test waiting view as warning message
Test waiting view as warning message. Test waiting view as warning message. Test waiting view as warning message. Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
     Test waiting view as warning message
              Test waiting view as warning message
                              Test waiting view as warning message
Test waiting view as warning message
  Test waiting view as warning message
    Test waiting view as warning message
Test waiting view as warning message. Test waiting view as warning message. Test waiting view as warning message. Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
               """,
            // duration: const Duration(seconds: 0),
            color: Colors.red,
            infoIcon: const WarningSign(
              color: Colors.red,
            ),
          );
          Navigator.pushNamed(context, AppRoutes.waitingView,
              arguments: arguments);
        });
      },
      child: const Text(
        "Test waiting view as warning message",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildWaitingViewWithDurationButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          developer.log("Test waiting view pushed", name: "WaitingView");
          final arguments = WaitingViewArgs(
            message: "Test waiting view with Duration",
            duration: const Duration(seconds: 5),
          );
          Navigator.pushNamed(context, AppRoutes.waitingView,
              arguments: arguments);
        });
      },
      child: const Text(
        "Test waiting view with Duration",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildWaitingViewButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          developer.log("Test waiting view", name: "WaitingView");
          Navigator.pushNamed(context, AppRoutes.simpleWait,
              arguments: "Test waiting view");
        });
      },
      child: const Text(
        "Test waiting view",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

