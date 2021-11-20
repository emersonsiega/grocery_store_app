abstract class BasePresenter<T> {
  Stream<T> get stream;

  T get state;
}
