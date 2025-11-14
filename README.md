# GO_TO

A simple and advanced navigation package for Flutter applications.

[![pub package](https://img.shields.io/pub/v/go_to.svg)](https://pub.dev/packages/go_to)

GO_TO is a Flutter package that simplifies navigation in your Flutter applications. It provides both simple static methods and advanced features for all your navigation needs.

## Features

- Simple and easy-to-use navigation methods
- Advanced navigation with custom transitions
- Extension methods for BuildContext
- Custom navigator widget for advanced use cases
- Multiple transition animations (fade, slide from any direction)
- Support for named routes
- Go back multiple screens at once
- Navigate and replace current screen
- Parameter passing for named routes and widgets
- SEO optimized navigation patterns

## Installation

Add `go_to` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  go_to: ^0.0.1
```

## Usage

Import the package where you want to use it:

```dart
import 'package:go_to/go_to.dart';
```

### Simple Navigation

Navigate to a new screen:

```dart
GoTo.screen(context, MyScreen());
```

Navigate to a named route:

```dart
GoTo.named(context, '/home');
```

Go back to the previous screen:

```dart
GoTo.back(context);
```

Go back to the first screen:

```dart
GoTo.first(context);
```

### Parameter Passing

#### Named Route Parameters

Pass parameters to named routes:

```dart
GoTo.named(context, '/product', arguments: {
  'id': 123,
  'name': 'Product Name',
  'price': 29.99,
});
```

Access parameters in the target screen:

```dart
class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final id = args?['id'];
    final name = args?['name'];
    
    return Scaffold(
      appBar: AppBar(title: Text(name ?? 'Product')),
      body: Text('ID: $id'),
    );
  }
}
```

#### Widget Constructor Parameters

Pass parameters directly through widget constructors:

```dart
GoTo.screen(context, ProductDetailsScreen(
  productId: 456,
  productName: 'Awesome Product',
  price: 29.99,
));
```

### Advanced Navigation

Navigate with custom transitions:

```dart
GoTo.transition(
  context,
  MyScreen(),
  transition: PageTransition.fade(),
);
```

Available transitions:
- `PageTransition.fade()`
- `PageTransition.slideFromRight()`
- `PageTransition.slideFromLeft()`
- `PageTransition.slideFromTop()`
- `PageTransition.slideFromBottom()`

### Extension Methods

GO_TO also provides extension methods on BuildContext for even simpler usage:

```dart
// Navigate to a screen
context.goTo(MyScreen());

// Navigate to a named route
context.goToNamed('/home');

// Go back
context.goBack();

// Go back to first screen
context.goToFirst();

// Navigate with transition
context.goToWithTransition(
  MyScreen(),
  transition: PageTransition.slideFromRight(),
);
```

### Advanced Features

Go back multiple screens:

```dart
GoTo.back(context, times: 3);
```

Replace current screen:

```dart
GoTo.screen(context, MyScreen(), replace: true);
```

Navigate and replace with named route:

```dart
GoTo.named(context, '/home', replace: true);
```

Customize transition duration:

```dart
GoTo.transition(
  context,
  MyScreen(),
  transition: PageTransition.fade(duration: Duration(milliseconds: 500)),
);
```

### GoToNavigator Widget

For more advanced navigation control, you can use the `GoToNavigator` widget:

```dart
GoToNavigator(
  home: HomeScreen(),
  routes: {
    '/second': (context) => SecondScreen(),
    '/third': (context) => ThirdScreen(),
  },
);
```

## Example

Check out the [example](example/main.dart) directory for a complete sample app.

## SEO Keywords

flutter navigation, flutter routing, go to screen, flutter page navigation, flutter navigator, flutter route parameters, flutter transition, flutter page transition, flutter navigation package, flutter routing package, dart navigation, flutter page routing

## Hashtags

#Flutter #FlutterDev #Dart #MobileDevelopment #AppDevelopment #Navigation #Routing #FlutterPackage #GoTo #PageTransition #MobileApp #UI #UX

## License

MIT