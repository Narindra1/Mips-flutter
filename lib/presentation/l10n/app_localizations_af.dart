// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Afrikaans (`af`).
class AppLocalizationsAf extends AppLocalizations {
  AppLocalizationsAf([String locale = 'af']) : super(locale);

  @override
  String get app_name => 'MIPS';

  @override
  String get app_version => '1.0';

  @override
  String get loading_error => 'Nisy olana nitranga, andramo indray azafady.';

  @override
  String get error_operation => 'Nisy olana nitranga, andramo azafady.';

  @override
  String duration_week(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count herinandro',
      one: '$count herinandro',
    );
    return '$_temp0';
  }

  @override
  String duration_month(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count volana',
      one: '$count volana',
    );
    return '$_temp0';
  }

  @override
  String duration_year(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count taona',
      one: '$count taona',
    );
    return '$_temp0';
  }

  @override
  String announce_count(num count) {
    return '$count dokambarotra';
  }

  @override
  String get found_ad_that_might_interest_you => 'Nahita doka tao amin\'ny MIPS aho izay mety hahaliana anao';

  @override
  String online_ads_from(String name) {
    return 'Dokambarotra an-tserasera avy amin\'i $name';
  }

  @override
  String get ad_id => 'ID ny doka';

  @override
  String get ad_id_is_required => 'Ilaina ny ID doka';

  @override
  String get add_the_ad_id => 'Ampio ny ID doka';

  @override
  String get ad_id_doesnt_exist => 'Tsy misy ny ID doka';

  @override
  String get ad_is_already_pending => 'Efa misy fangatahana miandry';

  @override
  String get survey_results => 'Vokatra fanadihadiana';

  @override
  String get choose_province => 'Mifidiana faritany';

  @override
  String get become_kara_partner => 'Tonga mpiara-miasa amin\'ny KARA';

  @override
  String get request_successfully_sent => 'Nalefa soa aman-tsara ny fangatahana';

  @override
  String get submit_your_request => 'Alefaso ny fangatahanao';

  @override
  String get ads_default_title => 'MIPS - Super App';

  @override
  String get toast_disconnected => 'Tsy misy connexion amin\'izao fotoana izao.';

  @override
  String get recents_announces => 'Filazana vao haingana';

  @override
  String get announce_sent => 'Nalefa ny filazana';

  @override
  String get free => 'Maimaim-poana';

  @override
  String get login_intro => 'MIPS dia manolotra lahatsoratra an\'arivony ho anao';

  @override
  String get register_intro => 'MIPS miandry anao!';

  @override
  String get notifications => 'Fampandrenesana';

  @override
  String get ad_modified => 'Nohavaozina';

  @override
  String get announce_sent_extedendtext => 'Voapetraka soa aman-tsara ny filazanao!';

  @override
  String get plainte_sent => 'Nalefa soa aman-tsara';

  @override
  String get plainte_sent_extendedtext => 'Misaotra! Hanampy anay hanatsara an\'i MIPS ny hevitrao.';

  @override
  String get announce_mahapartenaire_sent_extendedtext => 'Hodinihin\'ny ekipan\'ny administrasiona ny fangatahanao.';

  @override
  String get categoris => 'Sokajy';

  @override
  String get announce_detail => 'Antsipirihan’ny filazana';

  @override
  String get title => 'Lohateny';

  @override
  String get ann_title_hint => 'Soraty eto ny lohatenin’ny filazana';

  @override
  String get ann_title_validation_error => 'Hadisoana: Ampidiro azafady ny lohatenin’ny filazana';

  @override
  String get ann_desc_title => 'Famaritana fohy';

  @override
  String get ann_desc_hint => 'Ampidiro eto ny famaritana fohy dia fohy';

  @override
  String get ann_desc_validation_error => 'Hadisoana: Ampidiro azafady ny famaritana fohy';

  @override
  String get ann_desc_long_title => 'Famaritana amin’ny antsipiriany';

  @override
  String get ann_desc_long_hint => 'Ampidiro eto ny antsipirihan’ny filazanao';

  @override
  String get ann_desc_long_validation_error => 'Hadisoana: Ampidiro azafady ny antsipirihan’ny filazana';

  @override
  String get ann_emplacement_title => 'Toerana';

  @override
  String get ann_emplacement_hint => 'Toerana (oh: Ankorondrano Antananarivo, Antsirabe)';

  @override
  String get ann_emplacement_validation_error => 'Hadisoana: Lazao azafady ny toerana';

  @override
  String get ann_contact_title => 'Fifandraisana';

  @override
  String get ann_contact_hint => 'Oh: 034 00 000 00';

  @override
  String get exemple_pref_hint => 'Oh: ';

  @override
  String add_images_titles(int imagecount) {
    return 'Ampio sary (hatramin’ny $imagecount)';
  }

  @override
  String get add_photo_label => 'Sary';

  @override
  String add_images_capture_titles(int imagecount) {
    return 'Capture d’écran (hatramin’ny $imagecount)';
  }

  @override
  String get send => 'Alefa';

  @override
  String sondage_theme_title(int numero) {
    return 'Lohahevitra $numero';
  }

  @override
  String sondage_fin(String datelimit) {
    return 'Farany: $datelimit';
  }

  @override
  String get complaints_and_suggestions => 'Fitarainana sy soso-kevitra';

  @override
  String get kara_transfer => 'Famindrana KARA';

  @override
  String get using_kara => 'Mampiasa KARA';

  @override
  String get announcement_extension => 'Fanitarana ny fanambarana';

  @override
  String get survey_participation => 'Fandraisana anjara amin\'ny fanadihadiana';

  @override
  String get first_connection => 'Fifandraisana voalohany';

  @override
  String get ad_consultation => 'Fifampidinihana momba ny dokam-barotra';

  @override
  String get daily_connection => 'Fifandraisana isan\'andro';

  @override
  String get some_may_be_hidden => 'Certaines peuvent être cachées';

  @override
  String get followed => 'Narahina';

  @override
  String get connexion_security => 'Connexion sy fiarovana';

  @override
  String get notice => 'Filazana';

  @override
  String get enter_the_validation_code => 'Ampidiro ny kaody fanamarinana';

  @override
  String get create_new_more_secure_password => 'Mamòna tenimiafina vaovao sy azo antoka kokoa';

  @override
  String get enter_old_pass => 'Ampidiro ny tenimiafina taloha';

  @override
  String get attention => 'Fampitandremana';

  @override
  String get delete_title1 => 'Tena te-hamafa ny kaontinao ve ianao ?';

  @override
  String get delete_subtitle1 => 'Ny famafana ny kaontinao dia hiteraka famafana tanteraka ny mombamomba anao sy ny asanao rehetra ao amin’ny sehatra.';

  @override
  String get delete_title2 => 'Te hanohy ihany ve ianao ?';

  @override
  String get delete_subtitle2 => 'Azafady, hamafiso ity hetsika ity raha mbola te hanohy ianao.';

  @override
  String get confirm => 'Hamafiso';

  @override
  String member_since(String date) {
    return 'Mpikambana hatramin’ny $date';
  }

  @override
  String get verified_phone => 'Voamarina ny laharana finday';

  @override
  String count_annonces(String count) {
    return '$count filazana';
  }

  @override
  String followed_by_count_member(String count) {
    return 'Arahin\'ny mpikambana $count';
  }

  @override
  String you_follow_count_member(String count) {
    return 'Manaraka mpikambana $count ianao';
  }

  @override
  String get announces => 'Dokambarotra';

  @override
  String get followeds => 'Narahina';

  @override
  String get estimate => 'Tombana';

  @override
  String get extend_validity => 'Hanitatra';

  @override
  String get send_announce => 'Alefa ny filazana';

  @override
  String get modify_announce => 'Hanova ny filazana';

  @override
  String get modify_profil_title => 'Mombamomba ny kaonty';

  @override
  String get announce_partner => 'Filazana mpiara-miombona antoka';

  @override
  String get announce_sponsor => 'Filazana sponsor';

  @override
  String get become_sponsor => 'Ho lasa Sponsor';

  @override
  String get become_partner => 'Ho lasa Mpiara-miombon’antoka';

  @override
  String get available_soon => 'Ho avy tsy ho ela !';

  @override
  String get ann_option_title => 'Safidy famoahana';

  @override
  String get choose_langue => 'Hisafidy fiteny';

  @override
  String get ann_option_choose_type => 'Misafidiana ny karazana filazanao';

  @override
  String get ann_option_choose_duration => 'Misafidiana ny faharetan’ny famoahana';

  @override
  String get ann_total_amount => 'Totaly';

  @override
  String get ann_mod_title => 'Hanova ny filazanao';

  @override
  String get ann_mod_done => 'Voarakitra ny fanovana';

  @override
  String get sondage_submit_response => 'Alefa ny valiny';

  @override
  String get sondage_validation_error => 'Hadisoana: Misafidiana safidy iray azafady';

  @override
  String get sondage_submit_success => 'Voarakitra ny valin-teninao, misaotra tamin’ny fandraisanao anjara.';

  @override
  String get alert_diag_title_error => 'Hadisoana';

  @override
  String get alert_diag_title_message => 'Nisy olana nitranga, andramo indray azafady.';

  @override
  String get alert_dial_auth_requiered_title => 'Mila miditra ianao';

  @override
  String get alert_dial_auth_requiered_text => 'Midira ao amin’ny MIPS mba hahazoanao manararaotra tanteraka ny fampiharana ! Afaka mametraka, manome hevitra ary miara-mifandray amin’ny filazana ianao.';

  @override
  String get continuer => 'Hanohy';

  @override
  String get fermer => 'Hidio';

  @override
  String get avatar => 'Avatar';

  @override
  String get voirDetail => 'Antsipirihany bebe kokoa';

  @override
  String get total => 'Totaly';

  @override
  String get faka_bonus => 'KARA bonus';

  @override
  String get bonus => 'Bonus:';

  @override
  String get phone_duplicate_error => 'Efa nampiasaina io laharana finday io.';

  @override
  String get option_paiement => 'Safidy fandoavana';

  @override
  String get recommander_by => 'Nolazain’ny (tsy voatery)';

  @override
  String get recommander_agent_hint => 'Laharan’ny mpanoro hevitra';

  @override
  String get connexion => 'Fidirana';

  @override
  String get please_wait => 'Andraso azafady...';

  @override
  String get inscription => 'Fisoratana anarana';

  @override
  String get cgu_title => 'Fepetra sy fepetra fampiasana (CGU)';

  @override
  String get cgu_section1_title => '1. Fampahafantarana ny Fampiharana';

  @override
  String get cgu_section1_text => 'Ny fampiharana MIPS dia sehatra ahafahan’ny mpampiasa mamoaka sy mijery filazana amin’ny alalan’ny Jeton FAKA. Ity CGU ity dia mamaritra ny fitsipika amin’ny fampiasana ny fampiharana ho an’ny mpampiasa voasoratra anarana sy ireo miditra tsy misy kaonty.';

  @override
  String get cgu_section2_title => '2. Fankatoavana ny CGU';

  @override
  String get cgu_section2_text => 'Amin’ny fidirana ao amin’ny fampiharana MAHAFAKA dia manaiky ny mpampiasa fa namaky sy nanaiky ireo fepetra voalaza ao amin’ny CGU.';

  @override
  String get cgu_section3_title => '3. Fisoratana anarana sy Kaonty mpampiasa';

  @override
  String get cgu_section3_text => 'Mba hahazoana miditra amin’ny fiasa sasany dia tsy maintsy mamorona kaonty ny mpampiasa amin’ny fanomezana ireto fampahalalana ireto:\n- Solon’anarana\n- Lahy/Vavy\n- Taona nahaterahana\n- Toerana onenana\n- Tenimiafina\n- Email\n- Laharana finday\n\nNy mpampiasa dia tokony hanome vaovao marina sy havaozina. Raha misy vaovao diso dia manan-jo hanakana na hamafa ny kaonty i MAHAFAKA.';

  @override
  String get cgu_section4_title => '4. Fampiasana tsy misy Fidirana (Tsy misy Kaonty)';

  @override
  String get cgu_section4_text => 'Afaka mijery filazana ny mpampiasa tsy voasoratra anarana, saingy ny famoahana sy fiasa sasany dia mitaky kaonty.';

  @override
  String get cgu_section5_title => '5. Jeton FAKA';

  @override
  String get cgu_section5_text => 'Ny Jeton FAKA dia ampiasaina amin’ny famoahana filazana. Ny fitsipika momba ny fahazoana sy fampiasana azy dia voafaritra amin’ny fepetra manokana an’i MAHAFAKA.';

  @override
  String get cgu_section6_title => '6. Fiarovana ny Mombamomba manokana';

  @override
  String get cgu_section6_text => 'Ny vaovao omena mandritra ny fisoratana anarana dia karakaraina araka ny politikanay momba ny tsiambaratelo. Tsy misy data manokana amidy na zaraina amin’ny antoko fahatelo raha tsy amin’ny fankatoavan’ny mpampiasa.';

  @override
  String get cgu_section7_title => '7. Andraikitry ny Mpampiasa';

  @override
  String get cgu_section7_text => 'Ny mpampiasa dia manaiky ny:\n- Tsy hametraka filazana misy vaovao diso, tsy ara-dalàna na manevateva.\n- Hanaja ny lalàna sy ny zon’ny hafa.\n- Tsy hampiasa ny fampiharana amin’ny tanjona hosoka na ratsy.';

  @override
  String get cgu_section8_title => '8. Fanovana ny CGU';

  @override
  String get cgu_section8_text => 'Manan-jo hanova ny CGU i MAHAFAKA amin’ny fotoana rehetra. Hampandrenesina ao amin’ny fampiharana ny mpampiasa raha misy fanovana.';

  @override
  String get cgu_section9_title => '9. Fifandraisana';

  @override
  String get cgu_section9_text => 'Raha misy fanontaniana momba ny CGU dia afaka mifandray amin’ny ekipan’i MAHAFAKA ao amin’ny fampiharana na amin’ny email ny mpampiasa.';

  @override
  String get diag_auth_error_title => 'Hadisoana amin’ny fidirana';

  @override
  String get diag_auth_error_text => 'Hamarino tsara ny angon-drakitra nampidirinao.';

  @override
  String get diag_register_error_title => 'Hadisoana nandritra ny fisoratana anarana';

  @override
  String diag_register_error_text(String errorMessage) {
    return 'Nisy olana nitranga nandritra ny fisoratana anarana.\nHadisoana: [$errorMessage]';
  }

  @override
  String get diag_error_title => 'Hadisoana';

  @override
  String diag_error_text(String errorMessage) {
    return 'Nisy olana nitranga.\nHadisoana: [$errorMessage]';
  }

  @override
  String get profil_change_pass_text => 'Hanova tenimiafina';

  @override
  String get changer => 'Hanova';

  @override
  String get tips_mahaol_title => '[Fampahafantarana]';

  @override
  String get tips_mahaol_desc => 'Zarao eto ireo vaovao mety hahasoa ny mpiara-miasa ao amin\'ny vondrom-piarahamonina. Ny fanendrikendrehana sy votoaty manafintohina dia mety hiteraka sazy. Ho an’ny lahatsoratra tsirairay dia hahazo isa ny mpanoratra, araka ny <isan’ny \"Misaotra\" azony ao anatin’ny herinandro * 20 KARA>.';

  @override
  String get data_managing => 'Fiarovana sy fitantanana angona';

  @override
  String get login_text_intro => 'Midira ao amin\'ny MIPS mba hahazoana fidirana feno amin\'ny fampiharana';

  @override
  String get login_username_hint => 'Laharana finday na mailaka';

  @override
  String get login_username_validation_error => 'Hadisoana: Ampidiro ny laharana finday na ny adiresy mailakao';

  @override
  String get login_password_hint => 'Tenimiafina';

  @override
  String get login_password_validation_error => 'Hadisoana: Ampidiro ny tenimiafinao';

  @override
  String get login_stayconnected => 'Hijanon-kifandray';

  @override
  String get login_forgot_password => 'Hadino ny tenimiafina?';

  @override
  String get login_not_member => 'Tsy mbola mpikambana?';

  @override
  String get login_signup => 'Hisoratra anarana';

  @override
  String get menu_profil_account_info => 'Mombamomba ny kaonty';

  @override
  String get menu_profil_myavatar => 'Avatara / KARA-ko';

  @override
  String get menu_profil_delete_data_texte => 'Mangataka ny famafana ny kaontinao sy ny mombamomba anao manokana.';

  @override
  String get menu_profil_avatar_desc => 'Ny avataranao ankehitriny';

  @override
  String get menu_profil_solde_disponible => 'Solde misy';

  @override
  String get mips_unit => 'KARA';

  @override
  String get ariary_unit => 'Ar';

  @override
  String get logout => 'Hivoaka';

  @override
  String get gerer => 'Hitantana';

  @override
  String get annonce => 'Filazana';

  @override
  String get setting_langue => 'Fiteny';

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
  String get setting_font_size => 'Haben’ny soratra';

  @override
  String get setting_about => 'Mombamomba';

  @override
  String get empty_message_list => 'Tsy mbola naharay hafatra ianao';

  @override
  String new_version_available(String version) {
    return 'Misy kinova vaovao: $version';
  }

  @override
  String get announcements_of_follow_ups => 'Fanambarana momba ny fanaraha-maso';

  @override
  String get description => 'Famaritana';

  @override
  String get rewards_description => 'Ny KARA azonao avy amin\'ireto asa ireto dia ampiana ao amin’ny solde-nao, azonao ampiasaina hanoratana na hampiroboroboana ny filazanao.';

  @override
  String get rewards_title => 'Hijery dokambarotra, hahazo KARA';

  @override
  String get rewards_subtitle1 => 'Hijery ny dokambarotra rehetra, mahazoa';

  @override
  String get rewards_subtitle2 => '50 KARA';

  @override
  String get rewards_subtitle3 => 'fanampiny';

  @override
  String get conversion => 'Fiovam-bola';

  @override
  String get publish_annoucement => 'Hamoaka filazana';

  @override
  String get please_contact_us => 'Azafady, mifandraisa aminay amin\'ny contact@mips.mg';

  @override
  String get currency => 'Vola';

  @override
  String get source => 'Loharano';

  @override
  String get note => 'Fanamarihana';

  @override
  String get note_exchange_description => 'Ireo vaovao ireo dia avy amin’ny tahirin-kevitry ny andro lasa nalefan’ny Loharano. Tsy tompon’andraikitra izahay raha misy tsy fahatomombanana.';

  @override
  String get calculation => 'Kajy';

  @override
  String get exchange_rate => 'Tahan\'ny fifanakalozana';

  @override
  String get follow => 'Hanara-dia';

  @override
  String get followers => 'Mpankasitraka';

  @override
  String get noone_follow_me_title => 'Tsy mbola misy manaraka anao';

  @override
  String get noone_follow_me_description => 'Afaka manara-dia ny mombamomba anao ny mpikambana mba hahazo vaovao rehefa misy filazanao';

  @override
  String get followings => 'Fanarahanao';

  @override
  String get follow_anyone_title => 'Tsy mbola manara-dia olona ianao';

  @override
  String get follow_anyone_description => 'Tsindrio ny \"Hanara-dia\" amin’ny mombamomba ny mpikambana iray mba hahazo vaovao amin’ny filazany rehetra';

  @override
  String get delete_account => 'Hamafa kaonty';

  @override
  String get delete_your_account => 'Hamafa ny kaontinao';

  @override
  String get create_new_strong_password => 'Hamorona tenimiafina mafy kokoa';

  @override
  String get account => 'Kaonty';

  @override
  String get my_account => 'Kaontiko';

  @override
  String get wallet => 'Kitapo';

  @override
  String get my_wallet => 'Kitapoko';

  @override
  String get rewards => 'Valisoa';

  @override
  String get get_mips => 'Mahazo KARA';

  @override
  String get list_of_operations => 'Lisitr\'ireo hetsika';

  @override
  String get earnings => 'Vola miditra';

  @override
  String get all => 'Rehetra';

  @override
  String get expenses => 'Fandaniana';

  @override
  String get transfers => 'Famindram-bola';

  @override
  String get payer => 'Handoa';

  @override
  String get update => 'Havaozina';

  @override
  String get empty_mes_annonces_list => 'Tsy mbola nanoratra filazana ianao';

  @override
  String get empty_mes_favoris_list => 'Tsy mbola nanampy favoris ianao';

  @override
  String get messages_screen_title => 'Hafatra';

  @override
  String get setting_about_app_title => 'Mombamomba ny fampiharana';

  @override
  String get setting_about_app_desc1 => 'MIPS dia sehatra tsotra ampiasaina hanamorana ny famoahana sy fijerena filazana. Raha hivarotra, hividy na hitady zavatra ianao, dia misy sokajy maro: fitaovana isan’andro, fanaka, fiara ary maro hafa.';

  @override
  String get setting_about_app_desc2 => 'Azo ampiasaina hanoratana na hampiakatra ny filazanao ny token KARA. Azonao atao ihany koa ny mahazo KARA maimaim-poana amin’ny fandraisana anjara ao amin’ny vondrom-piarahamonina, mahatonga ny traikefa ho mora sy mavitrika.';

  @override
  String get setting_about_propriete_title => 'Zon\'ny asa soratra';

  @override
  String get setting_about_propriete_annonce => 'Filazana';

  @override
  String get setting_about_propriete_annonce_text => 'Ny mpampiasa manoratra filazana dia tompon’ny zon’ny votoatiny ary tompon’andraikitra amin’ny fahamarinan’ny vaovao arosony. Raha misy votoaty tsy mety dia azo atorohana amin’ny contact@mips.mg.';

  @override
  String get setting_about_propriete_app => 'Fampiharana';

  @override
  String get setting_about_propriete_app_text => 'Ny sary famantarana ampiasaina ao amin\'ny MIPS dia avy amin\'ny Icons8.fr.';

  @override
  String get setting_about_propriete_data_title => 'Fangonana sy fiarovana angona';

  @override
  String get setting_about_propriete_data_text => 'MIPS dia manolo-tena hiaro ny tsiambaratelonao ka manangona ny mombamomba tena ilaina ihany: taona, laharana finday, mailaka ary faritra onenana. Azonao angatahina ny famafana azy ireo amin’ny alalan’ny menio ao amin’ny mombamomba anao.';

  @override
  String get setting_about_propriete_contact_title => 'Fifandraisana';

  @override
  String get setting_about_propriete_contact_text => 'Raha misy fanontaniana, soso-kevitra na fangatahana fanampiana, azafady mifandraisa aminay amin\'ny contact@mips.mg / +261 38 28 309 29';

  @override
  String get setting_title => 'Fikirakirana';

  @override
  String get forgot_password_title => 'Hadino ny tenimiafina';

  @override
  String get acheter_faka => 'Hividy';

  @override
  String get transferer_faka => 'Hamindra';

  @override
  String get password_reset_success_toast => 'Vita soa aman-tsara ny famerenana ny tenimiafinao.';

  @override
  String get delete_account_dialog_confirm_title => 'Tianao tokoa ve hofafana ny kaontinao ?';

  @override
  String get transfert_dialog_confirm_title => 'Hanohy ny famindrana ve ianao ?';

  @override
  String get transfert_dialog_number => 'Laharan\'ny mpandray';

  @override
  String get transfert_dialog_amount => 'Vola halefa';

  @override
  String get maha_partenaire_title => 'Namana / Fisoratana Pub';

  @override
  String welcome_user(String pseudo) {
    return 'Tongasoa $pseudo !';
  }

  @override
  String get or_text => 'NA';

  @override
  String get choose_img => 'Misafidiana sary';

  @override
  String get browse_image => 'Mitady sary';

  @override
  String get conseil_tip => '< Mba hiarovana ny mombamomba manokana ny mpanolotsaina nandefa ny hafatra, dia tsy havoaka ny angon-drakitra manokana azy. >';

  @override
  String get reserver => 'Manendry';

  @override
  String respond_count(String count) {
    return '<Isan\'ny olona namaly hatramin\'izao : $count>';
  }

  @override
  String get ads_up => 'Dokambarotra ambony';

  @override
  String get ads_down => 'Dokambarotra ambany';

  @override
  String get transferMessagePart1 => 'Hampita ianao ';

  @override
  String get transferMessagePart2 => ' KARA mankany amin\'ny kaonty ';

  @override
  String get logout_done => 'Niala soa aman-tsara.';

  @override
  String get delete_done => 'Voafafa ny kaonty.';

  @override
  String get register_title => 'Fisoratana anarana';

  @override
  String get register_text => 'Midira ao MIPS mba hamoronana sy handefa ny dokambarotrao, ary zavatra maro hafa!';

  @override
  String get register_pseudo_hint => 'Anarana';

  @override
  String get register_pseudo_validation => 'Hadisoana: Ampidiro ny anaranao.';

  @override
  String get register_mail_hint => 'Mailaka';

  @override
  String get register_mail_validation => 'Hadisoana: Ampidiro ny adiresy mailaka marina.';

  @override
  String get register_password_hint => 'Teny miafina';

  @override
  String get register_new_password_hint => 'Teny miafina vaovao';

  @override
  String get reset_password_title => 'Famerenana ny kaonty';

  @override
  String get change_password_title => 'Fanovana ny teny miafina';

  @override
  String get old_password_hint => 'Teny miafina taloha';

  @override
  String get reset_password_submit_button => 'Alefaso';

  @override
  String get validation_code_prompt => 'Kaody fanamarinana';

  @override
  String get password_change_title => 'Fanovana ny teny miafina';

  @override
  String get reset_password_confirm_button => 'Avereno';

  @override
  String get reset_password_email_prompt => 'Ampidiro ny adiresy mailaka mba hamerenana ny teny miafina';

  @override
  String validation_email_sent(String emailAddress) {
    return 'Nalefa tamin\'ny adiresy $emailAddress ny mailaka. Ampidiro ny kaody fanamarinana ary soraty ny teny miafina vaovao.';
  }

  @override
  String get auth_guard_screen_title => 'Takiana ny fanamarinana';

  @override
  String get auth_guard_screen_prompt => 'Ampidiro ny teny miafinao mba hanohy';

  @override
  String available_date_prompt(String date) {
    return 'Hita amin\'ny : $date';
  }

  @override
  String todays_date_prompt(String date) {
    return 'Daty : $date';
  }

  @override
  String format_date_ddmmyy(String date) {
    return '$date';
  }

  @override
  String available_premium_date_prompt(String date) {
    return 'Voafetra hatramin\'ny 3 ny dokambarotra Premium, ka azo atao aorian\'ny $date.';
  }

  @override
  String available_vip_date_prompt(String date) {
    return 'Voafetra hatramin\'ny 3 ny dokambarotra VIP, ka azo atao aorian\'ny $date.';
  }

  @override
  String get transfer_screen_title => 'Famindrana KARA';

  @override
  String get transfer_faka_send_title => 'Nalefa ny famindrana';

  @override
  String get transfer_available_amount => 'Saldo azo ampiasaina';

  @override
  String get transfer_section_title => 'Famindrana KARA mankany amin\'ny kaonty hafa';

  @override
  String get transfer_insufficient => 'Tsy ampy ny saldo';

  @override
  String get transfer_id_receiver_hint => 'Nomeraon\'ny mpandray';

  @override
  String get transfer_amount_send_hint => 'Habe';

  @override
  String transfer_amount_send_error_validation(String solde) {
    return 'Hadisoana: Ampidiro ny sandany eo anelanelan\'ny 1 sy $solde';
  }

  @override
  String get transfer_id_receiver_error_validation => 'Hadisoana: Nomeraon\'ny mpandray';

  @override
  String get thanks_btn_text => 'Misaotra !';

  @override
  String get like_btn_text => 'Tiako';

  @override
  String get register_password_validation => 'Hadisoana: Ampidiro ny teny miafina (6-8 tarehintsoratra).';

  @override
  String get register_password2_hint => 'Hamarino ny teny miafinao';

  @override
  String get register_password2_validation => 'Hadisoana: Avereno ny teny miafinao.';

  @override
  String get register_genre_masculin => 'Lehilahy';

  @override
  String get register_genre_feminin => 'Vehivavy';

  @override
  String get register_yearofbirth_hint => 'Daty nahaterahana';

  @override
  String get register_yearofbirth_validation => 'Hadisoana: Ny mpikambana 13 taona sy miakatra ihany no afaka misoratra anarana';

  @override
  String get register_tel_hint => 'Nomeraon-telefaona';

  @override
  String get register_tel_validation => 'Hadisoana: Ampidiro 03* ** *** **/ 02* ** *** **';

  @override
  String get choose_option => 'Misafidiana';

  @override
  String get register_address_hint => 'Faritra';

  @override
  String get register_address_validation => 'Hadisoana: Ampidiro adiresy marina';

  @override
  String get register_accept_cgu => 'Ekeo ny ';

  @override
  String get read_all => 'Vakiana rehetra ✓';

  @override
  String get cgu => 'CGU';

  @override
  String get btn_register => 'Misoratra anarana';

  @override
  String get connection_error => 'Hadisoana tamin\'ny fifandraisana';

  @override
  String get try_again => 'Andramo indray';

  @override
  String get item_favs_removed => 'Esorina amin\'ny tianao!';

  @override
  String get item_favs_added => 'Ampiana amin\'ny tianao!';

  @override
  String get confirmation => 'Fanamafisana';

  @override
  String get amount_deduct => ' hoesorina amin\'ny saldonao mba handefasana ny dokambarotra.';

  @override
  String get wanna_continue => 'Te hanohy ve ianao?';

  @override
  String get publish => 'Alefaso';

  @override
  String get cancel => 'Hanafoana';

  @override
  String get modify => 'Hanova';

  @override
  String get delete => 'Hamafa';

  @override
  String get add => 'Hampiana';

  @override
  String get error_upload => 'Hadisoana tamin\'ny fandefasana';

  @override
  String get new_announce => 'Dokambarotra vaovao';

  @override
  String get not_supported => 'Tsy tohanana amin\'ny fitaovanao ity hetsika ity.';

  @override
  String get call => 'Antsoy';

  @override
  String get comments => 'Hevitra';

  @override
  String get login_required_to_comment => 'Tsy maintsy miditra ianao vao afaka manoratra hevitra.';

  @override
  String get comment_validation_error => 'Hadisoana: Ampidiro hevitra.';

  @override
  String get load_more_coms => 'Hevitra fanampiny';

  @override
  String get load_more_messages => 'Hafatra fanampiny';

  @override
  String get comment_hint => 'Soraty hevitra...';

  @override
  String announce_by(String pseudo) {
    return 'Avy amin\'i $pseudo';
  }

  @override
  String get become_spons_title => 'Mivadika ho Sponsor na Mpiara-miasa';

  @override
  String get become_spons_text => 'Mifandraisa aminay mba hanampiana ny dokambarotrao eto ho mpiara-miasa na sponsor.';

  @override
  String get incomplete_info => 'Misy tsy feno ny mombamomba';

  @override
  String get incomplete_info_text => 'Fenoy / Hamarino ny mombamomba rehetra.';

  @override
  String get announce_favs => 'Dokambarotra tiana';

  @override
  String get menu_favs => 'Menu tiana';

  @override
  String get home => 'Fandraisana';

  @override
  String get empty_list_announce => 'Tsy mbola misy dokambarotra nalefa.';

  @override
  String get empty_result => 'Tsy misy valiny hita.';

  @override
  String get annonce_deleted_succesfully => 'Voafafa ny dokambarotra.';

  @override
  String get error_loading_image => 'Tsy afaka nampiditra ny sary.';

  @override
  String get favorite => 'Tiako';

  @override
  String get my_ads => 'Ny dokambarotrako';

  @override
  String get page_not_found => 'Pejy tsy hita';

  @override
  String get profil => 'Mombamomba';

  @override
  String get view => 'Jereo';

  @override
  String get download_dialog_title => 'Fanavaozana';

  @override
  String get download_dialog_desc => 'Misintona...';

  @override
  String get download_dialog_error => 'Tsy tafavoaka ny fisintomana';

  @override
  String get text_very_small => 'Kely be';

  @override
  String get text_small => 'Kely';

  @override
  String get text_medium => 'Mahazatra';

  @override
  String get text_large => 'Lehibe';

  @override
  String get faka_history => 'Tantaran\'ny FAKA';

  @override
  String get selftransfert_error => 'Tsy afaka mandefa any amin\'ny tenanao ianao';

  @override
  String get text_very_large => 'Lehibe be';
}
