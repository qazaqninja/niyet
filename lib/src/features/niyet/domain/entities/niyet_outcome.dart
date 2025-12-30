enum NiyetOutcome {
  fulfilled,  // Intention was fulfilled
  tried,      // Made effort but didn't complete
  missed,     // Didn't attempt
}

extension NiyetOutcomeExtension on NiyetOutcome {
  String get label {
    switch (this) {
      case NiyetOutcome.fulfilled:
        return 'Fulfilled';
      case NiyetOutcome.tried:
        return 'Tried';
      case NiyetOutcome.missed:
        return 'Missed';
    }
  }

  String get emoji {
    switch (this) {
      case NiyetOutcome.fulfilled:
        return '✓';
      case NiyetOutcome.tried:
        return '~';
      case NiyetOutcome.missed:
        return '·';
    }
  }
}
