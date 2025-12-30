enum NiyyahOutcome {
  fulfilled,  // Intention was fulfilled
  tried,      // Made effort but didn't complete
  missed,     // Didn't attempt
}

extension NiyyahOutcomeExtension on NiyyahOutcome {
  String get label {
    switch (this) {
      case NiyyahOutcome.fulfilled:
        return 'Fulfilled';
      case NiyyahOutcome.tried:
        return 'Tried';
      case NiyyahOutcome.missed:
        return 'Missed';
    }
  }

  String get emoji {
    switch (this) {
      case NiyyahOutcome.fulfilled:
        return '✓';
      case NiyyahOutcome.tried:
        return '~';
      case NiyyahOutcome.missed:
        return '·';
    }
  }
}
