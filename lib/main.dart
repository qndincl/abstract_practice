bool pushEnabled = false;

abstract class Notifier {
  getNotifier() {}
  notify() {
    print("object");
  }
}

abstract class NotifierFactory {
  Notifier getNotifier();

  static NotifierFactory instance() {
    return DefaultNotifierFactory();
  }
}

class DefaultNotifierFactory implements NotifierFactory {
  @override
  Notifier getNotifier() {
    if (pushEnabled) {
      print("kakao");
      return KakaoNotifier();
    } else {
      print("sms");
      return SMSNotifier();
    }
  }
}

class KakaoNotifier extends Notifier {}

class SMSNotifier extends Notifier {}

class EmailNotifier extends Notifier {}

class OrderCancelService {
  void cancel() {
    Notifier notifier = NotifierFactory.instance().getNotifier();
    notifier.notify();
  }
}

void main() {
  OrderCancelService order = OrderCancelService();
  OrderCancelService order2 = OrderCancelService();
  DefaultNotifierFactory def = DefaultNotifierFactory();
  DefaultNotifierFactory def2 = DefaultNotifierFactory();
  NotifierFactory factor = NotifierFactory.instance();
  NotifierFactory factor2 = NotifierFactory.instance();
  pushEnabled = true;

  void cancel() {
    order.cancel();
  }

  void checkHash({dynamic order, dynamic order2}) {
    var hash1 = order.hashCode;
    var hash2 = order2.hashCode;
    if (hash1 == hash2)
      print("$order is SingleTon");
    else
      print("$order2 is Not SingleTon");

    print("order hash = $hash1");
    print("order2 hash = $hash2");
  }

  cancel();
  checkHash(order: order, order2: order2);
  checkHash(order: factor, order2: factor2);
  checkHash(order: def, order2: def2);
}
