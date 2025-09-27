class OnboardingContents {
  final String title;
  final String desc;
  final String image;

  OnboardingContents({
    required this.title,
    required this.desc,
    required this.image,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Welcome",
    image: "assets/images/onboarding_1.png",
    desc: "Welcome to our app! Here is a brief introduction.",
  ),
  OnboardingContents(
    title: "Track",
    image: "assets/images/onboarding_2.png",
    desc: "Track your tasks easily and efficiently.",
  ),
  OnboardingContents(
    title: "Get Started",
    image: "assets/images/onboarding_3.png",
    desc: "Track your tasks easily and efficiently.",
  ),
];
