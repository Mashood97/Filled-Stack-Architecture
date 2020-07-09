import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterecommerceuserapp/ui/views/startup/startup_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatefulWidget {
  @override
  _StartUState createState() => _StartUState();
}

class _StartUState extends State<StartUpView>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  List<PageViewModel> _pages = [
    PageViewModel(
      title: 'Buy Products',
      body: 'Buy Products From Reputed Dealers',
      image: Center(child: Image.asset('assets/images/1.jpg')),
      decoration: PageDecoration(
        imagePadding: EdgeInsets.all(15),
        titleTextStyle: GoogleFonts.oswald(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 20,
          letterSpacing: 0.6,
        ),
        bodyTextStyle: GoogleFonts.raleway(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 20,
          letterSpacing: 0.6,
        ),
      ),
    ),
    PageViewModel(
      title: 'Safe Home Delivery',
      body: 'We deliver products safely at your door step',
      image: Image.asset('assets/images/2.jpg'),
      decoration: PageDecoration(
        imagePadding: EdgeInsets.all(15),
        titleTextStyle: GoogleFonts.oswald(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 20,
          letterSpacing: 0.6,
        ),
        bodyTextStyle: GoogleFonts.raleway(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 20,
          letterSpacing: 0.6,
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    _animation = ColorTween(begin: Color(0xFF371741), end: Colors.redAccent)
        .animate(_animationController);

    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.forward();
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse(from: 1);
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
        onModelReady: (model) => model.checkFirstSeen(),
        builder: (ctx, model, child) => Scaffold(
              body: IntroductionScreen(
                dotsDecorator: DotsDecorator(
                  size: const Size.square(10.0),
                  activeSize: const Size(20.0, 10.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  color: _animation.value,
                  activeColor: Theme.of(context).accentColor,
                ),
                done: FlatButton(
                  color: _animation.value,
                  textColor: Colors.white,
                  shape: StadiumBorder(),
                  splashColor: Theme.of(context).accentColor,
                  child: FittedBox(
                      child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.explore,
                        color: Colors.amber,
                        size: 45,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Explore",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontSize: 22),
                      ),
                    ],
                  )),
                  onPressed: () {
                    model.gotoSignIn();
                  },
                ),
                onDone: () {
                  model.gotoSignIn();
                },
                pages: _pages,
                animationDuration: 1000,
                curve: Curves.bounceInOut,
              ),
            ),
        viewModelBuilder: () => StartUpViewModel());
  }
}
