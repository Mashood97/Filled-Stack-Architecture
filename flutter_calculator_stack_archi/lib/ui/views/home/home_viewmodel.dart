


import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel{

   double _result = 0.0;
  final String _title = 'Hello HomeView';

  String get title=> '$_title $_result';
//  double get result => _result;


  void add(){
   _result =  5.0 + 7.0;
    notifyListeners();
  }
  void sub(){
   _result =  5.0 - 7.0;
    notifyListeners();
  }
  void mul(){
   _result =  5.0 * 7.0;
    notifyListeners();
  }
  void div(){
   _result =  5.0 / 7.0;
    notifyListeners();
  }
}