import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../core/services/injectable/injectable_service.dart';
import '../bloc/onboarding_bloc.dart';
import '../widgets/onboarding_page_content.dart';
import '../widgets/onboarding_progress_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OnboardingBloc>(),
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
        listenWhen: (prev, curr) => !prev.isCompleted && curr.isCompleted,
        listener: (context, state) {
          if (state.isCompleted) {
            context.go(RoutePaths.home);
          }
        },
        builder: (context, state) {
          final loc = AppLocalizations.of(context)!;

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextButton(
                        onPressed: () {
                          context
                              .read<OnboardingBloc>()
                              .add(const OnboardingSkipped());
                        },
                        child: Text(loc.onboardingSkip),
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (page) {
                        context
                            .read<OnboardingBloc>()
                            .add(OnboardingPageChanged(page));
                      },
                      children: const [
                        OnboardingPageContent(pageIndex: 0),
                        OnboardingPageContent(pageIndex: 1),
                        OnboardingPageContent(pageIndex: 2),
                        OnboardingPageContent(pageIndex: 3),
                        OnboardingPageContent(pageIndex: 4),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: OnboardingProgressIndicator(
                      currentPage: state.currentPage,
                      totalPages: OnboardingBloc.totalPages,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (state.isLastPage) {
                            context
                                .read<OnboardingBloc>()
                                .add(const OnboardingCompleted());
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Text(
                          state.isLastPage
                              ? loc.onboardingGetStarted
                              : loc.onboardingNext,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
