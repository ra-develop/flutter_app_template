abstract class UseCase<P, T> {
  Future<T?> call({P? params});
}
