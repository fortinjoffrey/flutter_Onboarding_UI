import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onboarding_ui/utilities/styles.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _nbPages = 3;
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _nbPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => print('Skip'),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 500,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: [
                      _buildPageInPageView(
                        imagePath: 'assets/images/onboarding0.png',
                        title: 'Connect people\naround the world',
                        body:
                            'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                      ),
                      _buildPageInPageView(
                        imagePath: 'assets/images/onboarding1.png',
                        title: 'Live your life\nsmarter with us',
                        body:
                            'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                      ),
                      _buildPageInPageView(
                        imagePath: 'assets/images/onboarding2.png',
                        title: 'Get a new experience\nof imagination',
                        body:
                            'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _buildPrevNextPageRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildPrevNextPageRow() {
    final bool isFirstPage = _currentPage == 0;
    final bool isLastPage = _currentPage == _nbPages - 1;

    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Row(
          children: [
            !isFirstPage ? _buildPrevPageButton() : Text(''),
            Spacer(),
            !isLastPage ? _buildNextPageButton() : Text(''),
          ],
        ),
      ),
    );
  }

  FlatButton _buildNextPageButton() {
    return FlatButton(
      onPressed: () {
        _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Next'.toUpperCase(),
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          SizedBox(width: 10.0),
          Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 22.0,
          ),
        ],
      ),
    );
  }

  FlatButton _buildPrevPageButton() {
    return FlatButton(
      onPressed: () {
        _pageController.previousPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 22.0,
          ),
          SizedBox(width: 10.0),
          Text(
            'Prev'.toUpperCase(),
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  Widget _buildPageInPageView({
    @required String imagePath,
    @required String title,
    @required String body,
  }) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image(
              image: AssetImage(imagePath),
              height: 200,
              width: 200,
            ),
          ),
          SizedBox(height: 30.0),
          Text(title, style: kTitleStyle),
          SizedBox(height: 15.0),
          Text(body, style: kSubtitleStyle),
        ],
      ),
    );
  }
}
