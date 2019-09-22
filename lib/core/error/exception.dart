// Exception classes to be used by Data layer

/// Exception thrown for the Server (external data source)
class ServerException implements Exception {}

/// Exception thrown for the Cache (internal data source)
class CacheException implements Exception {}
