import 'package:splice/bean/element.dart';
import 'package:splice/bean/general.dart';

class ElementManager {
  // 工厂模式
  factory ElementManager() => _getInstance();

  static ElementManager get instance => _getInstance();
  static ElementManager _instance;

  ElementManager._internal() {
    _init();
  }

  static ElementManager _getInstance() {
    if (_instance == null) {
      _instance = ElementManager._internal();
    }
    return _instance;
  }

  void _init() async {
    elements = new List();
    elements.add(ElementBean(location: "assets/images/icon1.png"));
    elements.add(ElementBean(location: "assets/images/icon2.png"));
    elements.add(ElementBean(location: "assets/images/icon3.png"));
    elements.add(ElementBean(location: "assets/images/icon4.png"));
    elements.add(ElementBean(location: "assets/images/icon5.png"));
    elements.add(ElementBean(location: "assets/images/icon6.png"));
    elements.add(ElementBean(location: "assets/images/icon7.png"));
    elements.add(ElementBean(location: "assets/images/icon8.png"));
    elements.add(ElementBean(location: "assets/images/icon9.png"));
    elements.add(ElementBean(location: "assets/images/icon10.png"));
    elements.add(ElementBean(location: "assets/images/icon11.png"));
    elements.add(ElementBean(location: "assets/images/icon12.png"));
    elements.add(ElementBean(location: "assets/images/icon13.png"));
    elements.add(ElementBean(location: "assets/images/icon14.png"));
    elements.add(ElementBean(location: "assets/images/icon15.png"));
    elements.add(ElementBean(location: "assets/images/icon16.png"));
    elements.add(ElementBean(location: "assets/images/icon17.png"));
    elements.add(ElementBean(location: "assets/images/icon18.png"));
    elements.add(ElementBean(location: "assets/images/icon19.png"));
    elements.add(ElementBean(location: "assets/images/icon20.png"));
    elements.add(ElementBean(type: ElementType.ADD));
  }

  List<ElementBean> elements;
}
