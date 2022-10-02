import 'package:rxdart/rxdart.dart';

class NavigationService {
  final BehaviorSubject<String> _pathSubject = BehaviorSubject();

  ValueStream<String> getPath() {
    return _pathSubject;
  }

  changePath(String newPath) {
    _pathSubject.sink.add(newPath);
  }
}
