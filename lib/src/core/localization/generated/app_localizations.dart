import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_kk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('kk'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Niyyah'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @setNiyyah.
  ///
  /// In en, this message translates to:
  /// **'Set Intention'**
  String get setNiyyah;

  /// No description provided for @muhasaba.
  ///
  /// In en, this message translates to:
  /// **'Reflection'**
  String get muhasaba;

  /// No description provided for @morningGreeting.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get morningGreeting;

  /// No description provided for @eveningGreeting.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get eveningGreeting;

  /// No description provided for @whatIsYourIntention.
  ///
  /// In en, this message translates to:
  /// **'What is your intention today?'**
  String get whatIsYourIntention;

  /// No description provided for @intentionPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g., Be patient with family'**
  String get intentionPlaceholder;

  /// No description provided for @forTheSakeOfAllah.
  ///
  /// In en, this message translates to:
  /// **'For the sake of Allah'**
  String get forTheSakeOfAllah;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @ibadah.
  ///
  /// In en, this message translates to:
  /// **'Worship'**
  String get ibadah;

  /// No description provided for @akhlaq.
  ///
  /// In en, this message translates to:
  /// **'Character'**
  String get akhlaq;

  /// No description provided for @family.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get family;

  /// No description provided for @charity.
  ///
  /// In en, this message translates to:
  /// **'Charity'**
  String get charity;

  /// No description provided for @work.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get work;

  /// No description provided for @fulfilled.
  ///
  /// In en, this message translates to:
  /// **'Fulfilled'**
  String get fulfilled;

  /// No description provided for @tried.
  ///
  /// In en, this message translates to:
  /// **'Tried'**
  String get tried;

  /// No description provided for @missed.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get missed;

  /// No description provided for @reflection.
  ///
  /// In en, this message translates to:
  /// **'Reflection'**
  String get reflection;

  /// No description provided for @reflectionPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'What helped? What distracted?'**
  String get reflectionPlaceholder;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @noIntentionsYet.
  ///
  /// In en, this message translates to:
  /// **'No intentions set yet'**
  String get noIntentionsYet;

  /// No description provided for @setYourFirstIntention.
  ///
  /// In en, this message translates to:
  /// **'Set your first intention for today'**
  String get setYourFirstIntention;

  /// No description provided for @todayIntentions.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Intentions'**
  String get todayIntentions;

  /// No description provided for @ramadanMode.
  ///
  /// In en, this message translates to:
  /// **'Ramadan Mode'**
  String get ramadanMode;

  /// No description provided for @hadithReminder.
  ///
  /// In en, this message translates to:
  /// **'Actions are judged by intentions'**
  String get hadithReminder;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'kk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'kk':
      return AppLocalizationsKk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
