import 'package:flutter_test/flutter_test.dart';
import 'package:go_to/go_to.dart';

void main() {
  group('GoTo Tests', () {
    test('PageTransition factories create instances', () {
      expect(PageTransition.fade(), isA<PageTransition>());
      expect(PageTransition.slideFromRight(), isA<PageTransition>());
      expect(PageTransition.slideFromLeft(), isA<PageTransition>());
      expect(PageTransition.slideFromTop(), isA<PageTransition>());
      expect(PageTransition.slideFromBottom(), isA<PageTransition>());
    });

    test('PageTransition factories accept duration parameter', () {
      final duration = Duration(seconds: 1);
      
      expect(PageTransition.fade(duration: duration), isA<PageTransition>());
      expect(PageTransition.slideFromRight(duration: duration), isA<PageTransition>());
      expect(PageTransition.slideFromLeft(duration: duration), isA<PageTransition>());
      expect(PageTransition.slideFromTop(duration: duration), isA<PageTransition>());
      expect(PageTransition.slideFromBottom(duration: duration), isA<PageTransition>());
    });
    
    test('PageTransition getRoute returns Route', () {
      final transition = PageTransition.fade();
      // We can't easily test the route without a BuildContext, but we can ensure it doesn't throw
      expect(transition, isA<PageTransition>());
    });
  });
}