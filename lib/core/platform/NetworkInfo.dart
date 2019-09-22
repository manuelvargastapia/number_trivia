/// Simple interface to get the current network status. It will be implemented by
/// Data level repositories.

// Because of this app will have to get data from external and internal sources
// (API and SharedPreferences for cached data), we need a mechanism to decide if
// the app is online or not to select the source. So, we've create an abstract
// class NetworkInfo, a new contract for this Repository implementation.

abstract class NetworkInfo {
  Future<bool> get isConnected;
}
