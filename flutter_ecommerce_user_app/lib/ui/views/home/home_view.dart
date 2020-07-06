import 'package:flutter/material.dart';
import 'package:flutterecommerceuserapp/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (ctx,model,child)=>Scaffold(),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
