import 'package:event_bus/event_bus.dart';

/**
 * Created by YHF at 15:12 on 2022-05-09.
 */
 
class GlobalEventBus{
  static EventBus event = new EventBus();

}

class WineItemRefresh{
  WineItemRefresh();
}

class TabBarRefresh{
  TabBarRefresh();
}

class ConnectEvent{
  String? roomIp;
  ConnectEvent(this.roomIp);
}

class HomeHproseConnect{
  HomeHproseConnect();
}

class OrderPageRefresh{
  int mainTypeCheckOffset = 0;
  OrderPageRefresh();
}

class CurrentPageRefresh{
  String currentPage = "";
  CurrentPageRefresh();
}

class MenuItemRefresh{
  MenuItemRefresh();
}