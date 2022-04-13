import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import '../app/managers/hive_manager.dart';
import '../core/extensions/context_extensions.dart';
import '../core/extensions/int_extensions.dart';
import '../main.dart';
import 'authenticate/authenticate_view.dart';
import 'main/view/main_screen.dart';

class Onboarding extends StatefulWidget {
  Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final List<OnBoardModel> onBoardData = [
    const OnBoardModel(
      title: "Hello, Welcome to Carafe",
      description: "",
      imgUrl: 'assets/images/splash.png',
    ),
    const OnBoardModel(
      title: "Share what you want",
      description: "Share what you want with your followers",
      imgUrl: 'assets/images/post.png',
    ),
    const OnBoardModel(
      title: "Explore other people",
      description: "Search and explore other peoples",
      imgUrl: 'assets/images/search.png',
    ),
    const OnBoardModel(
      title: "Get notification",
      description:
          "You will be notified when your posts are liked and commented on. (You can turn it off from settings)",
      imgUrl: 'assets/images/notifications.png',
    ),
    const OnBoardModel(
      title: "Lets start",
      description: "If you are ready, let's start by signup first",
      imgUrl: 'assets/images/authenticate.png',
    ),
  ];

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnBoard(
        pageController: controller,
        onBoardData: onBoardData,
        titleStyles: titleStyle,
        descriptionStyles: descriptionStyle,
        pageIndicatorStyle: pageIndicatorStyle,
        skipButton: buildSkipButton,
        nextButton: buildNextButton,
      ),
    );
  }

  TextStyle? get titleStyle {
    return context.theme.textTheme.headline6?.copyWith(
      color: context.colorScheme.primary,
      fontSize: context.width / 20,
      fontWeight: FontWeight.w900,
      letterSpacing: 0.15,
    );
  }

  TextStyle? get descriptionStyle {
    return context.theme.textTheme.headline6?.copyWith(
      fontSize: context.width / 24,
      color: Colors.brown.shade300,
    );
  }

  PageIndicatorStyle get pageIndicatorStyle {
    return PageIndicatorStyle(
      width: 100,
      inactiveColor: context.colorScheme.secondary,
      activeColor: context.colorScheme.secondary,
      inactiveSize: const Size(8, 8),
      activeSize: const Size(12, 12),
    );
  }

  Widget get buildSkipButton {
    return TextButton(
      onPressed: () => pushAuthenticateAndRemoveAll(),
      child: Text(
        "Skip",
        style: context.theme.textTheme.headline6?.copyWith(
          fontSize: context.width / 24,
          color: context.colorScheme.secondary,
        ),
      ),
    );
  }

  Future<void> pushAuthenticateAndRemoveAll() async {
    await closeFirstInit();
    if (mainVm.auth.currentUser != null) {
      mainVm.pushAndRemoveAll(page: const MainScreen());
    } else {
      mainVm.pushAndRemoveAll(page: AuthenticateView());
    }
  }

  Future<void> closeFirstInit() async {
    await HiveManager.closeFirstInit();
  }

  Widget get buildNextButton {
    return OnBoardConsumer(
      builder: (context, ref, child) {
        final state = ref.watch(onBoardStateProvider);
        return InkWell(
          borderRadius: 30.radiusAll,
          onTap: () => nextButtonPressed(state),
          child: Container(
            width: 230,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: 30.radiusAll,
              color: context.colorScheme.primary,
            ),
            child: buildNextButtonText(state),
          ),
        );
      },
    );
  }

  Widget buildNextButtonText(OnBoardState state) {
    return Text(
      state.isLastPage ? "Lets Start" : "Next",
      style: context.theme.textTheme.headline6?.copyWith(
        fontSize: context.width / 24,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void nextButtonPressed(OnBoardState state) {
    if (!state.isLastPage) {
      controller.animateToPage(
        state.page + 1,
        duration: 250.durationMilliseconds,
        curve: Curves.easeInOut,
      );
    } else {
      pushAuthenticateAndRemoveAll();
    }
  }

  @override
  void dispose() {
    closeFirstInit();
    super.dispose();
  }
}
