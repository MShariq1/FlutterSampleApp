class ServerException implements Exception {
  final Object object;
  ServerException(this.object);
}

class CacheException implements Exception {}