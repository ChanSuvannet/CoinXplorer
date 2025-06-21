import 'package:coinxplorer/presentation/screens/s3_home/a4_portfolio/create_portfolio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const PortfolioPage());
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio App',
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const PortfolioScreen(),
    );
  }
}

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'ALL Portfolios',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          SvgPicture.asset('assets/icons/diamond.svg', height: 20, width: 20),
          SizedBox(width: 20),
          SvgPicture.asset('assets/icons/search.svg', height: 20, width: 20),
          SizedBox(width: 16),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage('assets/images/senghak.png'),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Empty state illustration
                Container(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    'assets/images/spot.png', // Replace with your image path
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 40),
                // Main message
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Your portfolio needs some final touches...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      height: 1.3,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Subtitle
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Add a transaction in one of your portfolio or link new portfolio to get started',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Add Transaction Button
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                // Handle add transaction
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreatePortfolioScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Add Transaction',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PortfolioIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..style = PaintingStyle.fill
          ..strokeWidth = 2;

    // Draw the main platform
    paint.color = Colors.grey.shade200;
    final mainRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.2,
        size.height * 0.3,
        size.width * 0.6,
        size.height * 0.35,
      ),
      const Radius.circular(8),
    );
    canvas.drawRRect(mainRect, paint);

    // Draw the blue glow effect
    paint.color = Colors.blue.withOpacity(0.3);
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.42),
      size.width * 0.15,
      paint,
    );

    paint.color = Colors.blue.withOpacity(0.5);
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.42),
      size.width * 0.1,
      paint,
    );

    paint.color = Colors.blue.withOpacity(0.7);
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.42),
      size.width * 0.06,
      paint,
    );

    // Draw the smaller platform
    paint.color = Colors.grey.shade200;
    final smallRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.35,
        size.height * 0.65,
        size.width * 0.15,
        size.height * 0.12,
      ),
      const Radius.circular(6),
    );
    canvas.drawRRect(smallRect, paint);

    // Draw small blue circle on smaller platform
    paint.color = Colors.blue.withOpacity(0.6);
    canvas.drawCircle(
      Offset(size.width * 0.425, size.height * 0.69),
      size.width * 0.025,
      paint,
    );

    // Draw connecting line
    paint.color = Colors.grey.shade300;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawLine(
      Offset(size.width * 0.425, size.height * 0.65),
      Offset(size.width * 0.425, size.height * 0.6),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.425, size.height * 0.6),
      Offset(size.width * 0.35, size.height * 0.6),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.35, size.height * 0.6),
      Offset(size.width * 0.35, size.height * 0.47),
      paint,
    );

    // Draw shadow/depth effect
    paint.color = Colors.grey.shade100;
    paint.style = PaintingStyle.fill;
    final shadowRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.22,
        size.height * 0.67,
        size.width * 0.56,
        size.height * 0.05,
      ),
      const Radius.circular(8),
    );
    canvas.drawRRect(shadowRect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
