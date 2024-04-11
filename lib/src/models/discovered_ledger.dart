import 'dart:async';

import 'package:ledger_flutter/ledger_flutter.dart';

class DiscoveredLedger {
  final LedgerDevice device;
  final StreamSubscription? subscription;
  final List<Service> services;

  DiscoveredLedger({
    required this.device,
    required this.subscription,
    required this.services,
  });

  Future<void> disconnect() async {
    subscription?.cancel();
  }
}
