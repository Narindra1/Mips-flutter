// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get app_name => 'MIPS';

  @override
  String get app_version => '1.0';

  @override
  String get loading_error =>
      'Une erreur s\'est produite, veuillez réessayer ultérieurement.';

  @override
  String get error_operation =>
      'Une erreur s\'est produite, veuillez réessayer.';

  @override
  String duration_week(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count semaines',
      one: '$count semaine',
    );
    return '$_temp0';
  }

  @override
  String duration_month(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mois',
      one: '$count mois',
    );
    return '$_temp0';
  }

  @override
  String duration_year(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ans',
      one: '$count an',
    );
    return '$_temp0';
  }

  @override
  String announce_count(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count annonces',
      one: '$count annonce',
    );
    return '$_temp0';
  }

  @override
  String get found_ad_that_might_interest_you =>
      'J’ai trouvé une annonce qui devrait vous intéresser sur MIPS';

  @override
  String online_ads_from(String name) {
    return 'Annonces en ligne de $name';
  }

  @override
  String get delete_all => 'Supprimer tout';

  @override
  String get you_earned_kara_bonus => 'Vous avez gagné de bonus KARA!';

  @override
  String get optional => 'Facultatif';

  @override
  String get ad_id => 'ID de l\'annonce';

  @override
  String get ad_id_is_required => 'ID de l\'annonce est requis';

  @override
  String get add_the_ad_id => 'Ajoutez l\'ID de l\'annonce';

  @override
  String get ad_id_doesnt_exist => 'L\'ID de l\'annonce n\'existe pas';

  @override
  String get ad_is_already_pending => 'Annonce déjà une demande en attente';

  @override
  String get survey_results => 'Résultats du sondage';

  @override
  String get choose_province => 'Choisissez de(s) province(s)';

  @override
  String get become_kara_partner => 'Devenir un partenaire KARA';

  @override
  String get request_successfully_sent => 'Demande bien envoyée';

  @override
  String get submit_your_request => 'Envoyer votre demande';

  @override
  String get ads_default_title => 'MIPS - Super App';

  @override
  String get toast_disconnected => 'Vous êtes actuellement hors-ligne.';

  @override
  String get recents_announces => 'Annonces récentes';

  @override
  String get announce_sent => 'Annonce envoyée';

  @override
  String get more_informations => 'Plus d\'informations';

  @override
  String get free => 'Gratuit';

  @override
  String get claim => 'Récupérer';

  @override
  String get empty_news => 'Pas de nouvelles';

  @override
  String get login_intro => 'MIPS vous offre diverses publicités';

  @override
  String get register_intro => 'MIPS vous attend!';

  @override
  String get notifications => 'Notifications';

  @override
  String get ad_modified => 'Modifiée';

  @override
  String get announce_sent_extedendtext =>
      'Votre annonce a été publiée avec succès!';

  @override
  String get plainte_sent => 'Envoi réussi';

  @override
  String get plainte_sent_extendedtext =>
      'Merci, votre retour nous aidera à améliorer MIPS.';

  @override
  String get announce_mahapartenaire_sent_extendedtext =>
      'L\'équipe d\'administration va examiner votre demande.';

  @override
  String get categoris => 'Catégorie';

  @override
  String get announce_detail => 'Détail de l\'annonce';

  @override
  String get title => 'Titre';

  @override
  String get ann_title_hint => 'Mettre ici le titre de l\'annonce';

  @override
  String get ann_title_validation_error =>
      'Erreur: Veuillez ajouter un titre pour l\'annonces';

  @override
  String get ann_desc_title => 'Brève description';

  @override
  String get ann_desc_hint => 'Ajoutez ici une très courte description';

  @override
  String get ann_desc_validation_error =>
      'Erreur: Veuillez ajouter une breve description';

  @override
  String get ann_desc_long_title => 'Description détaillée';

  @override
  String get ann_desc_long_hint =>
      'Ajoutez ici une description detaillée de votre annonces';

  @override
  String get ann_desc_long_validation_error =>
      'Erreur: Veuillez ajouter les détails de votre annonce';

  @override
  String get ann_emplacement_title => 'Emplacement';

  @override
  String get ann_emplacement_hint =>
      'Lieu (ex: Ankorondrano Antananarivo, Antsirabe)';

  @override
  String get ann_emplacement_validation_error =>
      'Erreur: Veuillez indiquer l\'emplacement un lieu';

  @override
  String get ann_contact_title => 'Contact';

  @override
  String get ann_contact_hint => 'Ex: 034 00 000 00';

  @override
  String get exemple_pref_hint => 'Ex: ';

  @override
  String add_images_titles(int imagecount) {
    return 'Ajouter des images ($imagecount max)';
  }

  @override
  String get add_photo_label => 'Photo';

  @override
  String add_images_capture_titles(int imagecount) {
    return 'Capture d\'écran ($imagecount max)';
  }

  @override
  String get send => 'Envoyer';

  @override
  String sondage_theme_title(int numero) {
    return 'Thème $numero';
  }

  @override
  String sondage_fin(String datelimit) {
    return 'Fin: $datelimit';
  }

  @override
  String get complaints_and_suggestions => 'Plaintes et suggestions';

  @override
  String get kara_transfer => 'Transfert de KARA';

  @override
  String get using_kara => 'Utilisation de KARA';

  @override
  String get announcement_extension => 'Prolongement d\'annonce';

  @override
  String get survey_participation => 'Participation au sondage';

  @override
  String get first_connection => 'Première connexion';

  @override
  String get ad_consultation => 'Consultation d\'annonce';

  @override
  String get daily_connection => 'Connexion quotidienne';

  @override
  String get some_may_be_hidden => 'Certaines peuvent être cachées';

  @override
  String get followed => 'Suivi';

  @override
  String get connexion_security => 'Connexion et sécurité';

  @override
  String get notice => 'Avis';

  @override
  String get enter_the_validation_code => 'Entrez le code de validation';

  @override
  String get create_new_more_secure_password =>
      'Créer un nouveau mot de passe plus sécurisé';

  @override
  String get enter_old_pass => 'Entrer l\'ancien mot de passe';

  @override
  String get attention => 'Attention';

  @override
  String get delete_title1 =>
      'Êtes-vous sûr de vouloir supprimer votre compte ?';

  @override
  String get delete_subtitle1 =>
      'La suppression de votre compte entraînera la suppression permanente de vos données personnelles et de votre activité sur la plateforme.';

  @override
  String get delete_title2 => 'Souhaitez-vous tout de même continuer ?';

  @override
  String get delete_subtitle2 =>
      'Veuillez confirmer cette action si vous souhaitez poursuivre.';

  @override
  String get confirm => 'Confirmer';

  @override
  String member_since(String date) {
    return 'Membre depuis $date';
  }

  @override
  String get verified_phone => 'Numéro de téléphone vérifié';

  @override
  String count_annonces(String count) {
    return '$count annonces';
  }

  @override
  String followed_by_count_member(String count) {
    return 'Suivi par $count membres';
  }

  @override
  String you_follow_count_member(String count) {
    return 'Vous suivez $count membres';
  }

  @override
  String get announces => 'Annonces';

  @override
  String get followeds => 'Suivis';

  @override
  String get estimate => 'Devis';

  @override
  String get extend_validity => 'Prolonger';

  @override
  String get send_announce => 'Envoyer l\'annonce';

  @override
  String get modify_announce => 'Modifier l\'annonce';

  @override
  String get modify_profil_title => 'Information du compte';

  @override
  String get announce_partner => 'Annonce Partenaire';

  @override
  String get announce_sponsor => 'Annonce Sponsor';

  @override
  String get become_sponsor => 'Devenir Sponsor';

  @override
  String get become_partner => 'Devenir Partenaire';

  @override
  String get available_soon => 'Bientôt disponible !';

  @override
  String get ann_option_title => 'Options de publication';

  @override
  String get choose_langue => 'Choisir langue';

  @override
  String get ann_option_choose_type => 'Choisir le type de votre annonce';

  @override
  String get ann_option_choose_duration => 'Choisir la durée de publication';

  @override
  String get ann_total_amount => 'Total';

  @override
  String get ann_mod_title => 'Modifier votre annonce';

  @override
  String get ann_mod_done => 'Modification enregistrée';

  @override
  String get sondage_submit_response => 'Envoyer réponse';

  @override
  String get sondage_validation_error => 'Erreur: Veuillez choisir une option';

  @override
  String get sondage_submit_success =>
      'Votre réponse a été enregistrée, merci pour votre participation.';

  @override
  String get alert_diag_title_error => 'Erreur';

  @override
  String get alert_diag_title_message =>
      'Une erreur est survenue, veuillez réessayer.';

  @override
  String get alert_dial_auth_requiered_title => 'Connexion requise';

  @override
  String get alert_dial_auth_requiered_text =>
      'Connectez-vous pour profiter pleinement de l\'application MIPS ! Publiez, commentez et interagissez avec les annonces en toute simplicité.';

  @override
  String get continuer => 'Continuer';

  @override
  String get fermer => 'Fermer';

  @override
  String get avatar => 'Avatar';

  @override
  String get voirDetail => 'Plus de détails';

  @override
  String get total => 'Total';

  @override
  String get faka_bonus => 'KARA bonus';

  @override
  String get bonus => 'Bonus:';

  @override
  String get phone_duplicate_error => 'Numéro de téléphone déjà utilisé.';

  @override
  String get option_paiement => 'Options de paiements';

  @override
  String get recommander_by => 'Recommandé par (facultatif)';

  @override
  String get recommander_agent_hint => 'Numéro de téléphone du recommandataire';

  @override
  String get connexion => 'Connexion';

  @override
  String get please_wait => 'Veuillez patienter...';

  @override
  String get inscription => 'Inscription';

  @override
  String get cgu_title => 'Conditions Générales d\'Utilisation (CGU)';

  @override
  String get cgu_section1_title => '1. Présentation de l\'Application';

  @override
  String get cgu_section1_text =>
      'L\'application MIPS est une plateforme de diffusion d\'annonces permettant aux utilisateurs de publier et consulter des annonces à l\'aide du Jeton FAKA. Ces Conditions Générales d\'Utilisation (CGU) définissent les règles d\'utilisation de l\'application, aussi bien pour les utilisateurs inscrits que pour ceux accédant sans connexion.';

  @override
  String get cgu_section2_title => '2. Acceptation des CGU';

  @override
  String get cgu_section2_text =>
      'En accédant à l\'application MAHAFAKA, l\'utilisateur reconnaît avoir pris connaissance des présentes CGU et accepte de s\'y conformer.';

  @override
  String get cgu_section3_title => '3. Inscription et Compte Utilisateur';

  @override
  String get cgu_section3_text =>
      'Pour accéder à certaines fonctionnalités, l\'utilisateur doit créer un compte en fournissant les informations suivantes :\n- Pseudo\n- Genre\n- Année de naissance\n- Lieu de résidence\n- Mot de passe\n- Email\n- Numéro de téléphone\n\nL\'utilisateur s\'engage à fournir des informations exactes et à jour. En cas d\'informations erronées, MAHAFAKA se réserve le droit de suspendre ou supprimer le compte.';

  @override
  String get cgu_section4_title =>
      '4. Utilisation sans Connexion (Sans Authentification)';

  @override
  String get cgu_section4_text =>
      'Les utilisateurs non inscrits peuvent accéder à certaines fonctionnalités de l\'application, telles que la consultation des annonces. Toutefois, la publication et certaines interactions nécessitent un compte utilisateur.';

  @override
  String get cgu_section5_title => '5. Jeton FAKA';

  @override
  String get cgu_section5_text =>
      'Le Jeton FAKA est utilisé pour la diffusion des annonces. Les modalités d\'obtention et d\'utilisation du Jeton FAKA sont définies dans les conditions spécifiques de MAHAFAKA.';

  @override
  String get cgu_section6_title => '6. Protection des Données Personnelles';

  @override
  String get cgu_section6_text =>
      'Les informations fournies lors de l\'inscription sont traitées conformément à notre politique de confidentialité. Aucune donnée personnelle ne sera vendue ou partagée avec des tiers sans le consentement de l\'utilisateur.';

  @override
  String get cgu_section7_title => '7. Responsabilités de l\'Utilisateur';

  @override
  String get cgu_section7_text =>
      'L\'utilisateur s\'engage à :\n- Ne pas publier d\'annonces contenant des informations fausses, illégales ou offensantes.\n- Respecter les lois en vigueur et les droits des tiers.\n- Ne pas utiliser l\'application à des fins frauduleuses ou malveillantes.';

  @override
  String get cgu_section8_title => '8. Modification des CGU';

  @override
  String get cgu_section8_text =>
      'MAHAFAKA se réserve le droit de modifier les présentes CGU à tout moment. Les utilisateurs seront informés des modifications via l\'application.';

  @override
  String get cgu_section9_title => '9. Contact';

  @override
  String get cgu_section9_text =>
      'Pour toute question relative aux CGU, l\'utilisateur peut contacter l\'équipe de MAHAFAKA via l\'application ou par email.';

  @override
  String get diag_auth_error_title => 'Erreur d\'authentification';

  @override
  String get diag_auth_error_text =>
      'Vérifiez que les données que vous avez saisies sont correctes.';

  @override
  String get diag_register_error_title => 'Erreur lors de l\'inscription';

  @override
  String diag_register_error_text(String errorMessage) {
    return 'Une erreur est survenue lors de l\'inscription.\nErreur: [$errorMessage]';
  }

  @override
  String get diag_error_title => 'Erreur';

  @override
  String diag_error_text(String errorMessage) {
    return 'Une erreur est survenue.\nErreur: [$errorMessage]';
  }

  @override
  String get profil_change_pass_text => 'Changer de mot de passe';

  @override
  String get changer => 'Changer';

  @override
  String get tips_mahaol_title => '[Avis]';

  @override
  String get tips_mahaol_desc =>
      'Veuillez partager toutes les nouvelles qui pourraient intéresser les autres membres. La diffamation et tout contenu à caractère sensationnel entraîneront des sanctions. Pour chaque publication, l\'auteur recevra un crédit  équivalent à <le nombre de \"Merci\" reçus pendant une semaine * 20 KARA >.';

  @override
  String get data_managing => 'Securité et gestion de données';

  @override
  String get login_text_intro =>
      'Accédez à MIPS pour profiter pleinement de l\'application';

  @override
  String get login_username_hint => 'Numéro de téléphone ou mail';

  @override
  String get login_username_validation_error =>
      'Erreur: Entrer votre numéro de téléphone ou votre adresse mail';

  @override
  String get login_password_hint => 'Mot de passe';

  @override
  String get login_password_validation_error =>
      'Erreur: Entrer votre mot de passe';

  @override
  String get login_stayconnected => 'Rester connecté';

  @override
  String get login_forgot_password => 'Mot de passe oublié?';

  @override
  String get login_not_member => 'Pas encore membre?';

  @override
  String get login_signup => 'S\'inscrire';

  @override
  String get menu_profil_account_info => 'Informations du compte';

  @override
  String get menu_profil_myavatar => 'Mon Avatar/ KARA';

  @override
  String get menu_profil_delete_data_texte =>
      'Demander la suppression de votre compte et de vos informations personnelles.';

  @override
  String get menu_profil_avatar_desc => 'Votre avatar actuel';

  @override
  String get menu_profil_solde_disponible => 'Solde disponible';

  @override
  String get mips_unit => 'KARA';

  @override
  String get ariary_unit => 'Ar';

  @override
  String get logout => 'Se deconnecter';

  @override
  String get gerer => 'Gérer';

  @override
  String get annonce => 'Annonce';

  @override
  String get setting_langue => 'Langue';

  @override
  String get setting_langue_mg => 'Malagasy';

  @override
  String get setting_langue_fr => 'Français';

  @override
  String get setting_langue_en => 'English';

  @override
  String get setting_langue_ko => '한국어';

  @override
  String get setting_langue_zh => '汉语';

  @override
  String get setting_font_size => 'Taille des textes';

  @override
  String get setting_about => 'A propos';

  @override
  String get empty_message_list => 'Pas encore de message reçus';

  @override
  String new_version_available(String version) {
    return 'Nouvelle version disponible : $version';
  }

  @override
  String get announcements_of_follow_ups => 'Annonces des suivis';

  @override
  String get description => 'Description';

  @override
  String get rewards_description =>
      'Les KARA que vous gagnez à partir des ces quêtes seront ajoutés à votre solde, vous pouvez les utiliser pour publier vos annonces.';

  @override
  String get rewards_title => 'Regarder des publicités, gagner des KARA';

  @override
  String get rewards_subtitle1 => 'Regarder toutes les publicités, gagnez un';

  @override
  String get rewards_subtitle2 => '50KARA';

  @override
  String get rewards_subtitle3 => 'supplémentaire';

  @override
  String get conversion => 'Conversion';

  @override
  String get publish_annoucement => 'Publier l\'annonce';

  @override
  String get please_contact_us =>
      'Veuillez nous contacter à l\'adresse contact@mips.mg';

  @override
  String get currency => 'Devise';

  @override
  String get source => 'Source';

  @override
  String get note => 'Note';

  @override
  String get note_exchange_description =>
      'Ces informations représentent les données de clôture de la veille fournies par la Source. Notre société décline toute responsabilité en cas d\'erreur.';

  @override
  String get calculation => 'Calcul';

  @override
  String get exchange_rate => 'Taux de change';

  @override
  String get follow => 'Suivre';

  @override
  String get followers => 'Abonnés';

  @override
  String get noone_follow_me_title =>
      'Vous n\'avez pas d\'abonné pour le moment';

  @override
  String get noone_follow_me_description =>
      'Les membres peuvent s\'abonnéer à votre profil pour ne manquer aucune de vos annonces';

  @override
  String get followings => 'Abonnements';

  @override
  String get follow_anyone_title => 'Vous ne suivez pas encore de membres';

  @override
  String get follow_anyone_description =>
      'Cliquer sur \"Suivre\" sur le profil d\'un membre pour ne manquer aucune de ses annonces';

  @override
  String get delete_account => 'Supprimer le compte';

  @override
  String get delete_your_account => 'Supprimer votre compte';

  @override
  String get create_new_strong_password =>
      'Créer un nouveau mot de passe plus sécurisé';

  @override
  String get account => 'Compte';

  @override
  String get my_account => 'Mon compte';

  @override
  String get wallet => 'Portefeuille';

  @override
  String get my_wallet => 'Mon Portefeuille';

  @override
  String get rewards => 'Prime';

  @override
  String get get_mips => 'Gagner des KARA';

  @override
  String get list_of_operations => 'Listes des opérations';

  @override
  String get earnings => 'Gains';

  @override
  String get all => 'Tout';

  @override
  String get expenses => 'Dépenses';

  @override
  String get transfers => 'Transferts';

  @override
  String get payer => 'Payer';

  @override
  String get update => 'Mettre à jour';

  @override
  String get empty_mes_annonces_list =>
      'Vous n\'avez pas encore publié d\'annonce';

  @override
  String get empty_mes_favoris_list =>
      'Vous n\'avez pas encore ajouté de favoris';

  @override
  String get messages_screen_title => 'Messages';

  @override
  String get setting_about_app_title => 'A propos de L\'application';

  @override
  String get setting_about_app_desc1 =>
      'MIPS est une plateforme intuitive conçue pour simplifier la publication et la consultation d’annonces. Que vous souhaitiez vendre, acheter ou explorer, l’application propose une grande variété de catégories, incluant des articles de la vie quotidienne, du mobilier, des véhicules, et bien plus encore.';

  @override
  String get setting_about_app_desc2 =>
      'Avec MIPS, vous pouvez utiliser le jeton KARA pour publier vos annonces ou augmenter leur visibilité. Gagnez des jetons gratuitement en interagissant avec la communauté directement depuis l’application, rendant l’expérience à la fois accessible et dynamique.';

  @override
  String get setting_about_propriete_title => 'Propriété intellectuelle';

  @override
  String get setting_about_propriete_annonce => 'Annonces';

  @override
  String get setting_about_propriete_annonce_text =>
      'Les utilisateurs qui publient des annonces détiennent les droits sur leurs publications et sont responsables de l’exactitude des informations fournies. Tout contenu inapproprié peut être signalé à notre équipe via l’adresse contact@mips.mg';

  @override
  String get setting_about_propriete_app => 'Application';

  @override
  String get setting_about_propriete_app_text =>
      'Les icônes utilisées dans MIPS sont issues du site Icons8.fr.';

  @override
  String get setting_about_propriete_data_title =>
      'Collecte de Données et Confidentialité';

  @override
  String get setting_about_propriete_data_text =>
      'MIPS s’engage à protéger votre vie privée en collectant un minimum d’informations personnelles, à savoir : votre âge, votre numéro de téléphone, votre adresse e-mail, et votre province de résidence. Vous pouvez demander la suppression de ces données à tout moment via le menu de votre profil.';

  @override
  String get setting_about_propriete_contact_title => 'Contact';

  @override
  String get setting_about_propriete_contact_text =>
      'Pour toute question, suggestion ou assistance, contactez-nous à l’adresse suivante : contact@mips.mg / +261 38 28 309 29';

  @override
  String get setting_title => 'Paramètres';

  @override
  String get forgot_password_title => 'Mot de passe oublié';

  @override
  String get acheter_faka => 'Acheter';

  @override
  String get transferer_faka => 'Transférer';

  @override
  String get password_reset_success_toast =>
      'Votre mot de passe a été réinitialisé avec succès.';

  @override
  String get delete_account_dialog_confirm_title =>
      'Voulez-vous vraiment supprimer votre compte ?';

  @override
  String get transfert_dialog_confirm_title =>
      'Voulez-vous continuer le transfert ?';

  @override
  String get transfert_dialog_number => 'Numéro bénéficiaire';

  @override
  String get transfert_dialog_amount => 'Montant à envoyer';

  @override
  String get maha_partenaire_title => 'Nos Partenaire / Inscription Pubs';

  @override
  String welcome_user(String pseudo) {
    return 'Bienvenue $pseudo !';
  }

  @override
  String get or_text => 'OU';

  @override
  String get choose_img => 'Choisir une image';

  @override
  String get browse_image => 'Trouver une image';

  @override
  String get conseil_tip =>
      '< Pour protéger les informations personnelles du conseiller qui a publié le message, nous ne divulguons pas ses données personnelles. >';

  @override
  String get reserver => 'Réserver';

  @override
  String respond_count(String count) {
    return '<Nombre cumulé de répondants : $count>';
  }

  @override
  String get ads_up => 'Publicité en haut';

  @override
  String get ads_down => 'Publicité en bas';

  @override
  String get transferMessagePart1 => 'Vous allez transférer ';

  @override
  String get transferMessagePart2 => ' KARA vers le compte ';

  @override
  String get logout_done => 'Déconnexion effectuée.';

  @override
  String get delete_done => 'Compte supprimé.';

  @override
  String get register_title => 'Inscription';

  @override
  String get register_text =>
      'Rejoignez MIPS pour créer et publier vos annonces, et bien plus encore !';

  @override
  String get register_pseudo_hint => 'Pseudo';

  @override
  String get register_pseudo_validation => 'Erreur: Entrer votre pseudo.';

  @override
  String get register_mail_hint => 'Mail';

  @override
  String get register_mail_validation =>
      'Erreur: Entrer une adresse mail valide.';

  @override
  String get register_password_hint => 'Mot de passe';

  @override
  String get register_new_password_hint => 'Nouveau mot de passe';

  @override
  String get reset_password_title => 'Récupération du compte';

  @override
  String get change_password_title => 'Changement de mot de passe';

  @override
  String get old_password_hint => 'Ancien mot de passe';

  @override
  String get reset_password_submit_button => 'Envoyer';

  @override
  String get validation_code_prompt => 'Code de validation';

  @override
  String get password_change_title => 'Changement de mot de passe';

  @override
  String get reset_password_confirm_button => 'Réinitialiser';

  @override
  String get reset_password_email_prompt =>
      'Entrez votre adresse mail pour réinitialiser votre mot de passe';

  @override
  String validation_email_sent(String emailAddress) {
    return 'Un e-mail a été envoyé à l\'adresse $emailAddress. Veuillez entrer le code de validation et saisir votre nouveau mot de passe.';
  }

  @override
  String get auth_guard_screen_title => 'Authentification requise';

  @override
  String get auth_guard_screen_prompt =>
      'Entrer votre mot de passe pour continuer';

  @override
  String available_date_prompt(String date) {
    return 'Disponible le : $date';
  }

  @override
  String todays_date_prompt(String date) {
    return 'Date : $date';
  }

  @override
  String format_date_ddmmyy(String date) {
    return '$date';
  }

  @override
  String available_premium_date_prompt(String date) {
    return 'Les annonces Premium sont limitées à un maximum de 3, elles seront donc possibles après le $date.';
  }

  @override
  String available_vip_date_prompt(String date) {
    return 'Les annonces VIP sont limitées à un maximum de 3, elles seront donc possibles après le $date.';
  }

  @override
  String get transfer_screen_title => 'Transfert KARA';

  @override
  String get transfer_faka_send_title => 'Transfert envoyé';

  @override
  String get transfer_available_amount => 'Solde disponible';

  @override
  String get transfer_section_title => 'Transfert de KARA vers un autre compte';

  @override
  String get transfer_insufficient => 'Solde insuffisant';

  @override
  String get transfer_id_receiver_hint => 'Numéro du destinataire';

  @override
  String get transfer_amount_send_hint => 'Montant';

  @override
  String transfer_amount_send_error_validation(String solde) {
    return 'Erreur: Entrer une valeur entre 1 et $solde';
  }

  @override
  String bonus_from_announce(String slug) {
    return 'Bonus de l\'annonce $slug';
  }

  @override
  String get password_forget_title =>
      'Pas de panique! Vous pouvez récupérer l’accès à votre compte MIPS facilement.';

  @override
  String get password_forget_option1 => 'Option 1 : Par e-mail';

  @override
  String password_forget_text1(String email) {
    return 'Envoyez-nous un message à $email en indiquant votre nom et le numéro de téléphone utilisé lors de votre inscription.';
  }

  @override
  String get password_forget_option2 => 'Option 2 : Par téléphone';

  @override
  String get password_forget_text2 =>
      'Appelez directement le Service Client MIPS au 038 28 309 29.';

  @override
  String get what_next_title => 'Que se passe-t-il ensuite ?';

  @override
  String get what_next_text =>
      'Notre équipe vous enverra un nouveau mot de passe par SMS sur votre numéro enregistré, sous 24 heures.';

  @override
  String get connexion_temporary_title =>
      'Une fois connecté avec ce mot de passe temporaire :';

  @override
  String get connexion_temporary_text1 => '1. Allez dans Mon Compte MIPS';

  @override
  String get connexion_temporary_text2 =>
      '2. Cliquez sur Modifier le mot de passe';

  @override
  String get connexion_temporary_text3 =>
      '3. Choisissez un nouveau mot de passe personnel et sécurisé';

  @override
  String get friend => 'Ami(e)';

  @override
  String get mips_bonus => 'MIPS vous a offert un bonus';

  @override
  String get kara_partner => 'Partenaire KARA';

  @override
  String get bonus_announce => 'Bonus d\'annonce';

  @override
  String get survey => 'Sondage';

  @override
  String get take_surveys => 'Répondez à des sondages';

  @override
  String get claim_kara_bonuses_popup_ads =>
      'Réclamez des bonus KARA dans les pubs PopUps';

  @override
  String get claim_bonuses_partner_sponsor_pubs =>
      'Réclamez des bonus KARA dans les pubs partenaires et sponsors';

  @override
  String get transfer_id_receiver_error_validation =>
      'Erreur: Tel du destinataire';

  @override
  String get thanks_btn_text => 'Merci !';

  @override
  String get like_btn_text => 'J\'aime';

  @override
  String get register_password_validation =>
      'Erreur: Entrez un mot de passe (6-8 caractères).';

  @override
  String get register_password2_hint => 'Confirmer votre mot de passe';

  @override
  String get register_password2_validation =>
      'Erreur: Resaisir votre mot de passe.';

  @override
  String get register_genre_masculin => 'Masculin';

  @override
  String get register_genre_feminin => 'Féminin';

  @override
  String get register_yearofbirth_hint => 'Date de naissance';

  @override
  String get register_yearofbirth_validation =>
      'Erreur: Seuls les membres âgés de 13 ans et plus peuvent s\'inscrire';

  @override
  String get register_tel_hint => 'Numéro de téléphone';

  @override
  String get register_tel_validation =>
      'Erreur: Entrez 03* ** *** **/ 02* ** *** **';

  @override
  String get choose_option => 'Choisir';

  @override
  String get register_address_hint => 'Province';

  @override
  String get register_address_validation =>
      'Erreur: Entrer une adresse  valide';

  @override
  String get register_accept_cgu => 'J\'accepte les ';

  @override
  String get read_all => 'Tout lu';

  @override
  String get cgu => 'CGU';

  @override
  String get btn_register => 'S\'inscrire';

  @override
  String get connection_error => 'Erreur de connection';

  @override
  String get try_again => 'Réessayer';

  @override
  String get item_favs_removed => 'Supprimé de vos favoris!';

  @override
  String get item_favs_added => 'Ajouté dans vos favoris!';

  @override
  String get confirmation => 'Confirmation';

  @override
  String get amount_deduct =>
      ' sera deduit de votre solde pour publier l\'annonce.';

  @override
  String get wanna_continue => 'Voulez-vous continuer?';

  @override
  String get publish => 'Publier';

  @override
  String get cancel => 'Annuler';

  @override
  String get modify => 'Modifier';

  @override
  String get delete => 'Supprimer';

  @override
  String get add => 'Ajouter';

  @override
  String get error_upload => 'Erreur de chargement';

  @override
  String get new_announce => 'Nouvelle annonce';

  @override
  String get not_supported => 'Action non supportée sur votre appareil.';

  @override
  String get call => 'Appeler';

  @override
  String get comments => 'Commentaires';

  @override
  String get login_required_to_comment =>
      'Vous devez vous connecter pour faire des commentaires.';

  @override
  String get comment_validation_error => 'Erreur: Ajouter un commentaire.';

  @override
  String get load_more_coms => 'Plus de commentaires';

  @override
  String get load_more_messages => 'Plus de messages';

  @override
  String get comment_hint => 'Ecrire un commentaire...';

  @override
  String announce_by(String pseudo) {
    return 'Par $pseudo';
  }

  @override
  String get become_spons_title => 'Devenir Sponsor ou Partenaire';

  @override
  String get become_spons_text =>
      'Contacter nous pour ajouter vos annonces ici en tant que partenaire ou sponsor.';

  @override
  String get incomplete_info => 'Information incomplète';

  @override
  String get incomplete_info_text =>
      'Veuillez remplir / vérifier toutes les informations saisies.';

  @override
  String get announce_favs => 'Annonces favorites';

  @override
  String get menu_favs => 'Menus favoris';

  @override
  String get home => 'Accueil';

  @override
  String get empty_list_announce => 'Aucune annonce n\'a encore été publiée.';

  @override
  String get empty_result => 'Aucun résultat trouvé.';

  @override
  String get annonce_deleted_succesfully => 'L\'annonce a été suprimée.';

  @override
  String get error_loading_image => 'Impossible de charger l\'image.';

  @override
  String get favorite => 'Favoris';

  @override
  String get my_ads => 'Mes Pubs';

  @override
  String get page_not_found => 'Page not found';

  @override
  String get profil => 'Profil';

  @override
  String get view => 'Voir';

  @override
  String get download_dialog_title => 'Mise à jour';

  @override
  String get download_dialog_desc => 'Téléchargement en cours...';

  @override
  String get download_dialog_error => 'Téléchargement échoué';

  @override
  String get text_very_small => 'Très petite';

  @override
  String get text_small => 'Petite';

  @override
  String get text_medium => 'Normale';

  @override
  String get text_large => 'Grande';

  @override
  String get faka_history => 'Historique FAKA';

  @override
  String get selftransfert_error =>
      'Vous ne pouvez pas transférer vers vous-même';

  @override
  String get text_very_large => 'Très grande';
}
