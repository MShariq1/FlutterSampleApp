
abstract class Failure {
  const Failure();
}

// General failures
class ServerFailure extends Failure {
  final String message;
  const ServerFailure({this.message=''});
}

class CacheFailure extends Failure {
  const CacheFailure();
}