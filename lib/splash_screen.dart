import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wathefnyproject/login_screen.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget>
    with TickerProviderStateMixin {
  late final AnimationController _waveCtrl;
  late final AnimationController _glowCtrl;
  bool _showLogo = false;
  bool _showText = false;
  @override
  /* void initState() {
    _waveCtrl = AnimationController(vsync: this, duration: Duration(seconds: 8))
      ..repeat(reverse: true);
    _glowCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1800),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..repeat(reverse: true);
    Future<void>.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _showLogo = true;
        });
      }
    });
    Future<void>.delayed(Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _showText = true;
        });
      }
    });
    Future<void>.delayed(Duration(seconds: 5), () async {
      if (!mounted) return;
      Navigator.of(
        context,
      ).pushReplacement(CupertinoPageRoute(builder: (_) => LoginScreen()));
    });

    super.initState();
  }*/
  @override
  void initState() {
    super.initState();

    _waveCtrl = AnimationController(vsync: this, duration: Duration(seconds: 8))
      ..repeat(reverse: true);

    _glowCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1800),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..repeat(reverse: true);

    // 1️⃣ إظهار اللوجو أولاً
    Future.delayed(Duration(milliseconds: 400), () {
      if (mounted) setState(() => _showLogo = true);
    });

    // 2️⃣ وبعد ثانية كاملة يظهر النص
    Future.delayed(Duration(milliseconds: 1400), () {
      if (mounted) setState(() => _showText = true);
    });

    // الانتقال لشاشة تسجيل الدخول
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(
          context,
        ).pushReplacement(CupertinoPageRoute(builder: (_) => LoginScreen()));
      }
    });
  }

  @override
  void dispose() {
    _waveCtrl.dispose();
    _glowCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final shortestSide = media.size.shortestSide;
    final logoSize = math.min(2000.0, shortestSide * .50);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          GradientBg(),
          AnimatedBuilder(
            animation: _waveCtrl,
            builder: (context, _) =>
                CustomPaint(painter: _wavepaint(progress: _waveCtrl.value)),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedOpacity(
                  opacity: _showLogo ? 1 : 0,
                  duration: Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: SplashLogo(size: logoSize, glow: _glowCtrl.value),
                ),
                SizedBox(height: 10),
                AnimatedOpacity(
                  opacity: _showText ? 1 : 0,
                  duration: Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: SplashTexts(
                    appName: 'WATHEFNY',
                    tagLine: 'START YOUR JOB',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key, required this.size, required this.glow});
  final double size;
  final double glow;

  @override
  Widget build(BuildContext context) {
    final double blur = 18 + glow * 28;
    final double spread = 2 + glow * 10;
    final Color glowColor = Color(
      0xFFA0B89A,
    ).withValues(alpha: (.55 + glow * .25).clamp(0.0, 1.0));
    return AnimatedContainer(
      width: size,
      height: size,
      duration: Duration(microseconds: 600),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: glowColor, blurRadius: blur, spreadRadius: spread),
        ],
      ),

      child: SizedBox(
        width: size * .9,
        height: size * .9,
        child: SizedBox(
          width: size * .9,
          height: size * .9,
          child: CircleAvatar(
            //رفع الخلفية البيضا
            backgroundColor: Colors.white.withValues(alpha: 0.00),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
        ),
      ),
    );
  }
}*/
class SplashTexts extends StatelessWidget {
  const SplashTexts({super.key, required this.appName, required this.tagLine});

  final String appName;
  final String tagLine;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          appName,
          textAlign: TextAlign.center,
          style: textTheme.displaySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          tagLine,
          textAlign: TextAlign.center,
          style: textTheme.titleMedium?.copyWith(
            color: const Color(0xFFC9F3A1),
            letterSpacing: 0.6,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key, required this.size, required this.glow});
  final double size;
  final double glow;

  @override
  Widget build(BuildContext context) {
    final double blur = 15 + glow * 1.5;

    final Color glowColor = const Color(
      0xFFC9F3A1,
    ).withValues(alpha: (0.55 + glow * .25).clamp(0.0, 1.0));

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // -------- (1) التوهج حسب شكل اللوجو --------
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(glowColor, BlendMode.srcATop),
              child: Image.asset(
                'assets/images/logo.png',
                width: size,
                height: size,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // -------- (2) اللوجو نفسه فوق التوهج --------
          Image.asset(
            'assets/images/logo.png',
            width: size,
            height: size,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

//gradiantbg
class GradientBg extends StatelessWidget {
  const GradientBg();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4F6C51), // فاتح
            Color(0xFF73946B), // الأساسي
            Color(0xFFA0B89A),
          ], // داكن
        ),
      ),
    );
  }
}

class _wavepaint extends CustomPainter {
  _wavepaint({required this.progress});
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 = Paint()
      ..color = Colors.white.withValues(alpha: .06)
      ..style = PaintingStyle.fill;
    final Paint paint2 = Paint()
      ..color = Colors.white.withValues(alpha: .04)
      ..style = PaintingStyle.fill;
    final Path path1 = Path();
    final Path path2 = Path();
    final double ammplitude1 = size.height * 0.06;
    final double ammplitude2 = size.height * 0.04;
    final double yBase1 = size.height * 0.72;
    final double yBase2 = size.height * 0.78;
    path1.moveTo(0, yBase1);
    path2.moveTo(0, yBase2);
    for (double x = 0; x <= size.width; x += 2) {
      final double t = (x / size.width) * 2 * math.pi;
      final double y1 =
          yBase1 + math.sin(t + progress * 2 * math.pi) * ammplitude1;
      final double y2 =
          yBase2 + math.sin(t * 1.5 + progress * 2 * math.pi) * ammplitude2;
      path1.lineTo(x, y1);
      path2.lineTo(x, y2);
    }
    path1
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    path2
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant _wavepaint oldDelegate) {
    return true;
  }
}
