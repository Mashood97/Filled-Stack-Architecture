import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterecommerceuserapp/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  Widget _getAndroidDesign(model, context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Khareed-Lo",
                    style: Theme.of(context).textTheme.headline6),
                background: Carousel(
                  autoplay: true,
                  animationCurve: Curves.easeInOut,
                  animationDuration: Duration(seconds: 5),
                  autoplayDuration: Duration(seconds: 5),
                  dotPosition: DotPosition.bottomRight,
                  showIndicator: true,
                  dotBgColor: Colors.transparent,
                  overlayShadow: true,
                  overlayShadowColors: Colors.black,
                  overlayShadowSize: 0.7,
                  images: [
                    NetworkImage(
                        'https://images.pexels.com/photos/135620/pexels-photo-135620.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
                    NetworkImage(
                        'https://images.pexels.com/photos/581339/pexels-photo-581339.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                    NetworkImage(
                        'https://images.pexels.com/photos/3769747/pexels-photo-3769747.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                  ],
                  boxFit: BoxFit.cover,
                ),
              ),
            ),
            SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: List.generate(
                50,
                (index) => Center(
                  child: Text('$index'),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: () {
          model.logoutUser();
        },
      ),
    );
  }

  Widget _getIosDesign() {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (ctx, model, child) => Platform.isAndroid
          ? _getAndroidDesign(model, context)
          : _getIosDesign(),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
