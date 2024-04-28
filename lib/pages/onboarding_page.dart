// lib/pages/Onboarding_page.dart

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tataguid/ui/LoginUi.dart';
import 'package:tataguid/widgets/onboarding_card.dart';
import 'package:tataguid/constants/constants.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> _onBoardingPages = [
      OnboardingCard(
        image: IntroConstants.image,
        title: IntroConstants.WelcomPage,
        description: IntroConstants.DESC,
        buttonText: Constants.NEXT,
        onPressed: () {
          _pageController.animateToPage(
            1,
            duration: Durations.long1,
            curve: Curves.linear,
          );
        },
      ),
      OnboardingCard(
        image: Constants1.image,
        title: Constants1.title,
        description: "here you can put a description",
        buttonText: Constants.NEXT,
        onPressed: () {
          _pageController.animateToPage(
            2,
            duration: Durations.long1,
            curve: Curves.linear,
          );
        },
      ),
      OnboardingCard(
        image: Constants2.image,
        title: 'Welcom to TataGuid',
        description: "here you can put a description",
        buttonText: Constants.NEXT,
        onPressed: () {
          _pageController.animateToPage(
            3,
            duration: Durations.long1,
            curve: Curves.linear,
          );
        },
      ),
      OnboardingCard(
        image: Constants3.image,
        title: 'Welcom to TataGuid',
        description: "here you can put a description",
        buttonText: Constants.DONE,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginUi()));
          // final authBloc = BlocProvider.of<AuthBloc>(context);
          //   authBloc.add(NavigateToLogin()); // Dispatch the event to navigate to LoginUi
          },
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: _onBoardingPages,
              ),
              ),
            SmoothPageIndicator(
              controller: _pageController,
              count: _onBoardingPages.length,
              effect: ExpandingDotsEffect(
                activeDotColor: Theme.of(context).colorScheme.primary,
                dotColor: Theme.of(context).colorScheme.secondary,
              ),
              onDotClicked: (index) {
                _pageController.animateToPage(
                  index,
                  duration: Durations.long1,
                  curve: Curves.linear,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
