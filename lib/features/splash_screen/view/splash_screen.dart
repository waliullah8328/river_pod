import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/utils/constants/app_sizer.dart';
import '../view_model/splash_view_model.dart';


class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _letterAnimations;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _slideAnimations;

  final String appName = "AyBay";

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimation();

    // Initialize SplashController logic
    Future.microtask(() {
      ref.read(splashControllerProvider.notifier).init(context);
    });
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200 * appName.length + 500),
      vsync: this,
    );

    _letterAnimations = [];
    _scaleAnimations = [];
    _slideAnimations = [];

    for (int i = 0; i < appName.length; i++) {
      double startTime =
          (i * 200.0) / _animationController.duration!.inMilliseconds;
      double endTime =
          startTime + (400.0 / _animationController.duration!.inMilliseconds);
      if (endTime > 1.0) endTime = 1.0;

      _letterAnimations.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(startTime, endTime, curve: Curves.easeOutBack),
          ),
        ),
      );

      _scaleAnimations.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(startTime, endTime, curve: Curves.elasticOut),
          ),
        ),
      );

      _slideAnimations.add(
        Tween<double>(begin: 50.0, end: 0.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(startTime, endTime, curve: Curves.easeOutCubic),
          ),
        ),
      );
    }
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEEF5),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(appName.length, (index) {
                return Transform.translate(
                  offset: Offset(0, _slideAnimations[index].value),
                  child: Transform.scale(
                    scale: _scaleAnimations[index].value,
                    child: AnimatedOpacity(
                      opacity: _letterAnimations[index].value.clamp(0.0, 1.0),
                      duration: const Duration(milliseconds: 100),
                      child: Text(
                        appName[index],
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1D2B7B),
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
