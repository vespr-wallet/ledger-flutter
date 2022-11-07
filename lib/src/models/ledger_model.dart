import 'package:ledger_flutter/src/algorand/algorand_public_key_operation.dart';
import 'package:ledger_flutter/src/ledger.dart';
import 'package:ledger_flutter/src/ledger/ledger_ble_connection_manager.dart';

typedef PermissionRequestCallback = Future<bool> Function();

class Ledger {
  final LedgerOptions _options;
  final BleConnectionManager _bleConnectionManager;
  final PermissionRequestCallback? onPermissionRequest;

  Ledger({
    required LedgerOptions options,
    this.onPermissionRequest,
    BleConnectionManager? bleConnectionManager,
  })  : _options = options,
        _bleConnectionManager = bleConnectionManager ??
            LedgerBleConnectionManager(
              options: options,
              onPermissionRequest: onPermissionRequest,
            );

  Stream<LedgerDevice> scan({String? filteredAddress}) =>
      _bleConnectionManager.scan(filteredAddress: filteredAddress);

  Future<void> connect(LedgerDevice device) =>
      _bleConnectionManager.connect(device);

  Future<void> disconnect(LedgerDevice device) =>
      _bleConnectionManager.disconnect(device);

  Future<void> stop() => _bleConnectionManager.stop();

  Future<void> dispose() => _bleConnectionManager.dispose();

  Future<String> getAccounts(LedgerDevice device) => _bleConnectionManager
      .sendRequest<String>(device, AlgorandPublicKeyOperation(accountIndex: 0));
}