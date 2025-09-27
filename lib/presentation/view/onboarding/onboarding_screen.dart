import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2); // 3rd page = last
          },
          children: [
            buildPage(
              color: Colors.blue.shade100,
              title: "Welcome",
              subtitle: "This is how you use the app!",
            ),
            buildPage(
              color: Colors.green.shade100,
              title: "Track",
              subtitle: "Easily track your tasks and progress.",
            ),
            buildPage(
              color: Colors.orange.shade100,
              title: "Get Started",
              subtitle: "Let’s dive in 🚀",
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: Text("Skip"),
              onPressed: () async {
                await completeOnboarding();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => HomePage()),
                );
              },
            ),
            Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: WormEffect(dotHeight: 10, dotWidth: 10),
              ),
            ),
            isLastPage
                ? ElevatedButton(
                    child: Text("Get Started"),
                    onPressed: () async {
                      await completeOnboarding();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => HomePage()),
                      );
                    },
                  )
                : ElevatedButton(
                    child: Text("Next"),
                    onPressed: () {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildPage({
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Container(
      color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("onboarding_completed", true);
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text("Home Page")));
}
