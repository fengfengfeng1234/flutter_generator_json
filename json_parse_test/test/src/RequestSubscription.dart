

abstract class RequestSubscription<T>{

  RequestSubscription map<F, R>(R onData(F data));
}