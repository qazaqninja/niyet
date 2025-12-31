// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Niyet';

  @override
  String get home => 'Home';

  @override
  String get calendar => 'Calendar';

  @override
  String get settings => 'Settings';

  @override
  String get setNiyet => 'Set Intention';

  @override
  String get muhasaba => 'Reflection';

  @override
  String get morningGreeting => 'Good morning';

  @override
  String get eveningGreeting => 'Good evening';

  @override
  String get setIntentionsForToday => 'Set your intentions for today';

  @override
  String get timeForReflection => 'Time for reflection';

  @override
  String get whatIsYourIntention => 'What is your intention today?';

  @override
  String get intentionPlaceholder => 'e.g., Be patient with family';

  @override
  String get forTheSakeOfAllah => 'For the sake of Allah';

  @override
  String get category => 'Category';

  @override
  String get ibadah => 'Worship';

  @override
  String get akhlaq => 'Character';

  @override
  String get family => 'Family';

  @override
  String get charity => 'Charity';

  @override
  String get work => 'Work';

  @override
  String get fulfilled => 'Fulfilled';

  @override
  String get tried => 'Tried';

  @override
  String get missed => 'Missed';

  @override
  String get reflection => 'Reflection';

  @override
  String get reflectionPlaceholder => 'What helped? What distracted?';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get noIntentionsYet => 'No intentions set yet';

  @override
  String get setYourFirstIntention => 'Set your first intention for today';

  @override
  String get todayIntentions => 'Today\'s Intentions';

  @override
  String get ramadanMode => 'Ramadan Mode';

  @override
  String get hadithReminder => 'Actions are judged by intentions';

  @override
  String get reflect => 'Reflect';

  @override
  String get eveningReflection => 'Evening Reflection';

  @override
  String get allIntentionsReflected => 'All intentions reflected';

  @override
  String get mayAllahAccept => 'May Allah accept your efforts';

  @override
  String get howDidItGo => 'How did it go?';

  @override
  String get complete => 'Complete';

  @override
  String get next => 'Next';

  @override
  String get onboardingWelcomeTitle => 'Welcome to Niyet';

  @override
  String get onboardingWelcomeSubtitle => 'Intentions before actions';

  @override
  String get onboardingConceptTitle => 'Niyet is not a task list';

  @override
  String get onboardingConceptBody =>
      'A niyet is an intention you set with purpose. It\'s not about checking boxes - it\'s about being mindful of why you act.';

  @override
  String get onboardingMorningTitle => 'Start your day with intention';

  @override
  String get onboardingMorningBody =>
      'Each morning, set your niyetler for the day. What do you intend to do? For whom? For what purpose?';

  @override
  String get onboardingEveningTitle => 'Evening reflection (Muhasaba)';

  @override
  String get onboardingEveningBody =>
      'At day\'s end, reflect on your intentions. Did you fulfill them? What helped? What got in the way? Growth comes through honest reflection.';

  @override
  String get onboardingGetStartedTitle => 'Begin your journey';

  @override
  String get onboardingGetStartedBody =>
      'May your intentions be sincere and your efforts blessed.';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get noIntentionsForDay => 'No intentions for this day';

  @override
  String get saveAsTemplate => 'Save as template';

  @override
  String get templateSaved => 'Template saved';

  @override
  String get templateIbadah1 => 'Increase remembrance of Allah';

  @override
  String get templateIbadah2 => 'Pray on time';

  @override
  String get templateAkhlaq1 => 'Be gentle with people';

  @override
  String get templateAkhlaq2 => 'Be patient';

  @override
  String get templateFamily1 => 'Be good to parents';

  @override
  String get templateFamily2 => 'Spend time with family';

  @override
  String get templateCharity1 => 'Give charity secretly';

  @override
  String get templateCharity2 => 'Help someone';

  @override
  String get templateWork1 => 'Work honestly';

  @override
  String get templateWork2 => 'Do work excellently';

  @override
  String get deleteNiyet => 'Delete intention';

  @override
  String get deleteNiyetConfirmation =>
      'Are you sure you want to delete this intention?';

  @override
  String get delete => 'Delete';

  @override
  String get date => 'Date';

  @override
  String get created => 'Created';

  @override
  String get outcome => 'Outcome';

  @override
  String niyetCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count intentions',
      one: '1 intention',
      zero: 'No intentions',
    );
    return '$_temp0';
  }
}
