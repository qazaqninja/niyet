enum AppFlavor {
  dev,
  prod,
}

class FlavorConfig {
  FlavorConfig._({required this.flavor});

  static FlavorConfig? _instance;

  final AppFlavor flavor;

  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception('FlavorConfig not initialized');
    }
    return _instance!;
  }

  static void initialize(AppFlavor flavor) {
    _instance = FlavorConfig._(flavor: flavor);
  }

  bool get isDev => flavor == AppFlavor.dev;
  bool get isProd => flavor == AppFlavor.prod;

  String get appTitle {
    switch (flavor) {
      case AppFlavor.dev:
        return 'Niyet (Dev)';
      case AppFlavor.prod:
        return 'Niyet';
    }
  }
}
