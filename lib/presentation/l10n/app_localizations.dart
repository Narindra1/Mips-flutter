import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_af.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('af'),
    Locale('en'),
    Locale('fr'),
    Locale('ko'),
    Locale('zh')
  ];

  /// No description provided for @app_name.
  ///
  /// In fr, this message translates to:
  /// **'MIPS'**
  String get app_name;

  /// No description provided for @app_version.
  ///
  /// In fr, this message translates to:
  /// **'1.0'**
  String get app_version;

  /// No description provided for @loading_error.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur s\'est produite, veuillez réessayer ultérieurement.'**
  String get loading_error;

  /// No description provided for @error_operation.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur s\'est produite, veuillez réessayer.'**
  String get error_operation;

  /// Duration in weeks with plural forms
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, one{{count} semaine} other{{count} semaines}}'**
  String duration_week(num count);

  /// Duration in months with plural forms
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, one{{count} mois} other{{count} mois}}'**
  String duration_month(num count);

  /// Duration in years with plural forms
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, one{{count} an} other{{count} ans}}'**
  String duration_year(num count);

  /// Announce in plural
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, one{{count} annonce} other{{count} annonces}}'**
  String announce_count(num count);

  /// No description provided for @found_ad_that_might_interest_you.
  ///
  /// In fr, this message translates to:
  /// **'J’ai trouvé une annonce qui devrait vous intéresser sur MIPS'**
  String get found_ad_that_might_interest_you;

  /// No description provided for @online_ads_from.
  ///
  /// In fr, this message translates to:
  /// **'Annonces en ligne de {name}'**
  String online_ads_from(String name);

  /// No description provided for @delete_all.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer tout'**
  String get delete_all;

  /// No description provided for @you_earned_kara_bonus.
  ///
  /// In fr, this message translates to:
  /// **'Vous avez gagné de bonus KARA!'**
  String get you_earned_kara_bonus;

  /// No description provided for @optional.
  ///
  /// In fr, this message translates to:
  /// **'Facultatif'**
  String get optional;

  /// No description provided for @ad_id.
  ///
  /// In fr, this message translates to:
  /// **'ID de l\'annonce'**
  String get ad_id;

  /// No description provided for @ad_id_is_required.
  ///
  /// In fr, this message translates to:
  /// **'ID de l\'annonce est requis'**
  String get ad_id_is_required;

  /// No description provided for @add_the_ad_id.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez l\'ID de l\'annonce'**
  String get add_the_ad_id;

  /// No description provided for @ad_id_doesnt_exist.
  ///
  /// In fr, this message translates to:
  /// **'L\'ID de l\'annonce n\'existe pas'**
  String get ad_id_doesnt_exist;

  /// No description provided for @ad_is_already_pending.
  ///
  /// In fr, this message translates to:
  /// **'Annonce déjà une demande en attente'**
  String get ad_is_already_pending;

  /// No description provided for @survey_results.
  ///
  /// In fr, this message translates to:
  /// **'Résultats du sondage'**
  String get survey_results;

  /// No description provided for @choose_province.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez de(s) province(s)'**
  String get choose_province;

  /// No description provided for @become_kara_partner.
  ///
  /// In fr, this message translates to:
  /// **'Devenir un partenaire KARA'**
  String get become_kara_partner;

  /// No description provided for @request_successfully_sent.
  ///
  /// In fr, this message translates to:
  /// **'Demande bien envoyée'**
  String get request_successfully_sent;

  /// No description provided for @submit_your_request.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer votre demande'**
  String get submit_your_request;

  /// No description provided for @ads_default_title.
  ///
  /// In fr, this message translates to:
  /// **'MIPS - Super App'**
  String get ads_default_title;

  /// No description provided for @toast_disconnected.
  ///
  /// In fr, this message translates to:
  /// **'Vous êtes actuellement hors-ligne.'**
  String get toast_disconnected;

  /// No description provided for @recents_announces.
  ///
  /// In fr, this message translates to:
  /// **'Annonces récentes'**
  String get recents_announces;

  /// No description provided for @announce_sent.
  ///
  /// In fr, this message translates to:
  /// **'Annonce envoyée'**
  String get announce_sent;

  /// No description provided for @free.
  ///
  /// In fr, this message translates to:
  /// **'Gratuit'**
  String get free;

  /// No description provided for @login_intro.
  ///
  /// In fr, this message translates to:
  /// **'MIPS vous offre des milliers de publications d\'articles'**
  String get login_intro;

  /// No description provided for @register_intro.
  ///
  /// In fr, this message translates to:
  /// **'MIPS vous attend!'**
  String get register_intro;

  /// No description provided for @notifications.
  ///
  /// In fr, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @ad_modified.
  ///
  /// In fr, this message translates to:
  /// **'Modifiée'**
  String get ad_modified;

  /// No description provided for @announce_sent_extedendtext.
  ///
  /// In fr, this message translates to:
  /// **'Votre annonce a été publiée avec succès!'**
  String get announce_sent_extedendtext;

  /// No description provided for @plainte_sent.
  ///
  /// In fr, this message translates to:
  /// **'Envoi réussi'**
  String get plainte_sent;

  /// No description provided for @plainte_sent_extendedtext.
  ///
  /// In fr, this message translates to:
  /// **'Merci, votre retour nous aidera à améliorer MIPS.'**
  String get plainte_sent_extendedtext;

  /// No description provided for @announce_mahapartenaire_sent_extendedtext.
  ///
  /// In fr, this message translates to:
  /// **'L\'équipe d\'administration va examiner votre demande.'**
  String get announce_mahapartenaire_sent_extendedtext;

  /// No description provided for @categoris.
  ///
  /// In fr, this message translates to:
  /// **'Catégorie'**
  String get categoris;

  /// No description provided for @announce_detail.
  ///
  /// In fr, this message translates to:
  /// **'Détail de l\'annonce'**
  String get announce_detail;

  /// No description provided for @title.
  ///
  /// In fr, this message translates to:
  /// **'Titre'**
  String get title;

  /// No description provided for @ann_title_hint.
  ///
  /// In fr, this message translates to:
  /// **'Mettre ici le titre de l\'annonce'**
  String get ann_title_hint;

  /// No description provided for @ann_title_validation_error.
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Veuillez ajouter un titre pour l\'annonces'**
  String get ann_title_validation_error;

  /// No description provided for @ann_desc_title.
  ///
  /// In fr, this message translates to:
  /// **'Brève description'**
  String get ann_desc_title;

  /// No description provided for @ann_desc_hint.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez ici une très courte description'**
  String get ann_desc_hint;

  /// No description provided for @ann_desc_validation_error.
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Veuillez ajouter une breve description'**
  String get ann_desc_validation_error;

  /// No description provided for @ann_desc_long_title.
  ///
  /// In fr, this message translates to:
  /// **'Description détaillée'**
  String get ann_desc_long_title;

  /// No description provided for @ann_desc_long_hint.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez ici une description detaillée de votre annonces'**
  String get ann_desc_long_hint;

  /// No description provided for @ann_desc_long_validation_error.
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Veuillez ajouter les détails de votre annonce'**
  String get ann_desc_long_validation_error;

  /// No description provided for @ann_emplacement_title.
  ///
  /// In fr, this message translates to:
  /// **'Emplacement'**
  String get ann_emplacement_title;

  /// No description provided for @ann_emplacement_hint.
  ///
  /// In fr, this message translates to:
  /// **'Lieu (ex: Ankorondrano Antananarivo, Antsirabe)'**
  String get ann_emplacement_hint;

  /// No description provided for @ann_emplacement_validation_error.
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Veuillez indiquer l\'emplacement un lieu'**
  String get ann_emplacement_validation_error;

  /// No description provided for @ann_contact_title.
  ///
  /// In fr, this message translates to:
  /// **'Contact'**
  String get ann_contact_title;

  /// No description provided for @ann_contact_hint.
  ///
  /// In fr, this message translates to:
  /// **'Ex: 034 00 000 00'**
  String get ann_contact_hint;

  /// No description provided for @exemple_pref_hint.
  ///
  /// In fr, this message translates to:
  /// **'Ex: '**
  String get exemple_pref_hint;

  /// No description provided for @add_images_titles.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter des images ({imagecount} max)'**
  String add_images_titles(int imagecount);

  /// No description provided for @add_photo_label.
  ///
  /// In fr, this message translates to:
  /// **'Photo'**
  String get add_photo_label;

  /// No description provided for @add_images_capture_titles.
  ///
  /// In fr, this message translates to:
  /// **'Capture d\'écran ({imagecount} max)'**
  String add_images_capture_titles(int imagecount);

  /// No description provided for @send.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer'**
  String get send;

  /// No description provided for @sondage_theme_title.
  ///
  /// In fr, this message translates to:
  /// **'Thème {numero}'**
  String sondage_theme_title(int numero);

  /// No description provided for @sondage_fin.
  ///
  /// In fr, this message translates to:
  /// **'Fin: {datelimit}'**
  String sondage_fin(String datelimit);

  /// No description provided for @complaints_and_suggestions.
  ///
  /// In fr, this message translates to:
  /// **'Plaintes et suggestions'**
  String get complaints_and_suggestions;

  /// No description provided for @kara_transfer.
  ///
  /// In fr, this message translates to:
  /// **'Transfert de KARA'**
  String get kara_transfer;

  /// No description provided for @using_kara.
  ///
  /// In fr, this message translates to:
  /// **'Utilisation de KARA'**
  String get using_kara;

  /// No description provided for @announcement_extension.
  ///
  /// In fr, this message translates to:
  /// **'Prolongement d\'annonce'**
  String get announcement_extension;

  /// No description provided for @survey_participation.
  ///
  /// In fr, this message translates to:
  /// **'Participation au sondage'**
  String get survey_participation;

  /// No description provided for @first_connection.
  ///
  /// In fr, this message translates to:
  /// **'Première connexion'**
  String get first_connection;

  /// No description provided for @ad_consultation.
  ///
  /// In fr, this message translates to:
  /// **'Consultation d\'annonce'**
  String get ad_consultation;

  /// No description provided for @daily_connection.
  ///
  /// In fr, this message translates to:
  /// **'Connexion quotidienne'**
  String get daily_connection;

  /// No description provided for @some_may_be_hidden.
  ///
  /// In fr, this message translates to:
  /// **'Certaines peuvent être cachées'**
  String get some_may_be_hidden;

  /// No description provided for @followed.
  ///
  /// In fr, this message translates to:
  /// **'Suivi'**
  String get followed;

  /// No description provided for @connexion_security.
  ///
  /// In fr, this message translates to:
  /// **'Connexion et sécurité'**
  String get connexion_security;

  /// No description provided for @notice.
  ///
  /// In fr, this message translates to:
  /// **'Avis'**
  String get notice;

  /// No description provided for @enter_the_validation_code.
  ///
  /// In fr, this message translates to:
  /// **'Entrez le code de validation'**
  String get enter_the_validation_code;

  /// No description provided for @create_new_more_secure_password.
  ///
  /// In fr, this message translates to:
  /// **'Créer un nouveau mot de passe plus sécurisé'**
  String get create_new_more_secure_password;

  /// No description provided for @enter_old_pass.
  ///
  /// In fr, this message translates to:
  /// **'Entrer l\'ancien mot de passe'**
  String get enter_old_pass;

  /// No description provided for @attention.
  ///
  /// In fr, this message translates to:
  /// **'Attention'**
  String get attention;

  /// No description provided for @delete_title1.
  ///
  /// In fr, this message translates to:
  /// **'Êtes-vous sûr de vouloir supprimer votre compte ?'**
  String get delete_title1;

  /// No description provided for @delete_subtitle1.
  ///
  /// In fr, this message translates to:
  /// **'La suppression de votre compte entraînera la suppression permanente de vos données personnelles et de votre activité sur la plateforme.'**
  String get delete_subtitle1;

  /// No description provided for @delete_title2.
  ///
  /// In fr, this message translates to:
  /// **'Souhaitez-vous tout de même continuer ?'**
  String get delete_title2;

  /// No description provided for @delete_subtitle2.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez confirmer cette action si vous souhaitez poursuivre.'**
  String get delete_subtitle2;

  /// No description provided for @confirm.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer'**
  String get confirm;

  /// No description provided for @member_since.
  ///
  /// In fr, this message translates to:
  /// **'Membre depuis {date}'**
  String member_since(String date);

  /// No description provided for @verified_phone.
  ///
  /// In fr, this message translates to:
  /// **'Numéro de téléphone vérifié'**
  String get verified_phone;

  /// No description provided for @count_annonces.
  ///
  /// In fr, this message translates to:
  /// **'{count} annonces'**
  String count_annonces(String count);

  /// No description provided for @followed_by_count_member.
  ///
  /// In fr, this message translates to:
  /// **'Suivi par {count} membres'**
  String followed_by_count_member(String count);

  /// No description provided for @you_follow_count_member.
  ///
  /// In fr, this message translates to:
  /// **'Vous suivez {count} membres'**
  String you_follow_count_member(String count);

  /// No description provided for @announces.
  ///
  /// In fr, this message translates to:
  /// **'Annonces'**
  String get announces;

  /// No description provided for @followeds.
  ///
  /// In fr, this message translates to:
  /// **'Suivis'**
  String get followeds;

  /// No description provided for @estimate.
  ///
  /// In fr, this message translates to:
  /// **'Devis'**
  String get estimate;

  /// No description provided for @extend_validity.
  ///
  /// In fr, this message translates to:
  /// **'Prolonger'**
  String get extend_validity;

  /// No description provided for @send_announce.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer l\'annonce'**
  String get send_announce;

  /// No description provided for @modify_announce.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'annonce'**
  String get modify_announce;

  /// No description provided for @modify_profil_title.
  ///
  /// In fr, this message translates to:
  /// **'Information du compte'**
  String get modify_profil_title;

  /// No description provided for @announce_partner.
  ///
  /// In fr, this message translates to:
  /// **'Annonce Partenaire'**
  String get announce_partner;

  /// No description provided for @announce_sponsor.
  ///
  /// In fr, this message translates to:
  /// **'Annonce Sponsor'**
  String get announce_sponsor;

  /// No description provided for @become_sponsor.
  ///
  /// In fr, this message translates to:
  /// **'Devenir Sponsor'**
  String get become_sponsor;

  /// No description provided for @become_partner.
  ///
  /// In fr, this message translates to:
  /// **'Devenir Partenaire'**
  String get become_partner;

  /// No description provided for @available_soon.
  ///
  /// In fr, this message translates to:
  /// **'Bientôt disponible !'**
  String get available_soon;

  /// No description provided for @ann_option_title.
  ///
  /// In fr, this message translates to:
  /// **'Options de publication'**
  String get ann_option_title;

  /// No description provided for @choose_langue.
  ///
  /// In fr, this message translates to:
  /// **'Choisir langue'**
  String get choose_langue;

  /// No description provided for @ann_option_choose_type.
  ///
  /// In fr, this message translates to:
  /// **'Choisir le type de votre annonce'**
  String get ann_option_choose_type;

  /// No description provided for @ann_option_choose_duration.
  ///
  /// In fr, this message translates to:
  /// **'Choisir la durée de publication'**
  String get ann_option_choose_duration;

  /// No description provided for @ann_total_amount.
  ///
  /// In fr, this message translates to:
  /// **'Total'**
  String get ann_total_amount;

  /// No description provided for @ann_mod_title.
  ///
  /// In fr, this message translates to:
  /// **'Modifier votre annonce'**
  String get ann_mod_title;

  /// No description provided for @ann_mod_done.
  ///
  /// In fr, this message translates to:
  /// **'Modification enregistrée'**
  String get ann_mod_done;

  /// No description provided for @sondage_submit_response.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer réponse'**
  String get sondage_submit_response;

  /// No description provided for @sondage_validation_error.
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Veuillez choisir une option'**
  String get sondage_validation_error;

  /// No description provided for @sondage_submit_success.
  ///
  /// In fr, this message translates to:
  /// **'Votre réponse a été enregistrée, merci pour votre participation.'**
  String get sondage_submit_success;

  /// No description provided for @alert_diag_title_error.
  ///
  /// In fr, this message translates to:
  /// **'Erreur'**
  String get alert_diag_title_error;

  /// No description provided for @alert_diag_title_message.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur est survenue, veuillez réessayer.'**
  String get alert_diag_title_message;

  /// No description provided for @alert_dial_auth_requiered_title.
  ///
  /// In fr, this message translates to:
  /// **'Connexion requise'**
  String get alert_dial_auth_requiered_title;

  /// No description provided for @alert_dial_auth_requiered_text.
  ///
  /// In fr, this message translates to:
  /// **'Connectez-vous pour profiter pleinement de l\'application MIPS ! Publiez, commentez et interagissez avec les annonces en toute simplicité.'**
  String get alert_dial_auth_requiered_text;

  /// No description provided for @continuer.
  ///
  /// In fr, this message translates to:
  /// **'Continuer'**
  String get continuer;

  /// No description provided for @fermer.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get fermer;

  /// No description provided for @avatar.
  ///
  /// In fr, this message translates to:
  /// **'Avatar'**
  String get avatar;

  /// No description provided for @voirDetail.
  ///
  /// In fr, this message translates to:
  /// **'Plus de détails'**
  String get voirDetail;

  /// No description provided for @total.
  ///
  /// In fr, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @faka_bonus.
  ///
  /// In fr, this message translates to:
  /// **'KARA bonus'**
  String get faka_bonus;

  /// No description provided for @bonus.
  ///
  /// In fr, this message translates to:
  /// **'Bonus:'**
  String get bonus;

  /// No description provided for @phone_duplicate_error.
  ///
  /// In fr, this message translates to:
  /// **'Numéro de téléphone déjà utilisé.'**
  String get phone_duplicate_error;

  /// No description provided for @option_paiement.
  ///
  /// In fr, this message translates to:
  /// **'Options de paiements'**
  String get option_paiement;

  /// No description provided for @recommander_by.
  ///
  /// In fr, this message translates to:
  /// **'Recommandé par (facultatif)'**
  String get recommander_by;

  /// No description provided for @recommander_agent_hint.
  ///
  /// In fr, this message translates to:
  /// **'Numéro de téléphone du recommandataire'**
  String get recommander_agent_hint;

  /// No description provided for @connexion.
  ///
  /// In fr, this message translates to:
  /// **'Connexion'**
  String get connexion;

  /// No description provided for @please_wait.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez patienter...'**
  String get please_wait;

  /// No description provided for @inscription.
  ///
  /// In fr, this message translates to:
  /// **'Inscription'**
  String get inscription;

  /// No description provided for @cgu_title.
  ///
  /// In fr, this message translates to:
  /// **'Conditions Générales d\'Utilisation (CGU)'**
  String get cgu_title;

  /// No description provided for @cgu_section1_title.
  ///
  /// In fr, this message translates to:
  /// **'1. Présentation de l\'Application'**
  String get cgu_section1_title;

  /// No description provided for @cgu_section1_text.
  ///
  /// In fr, this message translates to:
  /// **'L\'application MIPS est une plateforme de diffusion d\'annonces permettant aux utilisateurs de publier et consulter des annonces à l\'aide du Jeton FAKA. Ces Conditions Générales d\'Utilisation (CGU) définissent les règles d\'utilisation de l\'application, aussi bien pour les utilisateurs inscrits que pour ceux accédant sans connexion.'**
  String get cgu_section1_text;

  /// No description provided for @cgu_section2_title.
  ///
  /// In fr, this message translates to:
  /// **'2. Acceptation des CGU'**
  String get cgu_section2_title;

  /// No description provided for @cgu_section2_text.
  ///
  /// In fr, this message translates to:
  /// **'En accédant à l\'application MAHAFAKA, l\'utilisateur reconnaît avoir pris connaissance des présentes CGU et accepte de s\'y conformer.'**
  String get cgu_section2_text;

  /// No description provided for @cgu_section3_title.
  ///
  /// In fr, this message translates to:
  /// **'3. Inscription et Compte Utilisateur'**
  String get cgu_section3_title;

  /// No description provided for @cgu_section3_text.
  ///
  /// In fr, this message translates to:
  /// **'Pour accéder à certaines fonctionnalités, l\'utilisateur doit créer un compte en fournissant les informations suivantes :\n- Pseudo\n- Genre\n- Année de naissance\n- Lieu de résidence\n- Mot de passe\n- Email\n- Numéro de téléphone\n\nL\'utilisateur s\'engage à fournir des informations exactes et à jour. En cas d\'informations erronées, MAHAFAKA se réserve le droit de suspendre ou supprimer le compte.'**
  String get cgu_section3_text;

  /// No description provided for @cgu_section4_title.
  ///
  /// In fr, this message translates to:
  /// **'4. Utilisation sans Connexion (Sans Authentification)'**
  String get cgu_section4_title;

  /// No description provided for @cgu_section4_text.
  ///
  /// In fr, this message translates to:
  /// **'Les utilisateurs non inscrits peuvent accéder à certaines fonctionnalités de l\'application, telles que la consultation des annonces. Toutefois, la publication et certaines interactions nécessitent un compte utilisateur.'**
  String get cgu_section4_text;

  /// No description provided for @cgu_section5_title.
  ///
  /// In fr, this message translates to:
  /// **'5. Jeton FAKA'**
  String get cgu_section5_title;

  /// No description provided for @cgu_section5_text.
  ///
  /// In fr, this message translates to:
  /// **'Le Jeton FAKA est utilisé pour la diffusion des annonces. Les modalités d\'obtention et d\'utilisation du Jeton FAKA sont définies dans les conditions spécifiques de MAHAFAKA.'**
  String get cgu_section5_text;

  /// No description provided for @cgu_section6_title.
  ///
  /// In fr, this message translates to:
  /// **'6. Protection des Données Personnelles'**
  String get cgu_section6_title;

  /// No description provided for @cgu_section6_text.
  ///
  /// In fr, this message translates to:
  /// **'Les informations fournies lors de l\'inscription sont traitées conformément à notre politique de confidentialité. Aucune donnée personnelle ne sera vendue ou partagée avec des tiers sans le consentement de l\'utilisateur.'**
  String get cgu_section6_text;

  /// No description provided for @cgu_section7_title.
  ///
  /// In fr, this message translates to:
  /// **'7. Responsabilités de l\'Utilisateur'**
  String get cgu_section7_title;

  /// No description provided for @cgu_section7_text.
  ///
  /// In fr, this message translates to:
  /// **'L\'utilisateur s\'engage à :\n- Ne pas publier d\'annonces contenant des informations fausses, illégales ou offensantes.\n- Respecter les lois en vigueur et les droits des tiers.\n- Ne pas utiliser l\'application à des fins frauduleuses ou malveillantes.'**
  String get cgu_section7_text;

  /// No description provided for @cgu_section8_title.
  ///
  /// In fr, this message translates to:
  /// **'8. Modification des CGU'**
  String get cgu_section8_title;

  /// No description provided for @cgu_section8_text.
  ///
  /// In fr, this message translates to:
  /// **'MAHAFAKA se réserve le droit de modifier les présentes CGU à tout moment. Les utilisateurs seront informés des modifications via l\'application.'**
  String get cgu_section8_text;

  /// No description provided for @cgu_section9_title.
  ///
  /// In fr, this message translates to:
  /// **'9. Contact'**
  String get cgu_section9_title;

  /// No description provided for @cgu_section9_text.
  ///
  /// In fr, this message translates to:
  /// **'Pour toute question relative aux CGU, l\'utilisateur peut contacter l\'équipe de MAHAFAKA via l\'application ou par email.'**
  String get cgu_section9_text;

  /// No description provided for @diag_auth_error_title.
  ///
  /// In fr, this message translates to:
  /// **'Erreur d\'authentification'**
  String get diag_auth_error_title;

  /// No description provided for @diag_auth_error_text.
  ///
  /// In fr, this message translates to:
  /// **'Vérifiez que les données que vous avez saisies sont correctes.'**
  String get diag_auth_error_text;

  /// No description provided for @diag_register_error_title.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'inscription'**
  String get diag_register_error_title;

  /// No description provided for @diag_register_error_text.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur est survenue lors de l\'inscription.\nErreur: [{errorMessage}]'**
  String diag_register_error_text(String errorMessage);

  /// No description provided for @diag_error_title.
  ///
  /// In fr, this message translates to:
  /// **'Erreur'**
  String get diag_error_title;

  /// No description provided for @diag_error_text.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur est survenue.\nErreur: [{errorMessage}]'**
  String diag_error_text(String errorMessage);

  /// No description provided for @profil_change_pass_text.
  ///
  /// In fr, this message translates to:
  /// **'Changer de mot de passe'**
  String get profil_change_pass_text;

  /// No description provided for @changer.
  ///
  /// In fr, this message translates to:
  /// **'Changer'**
  String get changer;

  /// No description provided for @tips_mahaol_title.
  ///
  /// In fr, this message translates to:
  /// **'[Avis]'**
  String get tips_mahaol_title;

  /// No description provided for @tips_mahaol_desc.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez partager toutes les nouvelles qui pourraient intéresser les autres membres. La diffamation et tout contenu à caractère sensationnel entraîneront des sanctions. Pour chaque publication, l\'auteur recevra un crédit  équivalent à <le nombre de \"Merci\" reçus pendant une semaine * 20 KARA >.'**
  String get tips_mahaol_desc;

  /// No description provided for @data_managing.
  ///
  /// In fr, this message translates to:
  /// **'Securité et gestion de données'**
  String get data_managing;

  /// No description provided for @login_text_intro.
  ///
  /// In fr, this message translates to:
  /// **'Accédez à MIPS pour profiter pleinement de l\'application'**
  String get login_text_intro;

  /// No description provided for @login_username_hint.
  ///
  /// In fr, this message translates to:
  /// **'Numéro de téléphone ou mail'**
  String get login_username_hint;

  /// No description provided for @login_username_validation_error.
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Entrer votre numéro de téléphone ou votre adresse mail'**
  String get login_username_validation_error;

  /// No description provided for @login_password_hint.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe'**
  String get login_password_hint;

  /// No description provided for @login_password_validation_error.
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Entrer votre mot de passe'**
  String get login_password_validation_error;

  /// No description provided for @login_stayconnected.
  ///
  /// In fr, this message translates to:
  /// **'Rester connecté'**
  String get login_stayconnected;

  /// No description provided for @login_forgot_password.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe oublié?'**
  String get login_forgot_password;

  /// No description provided for @login_not_member.
  ///
  /// In fr, this message translates to:
  /// **'Pas encore membre?'**
  String get login_not_member;

  /// No description provided for @login_signup.
  ///
  /// In fr, this message translates to:
  /// **'S\'inscrire'**
  String get login_signup;

  /// No description provided for @menu_profil_account_info.
  ///
  /// In fr, this message translates to:
  /// **'Informations du compte'**
  String get menu_profil_account_info;

  /// No description provided for @menu_profil_myavatar.
  ///
  /// In fr, this message translates to:
  /// **'Mon Avatar/ KARA'**
  String get menu_profil_myavatar;

  /// No description provided for @menu_profil_delete_data_texte.
  ///
  /// In fr, this message translates to:
  /// **'Demander la suppression de votre compte et de vos informations personnelles.'**
  String get menu_profil_delete_data_texte;

  /// No description provided for @menu_profil_avatar_desc.
  ///
  /// In fr, this message translates to:
  /// **'Votre avatar actuel'**
  String get menu_profil_avatar_desc;

  /// No description provided for @menu_profil_solde_disponible.
  ///
  /// In fr, this message translates to:
  /// **'Solde disponible'**
  String get menu_profil_solde_disponible;

  /// No description provided for @mips_unit.
  ///
  /// In fr, this message translates to:
  /// **'KARA'**
  String get mips_unit;

  /// No description provided for @ariary_unit.
  ///
  /// In fr, this message translates to:
  /// **'Ar'**
  String get ariary_unit;

  /// No description provided for @logout.
  ///
  /// In fr, this message translates to:
  /// **'Se deconnecter'**
  String get logout;

  /// No description provided for @gerer.
  ///
  /// In fr, this message translates to:
  /// **'Gérer'**
  String get gerer;

  /// No description provided for @annonce.
  ///
  /// In fr, this message translates to:
  /// **'Annonce'**
  String get annonce;

  /// No description provided for @setting_langue.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get setting_langue;

  /// No description provided for @setting_langue_mg.
  ///
  /// In fr, this message translates to:
  /// **'Malagasy'**
  String get setting_langue_mg;

  /// No description provided for @setting_langue_fr.
  ///
  /// In fr, this message translates to:
  /// **'Français'**
  String get setting_langue_fr;

  /// No description provided for @setting_langue_en.
  ///
  /// In fr, this message translates to:
  /// **'English'**
  String get setting_langue_en;

  /// No description provided for @setting_langue_ko.
  ///
  /// In fr, this message translates to:
  /// **'한국어'**
  String get setting_langue_ko;

  /// No description provided for @setting_langue_zh.
  ///
  /// In fr, this message translates to:
  /// **'汉语'**
  String get setting_langue_zh;

  /// No description provided for @setting_font_size.
  ///
  /// In fr, this message translates to:
  /// **'Taille des textes'**
  String get setting_font_size;

  /// No description provided for @setting_about.
  ///
  /// In fr, this message translates to:
  /// **'A propos'**
  String get setting_about;

  /// No description provided for @empty_message_list.
  ///
  /// In fr, this message translates to:
  /// **'Pas encore de message reçus'**
  String get empty_message_list;

  /// No description provided for @new_version_available.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle version disponible : {version}'**
  String new_version_available(String version);

  /// No description provided for @announcements_of_follow_ups.
  ///
  /// In fr, this message translates to:
  /// **'Annonces des suivis'**
  String get announcements_of_follow_ups;

  /// No description provided for @description.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @rewards_description.
  ///
  /// In fr, this message translates to:
  /// **'Les KARA que vous gagnez à partir des ces quêtes seront ajoutés à votre solde, vous pouvez les utiliser pour publier vos annonces.'**
  String get rewards_description;

  /// No description provided for @rewards_title.
  ///
  /// In fr, this message translates to:
  /// **'Regarder des publicités, gagner des KARA'**
  String get rewards_title;

  /// No description provided for @rewards_subtitle1.
  ///
  /// In fr, this message translates to:
  /// **'Regarder toutes les publicités, gagnez un'**
  String get rewards_subtitle1;

  /// No description provided for @rewards_subtitle2.
  ///
  /// In fr, this message translates to:
  /// **'50KARA'**
  String get rewards_subtitle2;

  /// No description provided for @rewards_subtitle3.
  ///
  /// In fr, this message translates to:
  /// **'supplémentaire'**
  String get rewards_subtitle3;

  /// No description provided for @conversion.
  ///
  /// In fr, this message translates to:
  /// **'Conversion'**
  String get conversion;

  /// No description provided for @publish_annoucement.
  ///
  /// In fr, this message translates to:
  /// **'Publier l\'annonce'**
  String get publish_annoucement;

  /// No description provided for @please_contact_us.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez nous contacter à l\'adresse contact@mips.mg'**
  String get please_contact_us;

  /// No description provided for @currency.
  ///
  /// In fr, this message translates to:
  /// **'Devise'**
  String get currency;

  /// No description provided for @source.
  ///
  /// In fr, this message translates to:
  /// **'Source'**
  String get source;

  /// No description provided for @note.
  ///
  /// In fr, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @note_exchange_description.
  ///
  /// In fr, this message translates to:
  /// **'Ces informations représentent les données de clôture de la veille fournies par la Source. Notre société décline toute responsabilité en cas d\'erreur.'**
  String get note_exchange_description;

  /// No description provided for @calculation.
  ///
  /// In fr, this message translates to:
  /// **'Calcul'**
  String get calculation;

  /// No description provided for @exchange_rate.
  ///
  /// In fr, this message translates to:
  /// **'Taux de change'**
  String get exchange_rate;

  /// No description provided for @follow.
  ///
  /// In fr, this message translates to:
  /// **'Suivre'**
  String get follow;

  /// No description provided for @followers.
  ///
  /// In fr, this message translates to:
  /// **'Abonnés'**
  String get followers;

  /// No description provided for @noone_follow_me_title.
  ///
  /// In fr, this message translates to:
  /// **'Vous n\'avez pas d\'abonné pour le moment'**
  String get noone_follow_me_title;

  /// No description provided for @noone_follow_me_description.
  ///
  /// In fr, this message translates to:
  /// **'Les membres peuvent s\'abonnéer à votre profil pour ne manquer aucune de vos annonces'**
  String get noone_follow_me_description;

  /// No description provided for @followings.
  ///
  /// In fr, this message translates to:
  /// **'Abonnements'**
  String get followings;

  /// No description provided for @follow_anyone_title.
  ///
  /// In fr, this message translates to:
  /// **'Vous ne suivez pas encore de membres'**
  String get follow_anyone_title;

  /// No description provided for @follow_anyone_description.
  ///
  /// In fr, this message translates to:
  /// **'Cliquer sur \"Suivre\" sur le profil d\'un membre pour ne manquer aucune de ses annonces'**
  String get follow_anyone_description;

  /// No description provided for @delete_account.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer le compte'**
  String get delete_account;

  /// No description provided for @delete_your_account.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer votre compte'**
  String get delete_your_account;

  /// No description provided for @create_new_strong_password.
  ///
  /// In fr, this message translates to:
  /// **'Créer un nouveau mot de passe plus sécurisé'**
  String get create_new_strong_password;

  /// No description provided for @account.
  ///
  /// In fr, this message translates to:
  /// **'Compte'**
  String get account;

  /// No description provided for @my_account.
  ///
  /// In fr, this message translates to:
  /// **'Mon compte'**
  String get my_account;

  /// No description provided for @wallet.
  ///
  /// In fr, this message translates to:
  /// **'Portefeuille'**
  String get wallet;

  /// No description provided for @my_wallet.
  ///
  /// In fr, this message translates to:
  /// **'Mon Portefeuille'**
  String get my_wallet;

  /// No description provided for @rewards.
  ///
  /// In fr, this message translates to:
  /// **'Prime'**
  String get rewards;

  /// No description provided for @get_mips.
  ///
  /// In fr, this message translates to:
  /// **'Gagner des KARA'**
  String get get_mips;

  /// No description provided for @list_of_operations.
  ///
  /// In fr, this message translates to:
  /// **'Listes des opérations'**
  String get list_of_operations;

  /// No description provided for @earnings.
  ///
  /// In fr, this message translates to:
  /// **'Gains'**
  String get earnings;

  /// No description provided for @all.
  ///
  /// In fr, this message translates to:
  /// **'Tout'**
  String get all;

  /// No description provided for @expenses.
  ///
  /// In fr, this message translates to:
  /// **'Dépenses'**
  String get expenses;

  /// No description provided for @transfers.
  ///
  /// In fr, this message translates to:
  /// **'Transferts'**
  String get transfers;

  /// No description provided for @payer.
  ///
  /// In fr, this message translates to:
  /// **'Payer'**
  String get payer;

  /// No description provided for @update.
  ///
  /// In fr, this message translates to:
  /// **'Mettre à jour'**
  String get update;

  /// No description provided for @empty_mes_annonces_list.
  ///
  /// In fr, this message translates to:
  /// **'Vous n\'avez pas encore publié d\'annonce'**
  String get empty_mes_annonces_list;

  /// No description provided for @empty_mes_favoris_list.
  ///
  /// In fr, this message translates to:
  /// **'Vous n\'avez pas encore ajouté de favoris'**
  String get empty_mes_favoris_list;

  /// No description provided for @messages_screen_title.
  ///
  /// In fr, this message translates to:
  /// **'Messages'**
  String get messages_screen_title;

  /// No description provided for @setting_about_app_title.
  ///
  /// In fr, this message translates to:
  /// **'A propos de L\'application'**
  String get setting_about_app_title;

  /// No description provided for @setting_about_app_desc1.
  ///
  /// In fr, this message translates to:
  /// **'MIPS est une plateforme intuitive conçue pour simplifier la publication et la consultation d’annonces. Que vous souhaitiez vendre, acheter ou explorer, l’application propose une grande variété de catégories, incluant des articles de la vie quotidienne, du mobilier, des véhicules, et bien plus encore.'**
  String get setting_about_app_desc1;

  /// No description provided for @setting_about_app_desc2.
  ///
  /// In fr, this message translates to:
  /// **'Avec MIPS, vous pouvez utiliser le jeton KARA pour publier vos annonces ou augmenter leur visibilité. Gagnez des jetons gratuitement en interagissant avec la communauté directement depuis l’application, rendant l’expérience à la fois accessible et dynamique.'**
  String get setting_about_app_desc2;

  /// No description provided for @setting_about_propriete_title.
  ///
  /// In fr, this message translates to:
  /// **'Propriété intellectuelle'**
  String get setting_about_propriete_title;

  /// No description provided for @setting_about_propriete_annonce.
  ///
  /// In fr, this message translates to:
  /// **'Annonces'**
  String get setting_about_propriete_annonce;

  /// No description provided for @setting_about_propriete_annonce_text.
  ///
  /// In fr, this message translates to:
  /// **'Les utilisateurs qui publient des annonces détiennent les droits sur leurs publications et sont responsables de l’exactitude des informations fournies. Tout contenu inapproprié peut être signalé à notre équipe via l’adresse contact@mips.mg'**
  String get setting_about_propriete_annonce_text;

  /// No description provided for @setting_about_propriete_app.
  ///
  /// In fr, this message translates to:
  /// **'Application'**
  String get setting_about_propriete_app;

  /// No description provided for @setting_about_propriete_app_text.
  ///
  /// In fr, this message translates to:
  /// **'Les icônes utilisées dans MIPS sont issues du site Icons8.fr.'**
  String get setting_about_propriete_app_text;

  /// No description provided for @setting_about_propriete_data_title.
  ///
  /// In fr, this message translates to:
  /// **'Collecte de Données et Confidentialité'**
  String get setting_about_propriete_data_title;

  /// No description provided for @setting_about_propriete_data_text.
  ///
  /// In fr, this message translates to:
  /// **'MIPS s’engage à protéger votre vie privée en collectant un minimum d’informations personnelles, à savoir : votre âge, votre numéro de téléphone, votre adresse e-mail, et votre province de résidence. Vous pouvez demander la suppression de ces données à tout moment via le menu de votre profil.'**
  String get setting_about_propriete_data_text;

  /// No description provided for @setting_about_propriete_contact_title.
  ///
  /// In fr, this message translates to:
  /// **'Contact'**
  String get setting_about_propriete_contact_title;

  /// No description provided for @setting_about_propriete_contact_text.
  ///
  /// In fr, this message translates to:
  /// **'Pour toute question, suggestion ou assistance, contactez-nous à l’adresse suivante : contact@mips.mg / +261 38 28 309 29'**
  String get setting_about_propriete_contact_text;

  /// No description provided for @setting_title.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get setting_title;

  /// No description provided for @forgot_password_title.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe oublié'**
  String get forgot_password_title;

  /// No description provided for @acheter_faka.
  ///
  /// In fr, this message translates to:
  /// **'Acheter'**
  String get acheter_faka;

  /// No description provided for @transferer_faka.
  ///
  /// In fr, this message translates to:
  /// **'Transférer'**
  String get transferer_faka;

  /// No description provided for @password_reset_success_toast.
  ///
  /// In fr, this message translates to:
  /// **'Votre mot de passe a été réinitialisé avec succès.'**
  String get password_reset_success_toast;

  /// No description provided for @delete_account_dialog_confirm_title.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous vraiment supprimer votre compte ?'**
  String get delete_account_dialog_confirm_title;

  /// No description provided for @transfert_dialog_confirm_title.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous continuer le transfert ?'**
  String get transfert_dialog_confirm_title;

  /// No description provided for @transfert_dialog_number.
  ///
  /// In fr, this message translates to:
  /// **'Numéro bénéficiaire'**
  String get transfert_dialog_number;

  /// No description provided for @transfert_dialog_amount.
  ///
  /// In fr, this message translates to:
  /// **'Montant à envoyer'**
  String get transfert_dialog_amount;

  /// No description provided for @maha_partenaire_title.
  ///
  /// In fr, this message translates to:
  /// **'Nos Partenaire / Inscription Pubs'**
  String get maha_partenaire_title;

  /// No description provided for @welcome_user.
  ///
  /// In fr, this message translates to:
  /// **'Bienvenue {pseudo} !'**
  String welcome_user(String pseudo);

  /// No description provided for @or_text.
  ///
  /// In fr, this message translates to:
  /// **'OU'**
  String get or_text;

  /// No description provided for @choose_img.
  ///
  /// In fr, this message translates to:
  /// **'Choisir une image'**
  String get choose_img;

  /// No description provided for @browse_image.
  ///
  /// In fr, this message translates to:
  /// **'Trouver une image'**
  String get browse_image;

  /// No description provided for @conseil_tip.
  ///
  /// In fr, this message translates to:
  /// **'< Pour protéger les informations personnelles du conseiller qui a publié le message, nous ne divulguons pas ses données personnelles. >'**
  String get conseil_tip;

  /// No description provided for @reserver.
  ///
  /// In fr, this message translates to:
  /// **'Réserver'**
  String get reserver;

  /// No description provided for @respond_count.
  ///
  /// In fr, this message translates to:
  /// **'<Nombre cumulé de répondants : {count}>'**
  String respond_count(String count);

  /// No description provided for @ads_up.
  ///
  /// In fr, this message translates to:
  /// **'Publicité en haut'**
  String get ads_up;

  /// No description provided for @ads_down.
  ///
  /// In fr, this message translates to:
  /// **'Publicité en bas'**
  String get ads_down;

  /// No description provided for @transferMessagePart1.
  ///
  /// In fr, this message translates to:
  /// **'Vous allez transférer '**
  String get transferMessagePart1;

  /// No description provided for @transferMessagePart2.
  ///
  /// In fr, this message translates to:
  /// **' KARA vers le compte '**
  String get transferMessagePart2;

  /// No description provided for @logout_done.
  ///
  /// In fr, this message translates to:
  /// **'Déconnexion effectuée.'**
  String get logout_done;

  /// No description provided for @delete_done.
  ///
  /// In fr, this message translates to:
  /// **'Compte supprimé.'**
  String get delete_done;

  /// No description provided for @register_title.
  ///
  /// In fr, this message translates to:
  /// **'Inscription'**
  String get register_title;

  /// No description provided for @register_text.
  ///
  /// In fr, this message translates to:
  /// **'Rejoignez MIPS pour créer et publier vos annonces, et bien plus encore !'**
  String get register_text;

  /// No description provided for @register_pseudo_hint.
  ///
  /// In fr, this message translates to:
  /// **'Pseudo'**
  String get register_pseudo_hint;

  /// No description provided for @register_pseudo_validation.
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Entrer votre pseudo.'**
  String get register_pseudo_validation;

  /// No description provided for @register_mail_hint.
  ///
  /// In fr, this message translates to:
  /// **'Mail'**
  String get register_mail_hint;

  /// No description provided for @register_mail_validation.
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Entrer une adresse mail valide.'**
  String get register_mail_validation;

  /// No description provided for @register_password_hint.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe'**
  String get register_password_hint;

  /// No description provided for @register_new_password_hint.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau mot de passe'**
  String get register_new_password_hint;

  /// No description provided for @reset_password_title.
  ///
  /// In fr, this message translates to:
  /// **'Récupération du compte'**
  String get reset_password_title;

  /// No description provided for @change_password_title.
  ///
  /// In fr, this message translates to:
  /// **'Changement de mot de passe'**
  String get change_password_title;

  /// No description provided for @old_password_hint.
  ///
  /// In fr, this message translates to:
  /// **'Ancien mot de passe'**
  String get old_password_hint;

  /// No description provided for @reset_password_submit_button.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer'**
  String get reset_password_submit_button;

  /// No description provided for @validation_code_prompt.
  ///
  /// In fr, this message translates to:
  /// **'Code de validation'**
  String get validation_code_prompt;

  /// No description provided for @password_change_title.
  ///
  /// In fr, this message translates to:
  /// **'Changement de mot de passe'**
  String get password_change_title;

  /// No description provided for @reset_password_confirm_button.
  ///
  /// In fr, this message translates to:
  /// **'Réinitialiser'**
  String get reset_password_confirm_button;

  /// No description provided for @reset_password_email_prompt.
  ///
  /// In fr, this message translates to:
  /// **'Entrez votre adresse mail pour réinitialiser votre mot de passe'**
  String get reset_password_email_prompt;

  /// No description provided for @validation_email_sent.
  ///
  /// In fr, this message translates to:
  /// **'Un e-mail a été envoyé à l\'adresse {emailAddress}. Veuillez entrer le code de validation et saisir votre nouveau mot de passe.'**
  String validation_email_sent(String emailAddress);

  /// No description provided for @auth_guard_screen_title.
  ///
  /// In fr, this message translates to:
  /// **'Authentification requise'**
  String get auth_guard_screen_title;

  /// No description provided for @auth_guard_screen_prompt.
  ///
  /// In fr, this message translates to:
  /// **'Entrer votre mot de passe pour continuer'**
  String get auth_guard_screen_prompt;

  /// Prompt indicating the availability date
  ///
  /// In fr, this message translates to:
  /// **'Disponible le : {date}'**
  String available_date_prompt(String date);

  /// Prompt indicating today's date
  ///
  /// In fr, this message translates to:
  /// **'Date : {date}'**
  String todays_date_prompt(String date);

  /// Prompt indicating today's date
  ///
  /// In fr, this message translates to:
  /// **'{date}'**
  String format_date_ddmmyy(String date);

  /// Prompt indicating when Premium ads will be available due to a limit of 3
  ///
  /// In fr, this message translates to:
  /// **'Les annonces Premium sont limitées à un maximum de 3, elles seront donc possibles après le {date}.'**
  String available_premium_date_prompt(String date);

  /// Prompt indicating when VIP ads will be available due to a limit of 3
  ///
  /// In fr, this message translates to:
  /// **'Les annonces VIP sont limitées à un maximum de 3, elles seront donc possibles après le {date}.'**
  String available_vip_date_prompt(String date);

  /// No description provided for @transfer_screen_title.
  ///
  /// In fr, this message translates to:
  /// **'Transfert KARA'**
  String get transfer_screen_title;

  /// No description provided for @transfer_faka_send_title.
  ///
  /// In fr, this message translates to:
  /// **'Transfert envoyé'**
  String get transfer_faka_send_title;

  /// No description provided for @transfer_available_amount.
  ///
  /// In fr, this message translates to:
  /// **'Solde disponible'**
  String get transfer_available_amount;

  /// No description provided for @transfer_section_title.
  ///
  /// In fr, this message translates to:
  /// **'Transfert de KARA vers un autre compte'**
  String get transfer_section_title;

  /// No description provided for @transfer_insufficient.
  ///
  /// In fr, this message translates to:
  /// **'Solde insuffisant'**
  String get transfer_insufficient;

  /// No description provided for @transfer_id_receiver_hint.
  ///
  /// In fr, this message translates to:
  /// **'Numéro du destinataire'**
  String get transfer_id_receiver_hint;

  /// No description provided for @transfer_amount_send_hint.
  ///
  /// In fr, this message translates to:
  /// **'Montant'**
  String get transfer_amount_send_hint;

  /// No description provided for @transfer_amount_send_error_validation.
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Entrer une valeur entre 1 et {solde}'**
  String transfer_amount_send_error_validation(String solde);

  /// No description provided for @transfer_id_receiver_error_validation.
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Tel du destinataire'**
  String get transfer_id_receiver_error_validation;

  /// No description provided for @thanks_btn_text.
  ///
  /// In fr, this message translates to:
  /// **'Merci !'**
  String get thanks_btn_text;

  /// No description provided for @like_btn_text.
  ///
  /// In fr, this message translates to:
  /// **'J\'aime'**
  String get like_btn_text;

  /// No description provided for @register_password_validation.
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Entrez un mot de passe (6-8 caractères).'**
  String get register_password_validation;

  /// No description provided for @register_password2_hint.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer votre mot de passe'**
  String get register_password2_hint;

  /// No description provided for @register_password2_validation.
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Resaisir votre mot de passe.'**
  String get register_password2_validation;

  /// No description provided for @register_genre_masculin.
  ///
  /// In fr, this message translates to:
  /// **'Masculin'**
  String get register_genre_masculin;

  /// No description provided for @register_genre_feminin.
  ///
  /// In fr, this message translates to:
  /// **'Féminin'**
  String get register_genre_feminin;

  /// No description provided for @register_yearofbirth_hint.
  ///
  /// In fr, this message translates to:
  /// **'Date de naissance'**
  String get register_yearofbirth_hint;

  /// No description provided for @register_yearofbirth_validation.
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Seuls les membres âgés de 13 ans et plus peuvent s\'inscrire'**
  String get register_yearofbirth_validation;

  /// No description provided for @register_tel_hint.
  ///
  /// In fr, this message translates to:
  /// **'Numéro de téléphone'**
  String get register_tel_hint;

  /// No description provided for @register_tel_validation.
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Entrez 03* ** *** **/ 02* ** *** **'**
  String get register_tel_validation;

  /// No description provided for @choose_option.
  ///
  /// In fr, this message translates to:
  /// **'Choisir'**
  String get choose_option;

  /// No description provided for @register_address_hint.
  ///
  /// In fr, this message translates to:
  /// **'Province'**
  String get register_address_hint;

  /// No description provided for @register_address_validation.
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Entrer une adresse  valide'**
  String get register_address_validation;

  /// No description provided for @register_accept_cgu.
  ///
  /// In fr, this message translates to:
  /// **'J\'accepte les '**
  String get register_accept_cgu;

  /// No description provided for @read_all.
  ///
  /// In fr, this message translates to:
  /// **'Tout lu'**
  String get read_all;

  /// No description provided for @cgu.
  ///
  /// In fr, this message translates to:
  /// **'CGU'**
  String get cgu;

  /// No description provided for @btn_register.
  ///
  /// In fr, this message translates to:
  /// **'S\'inscrire'**
  String get btn_register;

  /// No description provided for @connection_error.
  ///
  /// In fr, this message translates to:
  /// **'Erreur de connection'**
  String get connection_error;

  /// No description provided for @try_again.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get try_again;

  /// No description provided for @item_favs_removed.
  ///
  /// In fr, this message translates to:
  /// **'Supprimé de vos favoris!'**
  String get item_favs_removed;

  /// No description provided for @item_favs_added.
  ///
  /// In fr, this message translates to:
  /// **'Ajouté dans vos favoris!'**
  String get item_favs_added;

  /// No description provided for @confirmation.
  ///
  /// In fr, this message translates to:
  /// **'Confirmation'**
  String get confirmation;

  /// No description provided for @amount_deduct.
  ///
  /// In fr, this message translates to:
  /// **' sera deduit de votre solde pour publier l\'annonce.'**
  String get amount_deduct;

  /// No description provided for @wanna_continue.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous continuer?'**
  String get wanna_continue;

  /// No description provided for @publish.
  ///
  /// In fr, this message translates to:
  /// **'Publier'**
  String get publish;

  /// No description provided for @cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancel;

  /// No description provided for @modify.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get modify;

  /// No description provided for @delete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get delete;

  /// No description provided for @add.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get add;

  /// No description provided for @error_upload.
  ///
  /// In fr, this message translates to:
  /// **'Erreur de chargement'**
  String get error_upload;

  /// No description provided for @new_announce.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle annonce'**
  String get new_announce;

  /// No description provided for @not_supported.
  ///
  /// In fr, this message translates to:
  /// **'Action non supportée sur votre appareil.'**
  String get not_supported;

  /// No description provided for @call.
  ///
  /// In fr, this message translates to:
  /// **'Appeler'**
  String get call;

  /// No description provided for @comments.
  ///
  /// In fr, this message translates to:
  /// **'Commentaires'**
  String get comments;

  /// No description provided for @login_required_to_comment.
  ///
  /// In fr, this message translates to:
  /// **'Vous devez vous connecter pour faire des commentaires.'**
  String get login_required_to_comment;

  /// No description provided for @comment_validation_error.
  ///
  /// In fr, this message translates to:
  /// **'Erreur: Ajouter un commentaire.'**
  String get comment_validation_error;

  /// No description provided for @load_more_coms.
  ///
  /// In fr, this message translates to:
  /// **'Plus de commentaires'**
  String get load_more_coms;

  /// No description provided for @load_more_messages.
  ///
  /// In fr, this message translates to:
  /// **'Plus de messages'**
  String get load_more_messages;

  /// No description provided for @comment_hint.
  ///
  /// In fr, this message translates to:
  /// **'Ecrire un commentaire...'**
  String get comment_hint;

  /// No description provided for @announce_by.
  ///
  /// In fr, this message translates to:
  /// **'Par {pseudo}'**
  String announce_by(String pseudo);

  /// No description provided for @become_spons_title.
  ///
  /// In fr, this message translates to:
  /// **'Devenir Sponsor ou Partenaire'**
  String get become_spons_title;

  /// No description provided for @become_spons_text.
  ///
  /// In fr, this message translates to:
  /// **'Contacter nous pour ajouter vos annonces ici en tant que partenaire ou sponsor.'**
  String get become_spons_text;

  /// No description provided for @incomplete_info.
  ///
  /// In fr, this message translates to:
  /// **'Information incomplète'**
  String get incomplete_info;

  /// No description provided for @incomplete_info_text.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez remplir / vérifier toutes les informations saisies.'**
  String get incomplete_info_text;

  /// No description provided for @announce_favs.
  ///
  /// In fr, this message translates to:
  /// **'Annonces favorites'**
  String get announce_favs;

  /// No description provided for @menu_favs.
  ///
  /// In fr, this message translates to:
  /// **'Menus favoris'**
  String get menu_favs;

  /// No description provided for @home.
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get home;

  /// No description provided for @empty_list_announce.
  ///
  /// In fr, this message translates to:
  /// **'Aucune annonce n\'a encore été publiée.'**
  String get empty_list_announce;

  /// No description provided for @empty_result.
  ///
  /// In fr, this message translates to:
  /// **'Aucun résultat trouvé.'**
  String get empty_result;

  /// No description provided for @annonce_deleted_succesfully.
  ///
  /// In fr, this message translates to:
  /// **'L\'annonce a été suprimée.'**
  String get annonce_deleted_succesfully;

  /// No description provided for @error_loading_image.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de charger l\'image.'**
  String get error_loading_image;

  /// No description provided for @favorite.
  ///
  /// In fr, this message translates to:
  /// **'Favoris'**
  String get favorite;

  /// No description provided for @my_ads.
  ///
  /// In fr, this message translates to:
  /// **'Mes Pubs'**
  String get my_ads;

  /// No description provided for @page_not_found.
  ///
  /// In fr, this message translates to:
  /// **'Page not found'**
  String get page_not_found;

  /// No description provided for @profil.
  ///
  /// In fr, this message translates to:
  /// **'Profil'**
  String get profil;

  /// No description provided for @view.
  ///
  /// In fr, this message translates to:
  /// **'Voir'**
  String get view;

  /// No description provided for @download_dialog_title.
  ///
  /// In fr, this message translates to:
  /// **'Mise à jour'**
  String get download_dialog_title;

  /// No description provided for @download_dialog_desc.
  ///
  /// In fr, this message translates to:
  /// **'Téléchargement en cours...'**
  String get download_dialog_desc;

  /// No description provided for @download_dialog_error.
  ///
  /// In fr, this message translates to:
  /// **'Téléchargement échoué'**
  String get download_dialog_error;

  /// No description provided for @text_very_small.
  ///
  /// In fr, this message translates to:
  /// **'Très petite'**
  String get text_very_small;

  /// No description provided for @text_small.
  ///
  /// In fr, this message translates to:
  /// **'Petite'**
  String get text_small;

  /// No description provided for @text_medium.
  ///
  /// In fr, this message translates to:
  /// **'Normale'**
  String get text_medium;

  /// No description provided for @text_large.
  ///
  /// In fr, this message translates to:
  /// **'Grande'**
  String get text_large;

  /// No description provided for @faka_history.
  ///
  /// In fr, this message translates to:
  /// **'Historique FAKA'**
  String get faka_history;

  /// No description provided for @selftransfert_error.
  ///
  /// In fr, this message translates to:
  /// **'Vous ne pouvez pas transférer vers vous-même'**
  String get selftransfert_error;

  /// No description provided for @text_very_large.
  ///
  /// In fr, this message translates to:
  /// **'Très grande'**
  String get text_very_large;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['af', 'en', 'fr', 'ko', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af': return AppLocalizationsAf();
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
    case 'ko': return AppLocalizationsKo();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
