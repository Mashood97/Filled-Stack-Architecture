import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (ctx, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(model.title),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text('Add'),
                    onPressed:  model.add,
                  ),
                  SizedBox(width: 10,),
                  RaisedButton(
                    child: Text('Sub'),
                    onPressed:  model.sub,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text('Mul'),
                    onPressed:  model.mul,
                  ),
                  SizedBox(width: 10,),
                  RaisedButton(
                    child: Text('Div'),
                    onPressed: model.div,
                  )
                ],
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
