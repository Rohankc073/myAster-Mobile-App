import 'dart:async';

import 'package:proximity_sensor/proximity_sensor.dart';

typedef ProximityCallback = void Function(bool isNear);

class ProximityDetector {
  StreamSubscription? _proximitySubscription;
  final ProximityCallback onProximityChange;

  ProximityDetector({required this.onProximityChange});

  void startListening() {
    _proximitySubscription = ProximitySensor.events.listen((int event) {
      bool isNear = event > 0;
      onProximityChange(isNear);
    });
  }

  void stopListening() {
    _proximitySubscription?.cancel();
  }
}
