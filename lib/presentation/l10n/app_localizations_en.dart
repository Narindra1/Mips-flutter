// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'MIPS';

  @override
  String get app_version => '1.0';

  @override
  String get loading_error => 'An error occurred, please try again later.';

  @override
  String get error_operation => 'An error occurred, please try again.';

  @override
  String duration_week(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count weeks',
      one: '$count week',
    );
    return '$_temp0';
  }

  @override
  String duration_month(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months',
      one: '$count month',
    );
    return '$_temp0';
  }

  @override
  String duration_year(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years',
      one: '$count year',
    );
    return '$_temp0';
  }

  @override
  String announce_count(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ads',
      one: '$count ad',
    );
    return '$_temp0';
  }

  @override
  String get found_ad_that_might_interest_you => 'I found an ad on MIPS that might interest you';

  @override
  String online_ads_from(String name) {
    return 'Online ads from $name';
  }

  @override
  String get you_earned_kara_bonus => 'You have earned a KARA bonus!';

  @override
  String get optional => 'Optional';

  @override
  String get ad_id => 'Ad ID';

  @override
  String get ad_id_is_required => 'Ad ID is required';

  @override
  String get add_the_ad_id => 'Add the ad ID';

  @override
  String get ad_id_doesnt_exist => 'Ad ID doesn\'t exist';

  @override
  String get ad_is_already_pending => 'Ad is already pending';

  @override
  String get survey_results => 'Survey results';

  @override
  String get choose_province => 'Choose province(s)';

  @override
  String get become_kara_partner => 'Become a KARA partner';

  @override
  String get request_successfully_sent => 'Request successfully sent';

  @override
  String get submit_your_request => 'Submit your request';

  @override
  String get ads_default_title => 'MIPS - Super App';

  @override
  String get toast_disconnected => 'You are currently offline.';

  @override
  String get recents_announces => 'Recents announces';

  @override
  String get announce_sent => 'Ad sent';

  @override
  String get free => 'Free';

  @override
  String get login_intro => 'MIPS offers you thousands of article publications';

  @override
  String get register_intro => 'MIPS is waiting for you!';

  @override
  String get notifications => 'Notifications';

  @override
  String get ad_modified => 'Modified';

  @override
  String get announce_sent_extedendtext => 'Your ad has been successfully published!';

  @override
  String get plainte_sent => 'Submission successful';

  @override
  String get plainte_sent_extendedtext => 'Thank you, your feedback will help us improve MIPS.';

  @override
  String get announce_mahapartenaire_sent_extendedtext => 'The administration team will review your request.';

  @override
  String get categoris => 'Category';

  @override
  String get announce_detail => 'Ad details';

  @override
  String get title => 'Title';

  @override
  String get ann_title_hint => 'Enter the ad title here';

  @override
  String get ann_title_validation_error => 'Error: Please add a title for the ad';

  @override
  String get ann_desc_title => 'Brief description';

  @override
  String get ann_desc_hint => 'Add a very short description here';

  @override
  String get ann_desc_validation_error => 'Error: Please add a brief description';

  @override
  String get ann_desc_long_title => 'Detailed description';

  @override
  String get ann_desc_long_hint => 'Add a detailed description of your ad here';

  @override
  String get ann_desc_long_validation_error => 'Error: Please add the details of your ad';

  @override
  String get ann_emplacement_title => 'Location';

  @override
  String get ann_emplacement_hint => 'Location (e.g., Ankorondrano Antananarivo, Antsirabe)';

  @override
  String get ann_emplacement_validation_error => 'Error: Please specify a location';

  @override
  String get ann_contact_title => 'Contact';

  @override
  String get ann_contact_hint => 'Ex: 034 00 000 00';

  @override
  String get exemple_pref_hint => 'Ex: ';

  @override
  String add_images_titles(int imagecount) {
    return 'Add images ($imagecount max)';
  }

  @override
  String get add_photo_label => 'Photo';

  @override
  String add_images_capture_titles(int imagecount) {
    return 'Screenshot ($imagecount max)';
  }

  @override
  String get send => 'Send';

  @override
  String sondage_theme_title(int numero) {
    return 'Theme $numero';
  }

  @override
  String sondage_fin(String datelimit) {
    return 'End: $datelimit';
  }

  @override
  String get complaints_and_suggestions => 'Complaints and suggestions';

  @override
  String get kara_transfer => 'KARA Transfer';

  @override
  String get using_kara => 'Using KARA';

  @override
  String get announcement_extension => 'Announcement extension';

  @override
  String get survey_participation => 'Survey participation';

  @override
  String get first_connection => 'First connection';

  @override
  String get ad_consultation => 'Ad consultation';

  @override
  String get daily_connection => 'Daily connection';

  @override
  String get some_may_be_hidden => 'Some ads may be hidden';

  @override
  String get followed => 'Followed';

  @override
  String get connexion_security => 'Connection and Security';

  @override
  String get notice => 'Notice';

  @override
  String get enter_the_validation_code => 'Enter the validation code';

  @override
  String get create_new_more_secure_password => 'Create a new, more secure password';

  @override
  String get enter_old_pass => 'Enter the old password';

  @override
  String get attention => 'Attention';

  @override
  String get delete_title1 => 'Are you sure you want to delete your account ?';

  @override
  String get delete_subtitle1 => 'Deleting your account will result in the permanent deletion of your personal data and your activity on the platform.';

  @override
  String get delete_title2 => 'Do you still wish to continue ?';

  @override
  String get delete_subtitle2 => 'Please confirm this action if you wish to proceed.';

  @override
  String get confirm => 'Confirm';

  @override
  String member_since(String date) {
    return 'Member since $date';
  }

  @override
  String get verified_phone => 'Verified phone number';

  @override
  String count_annonces(String count) {
    return '$count ads';
  }

  @override
  String followed_by_count_member(String count) {
    return 'Followed by $count members';
  }

  @override
  String you_follow_count_member(String count) {
    return 'You follow $count members';
  }

  @override
  String get announces => 'Ads';

  @override
  String get followeds => 'Followed';

  @override
  String get estimate => 'Estimate';

  @override
  String get extend_validity => 'Extend';

  @override
  String get send_announce => 'Send ad';

  @override
  String get modify_announce => 'Edit ad';

  @override
  String get modify_profil_title => 'Information du compte';

  @override
  String get announce_partner => 'Partner Ad';

  @override
  String get announce_sponsor => 'Sponsor Ad';

  @override
  String get become_sponsor => 'Become a Sponsor';

  @override
  String get become_partner => 'Become a Partner';

  @override
  String get available_soon => 'Coming soon!';

  @override
  String get ann_option_title => 'Publication options';

  @override
  String get choose_langue => 'Choose language';

  @override
  String get ann_option_choose_type => 'Choose the type of your ad';

  @override
  String get ann_option_choose_duration => 'Choose the publication duration';

  @override
  String get ann_total_amount => 'Total';

  @override
  String get ann_mod_title => 'Edit your ad';

  @override
  String get ann_mod_done => 'Changes saved';

  @override
  String get sondage_submit_response => 'Submit response';

  @override
  String get sondage_validation_error => 'Error: Please choose an option';

  @override
  String get sondage_submit_success => 'Your response has been recorded, thank you for your participation.';

  @override
  String get alert_diag_title_error => 'Error';

  @override
  String get alert_diag_title_message => 'An error occurred, please try again.';

  @override
  String get alert_dial_auth_requiered_title => 'Login required';

  @override
  String get alert_dial_auth_requiered_text => 'Log in to fully enjoy the MIPS app! Post, comment, and interact with ads easily.';

  @override
  String get continuer => 'Continue';

  @override
  String get fermer => 'Close';

  @override
  String get avatar => 'Avatar';

  @override
  String get voirDetail => 'More details';

  @override
  String get total => 'Total';

  @override
  String get faka_bonus => 'KARA bonus';

  @override
  String get bonus => 'Bonus:';

  @override
  String get phone_duplicate_error => 'Phone number already used';

  @override
  String get option_paiement => 'Payment options';

  @override
  String get recommander_by => 'Recommended by (optional)';

  @override
  String get recommander_agent_hint => 'Referrer\'s phone number';

  @override
  String get connexion => 'Login';

  @override
  String get please_wait => 'Please wait...';

  @override
  String get inscription => 'Sign up';

  @override
  String get cgu_title => 'Terms and Conditions (T&C)';

  @override
  String get cgu_section1_title => '1. About the Application';

  @override
  String get cgu_section1_text => 'The MIPS app is a platform for posting and viewing ads using the FAKA Token. These Terms and Conditions (T&C) define the rules for using the app, for both registered and non-registered users.';

  @override
  String get cgu_section2_title => '2. Acceptance of the T&C';

  @override
  String get cgu_section2_text => 'By accessing the MAHAFAKA app, the user acknowledges having read these T&C and agrees to comply with them.';

  @override
  String get cgu_section3_title => '3. Registration and User Account';

  @override
  String get cgu_section3_text => 'To access certain features, the user must create an account by providing the following information:\n- Username\n- Gender\n- Year of birth\n- Place of residence\n- Password\n- Email\n- Phone number\n\nThe user agrees to provide accurate and up-to-date information. If inaccurate information is provided, MAHAFAKA reserves the right to suspend or delete the account.';

  @override
  String get cgu_section4_title => '4. Use Without Login (No Authentication)';

  @override
  String get cgu_section4_text => 'Non-registered users can access certain features of the app, such as viewing ads. However, posting and some interactions require a user account.';

  @override
  String get cgu_section5_title => '5. FAKA Token';

  @override
  String get cgu_section5_text => 'The FAKA Token is used for posting ads. The terms for obtaining and using the FAKA Token are defined in MAHAFAKA’s specific conditions.';

  @override
  String get cgu_section6_title => '6. Personal Data Protection';

  @override
  String get cgu_section6_text => 'Information provided during registration is processed in accordance with our privacy policy. No personal data will be sold or shared with third parties without the user’s consent.';

  @override
  String get cgu_section7_title => '7. User Responsibilities';

  @override
  String get cgu_section7_text => 'The user agrees to:\n- Not post ads containing false, illegal, or offensive information.\n- Comply with applicable laws and third-party rights.\n- Not use the app for fraudulent or malicious purposes.';

  @override
  String get cgu_section8_title => '8. Changes to the T&C';

  @override
  String get cgu_section8_text => 'MAHAFAKA reserves the right to modify these T&C at any time. Users will be notified of changes via the app.';

  @override
  String get cgu_section9_title => '9. Contact';

  @override
  String get cgu_section9_text => 'For any questions about the T&C, users can contact the MAHAFAKA team via the app or by email.';

  @override
  String get diag_auth_error_title => 'Authentication error';

  @override
  String get diag_auth_error_text => 'Please check that the information you entered is correct.';

  @override
  String get diag_register_error_title => 'Registration error';

  @override
  String diag_register_error_text(String errorMessage) {
    return 'An error occurred during registration.\nError: [$errorMessage]';
  }

  @override
  String get diag_error_title => 'Error';

  @override
  String diag_error_text(String errorMessage) {
    return 'An error has occurred.\nError: [$errorMessage]';
  }

  @override
  String get profil_change_pass_text => 'Change password';

  @override
  String get changer => 'Change';

  @override
  String get tips_mahaol_title => '[Notice]';

  @override
  String get tips_mahaol_desc => 'Please share any news that might interest other members. Defamation and any sensationalist content will result in sanctions. For each post, the author will receive a credit equivalent to <the number of \'Thank you\' received during one week * 20 KARA>.';

  @override
  String get data_managing => 'Security and data management';

  @override
  String get login_text_intro => 'Log in to MIPS to fully enjoy the app';

  @override
  String get login_username_hint => 'Phone number or email';

  @override
  String get login_username_validation_error => 'Enter your phone number or email address';

  @override
  String get login_password_hint => 'Password';

  @override
  String get login_password_validation_error => 'Enter your password';

  @override
  String get login_stayconnected => 'Stay logged in';

  @override
  String get login_forgot_password => 'Forgot password?';

  @override
  String get login_not_member => 'Not a member yet?';

  @override
  String get login_signup => 'Sign up';

  @override
  String get menu_profil_account_info => 'Account Information';

  @override
  String get menu_profil_myavatar => 'My Avatar / KARA';

  @override
  String get menu_profil_delete_data_texte => 'Request the deletion of your account and personal information.';

  @override
  String get menu_profil_avatar_desc => 'Your current avatar';

  @override
  String get menu_profil_solde_disponible => 'Available Balance';

  @override
  String get mips_unit => 'KARA';

  @override
  String get ariary_unit => 'Ar';

  @override
  String get logout => 'Log out';

  @override
  String get gerer => 'Manage';

  @override
  String get annonce => 'Ad';

  @override
  String get setting_langue => 'Language';

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
  String get setting_font_size => 'Text size';

  @override
  String get setting_about => 'About';

  @override
  String get empty_message_list => 'No messages received yet';

  @override
  String new_version_available(String version) {
    return 'New version available: $version';
  }

  @override
  String get announcements_of_follow_ups => 'Announcements of follow-ups';

  @override
  String get description => 'Description';

  @override
  String get rewards_description => 'The KARA you earn from these quests will be added to your balance; you can use them to post your ads.';

  @override
  String get rewards_title => 'Watch ads, earn KARA';

  @override
  String get rewards_subtitle1 => 'Watch all the ads, earn an extra';

  @override
  String get rewards_subtitle2 => '50KARA';

  @override
  String get rewards_subtitle3 => '';

  @override
  String get conversion => 'Conversion';

  @override
  String get publish_annoucement => 'Publish the ad';

  @override
  String get please_contact_us => 'Please contact us at contact@mips.mg';

  @override
  String get currency => 'Currency';

  @override
  String get source => 'Source';

  @override
  String get note => 'Note';

  @override
  String get note_exchange_description => 'This information represents the previous day\'s closing data provided by the Source. Our company accepts no responsibility for any errors.';

  @override
  String get calculation => 'Calculation';

  @override
  String get exchange_rate => 'Exchange rate';

  @override
  String get follow => 'Follow';

  @override
  String get followers => 'Followers';

  @override
  String get noone_follow_me_title => 'You do not have any followers at the moment';

  @override
  String get noone_follow_me_description => 'Members can subscribe to your profile so they don\'t miss any of your announcements.';

  @override
  String get followings => 'Followings';

  @override
  String get follow_anyone_title => 'You are not following any members yet';

  @override
  String get follow_anyone_description => 'Click \"Follow\" on a member\'s profile to make sure you don\'t miss any of their announcements.';

  @override
  String get delete_account => 'Delete account';

  @override
  String get delete_your_account => 'Delete your account';

  @override
  String get create_new_strong_password => 'Create a new more secure password';

  @override
  String get account => 'Account';

  @override
  String get my_account => 'My account';

  @override
  String get wallet => 'Wallet';

  @override
  String get my_wallet => 'My Wallet';

  @override
  String get rewards => 'Rewards';

  @override
  String get get_mips => 'Get KARA';

  @override
  String get list_of_operations => 'List of operations';

  @override
  String get earnings => 'Earnings';

  @override
  String get all => 'All';

  @override
  String get expenses => 'Expenses';

  @override
  String get transfers => 'Transfers';

  @override
  String get payer => 'Pay';

  @override
  String get update => 'Update';

  @override
  String get empty_mes_annonces_list => 'You haven\'t posted any ads yet';

  @override
  String get empty_mes_favoris_list => 'You haven\'t added any favorites yet';

  @override
  String get messages_screen_title => 'Messages';

  @override
  String get setting_about_app_title => 'About the Application';

  @override
  String get setting_about_app_desc1 => 'MIPS is an intuitive platform designed to simplify the posting and browsing of ads. Whether you want to sell, buy, or explore, the application offers a wide variety of categories, including everyday items, furniture, vehicles, and much more.';

  @override
  String get setting_about_app_desc2 => 'With MIPS, you can use the KARA token to post your ads or boost their visibility. Earn tokens for free by engaging with the community directly from the application, making the experience both accessible and dynamic.';

  @override
  String get setting_about_propriete_title => 'Intellectual Property';

  @override
  String get setting_about_propriete_annonce => 'Ads';

  @override
  String get setting_about_propriete_annonce_text => 'Users who post ads own the rights to their publications and are responsible for the accuracy of the information provided. Any inappropriate content can be reported to our team via the email address contact@mips.mg';

  @override
  String get setting_about_propriete_app => 'Application';

  @override
  String get setting_about_propriete_app_text => 'The icons used in MIPS are sourced from the website Icons8.fr.';

  @override
  String get setting_about_propriete_data_title => 'Data Collection and Privacy';

  @override
  String get setting_about_propriete_data_text => 'MIPS is committed to protecting your privacy by collecting minimal personal information, namely: your age, phone number, email address, and province of residence. You can request the deletion of this data at any time through your profile menu.';

  @override
  String get setting_about_propriete_contact_title => 'Contact';

  @override
  String get setting_about_propriete_contact_text => 'For any questions, suggestions, or assistance, please contact us at the following email address: contact@mips.mg / +261 38 28 309 29';

  @override
  String get setting_title => 'Settings';

  @override
  String get forgot_password_title => 'Forgot password';

  @override
  String get acheter_faka => 'Buy';

  @override
  String get transferer_faka => 'Transfer';

  @override
  String get password_reset_success_toast => 'Your password has been successfully reset.';

  @override
  String get delete_account_dialog_confirm_title => 'Do you really want to delete your account?';

  @override
  String get transfert_dialog_confirm_title => 'Do you want to continue the transfer?';

  @override
  String get transfert_dialog_number => 'Recipient number';

  @override
  String get transfert_dialog_amount => 'Amount to send';

  @override
  String get maha_partenaire_title => 'Our Partners / Ad Registration';

  @override
  String welcome_user(String pseudo) {
    return 'Welcome $pseudo!';
  }

  @override
  String get or_text => 'OR';

  @override
  String get choose_img => 'Choose an image';

  @override
  String get browse_image => 'Browse an image';

  @override
  String get conseil_tip => '< To protect the personal information of the advisor who posted the message, we do not disclose their personal details. >';

  @override
  String get reserver => 'Reserve';

  @override
  String respond_count(String count) {
    return '<Cumulative number of respondents: $count>';
  }

  @override
  String get ads_up => 'Advertisement at the top';

  @override
  String get ads_down => 'Advertisement at the bottom';

  @override
  String get transferMessagePart1 => 'You are going to transfer';

  @override
  String get transferMessagePart2 => 'KARA to the account';

  @override
  String get logout_done => 'Logged out successfully.';

  @override
  String get delete_done => 'Account deleted.';

  @override
  String get register_title => 'Sign up';

  @override
  String get register_text => 'Join MIPS to create and post your ads, and much more!';

  @override
  String get register_pseudo_hint => 'Username';

  @override
  String get register_pseudo_validation => 'Error: Enter your username.';

  @override
  String get register_mail_hint => 'Email';

  @override
  String get register_mail_validation => 'Error: Enter a valid email address.';

  @override
  String get register_password_hint => 'Password';

  @override
  String get register_new_password_hint => 'New password';

  @override
  String get reset_password_title => 'Account Recovery';

  @override
  String get change_password_title => 'Password Change';

  @override
  String get old_password_hint => 'Old password';

  @override
  String get reset_password_submit_button => 'Send';

  @override
  String get validation_code_prompt => 'Validation Code';

  @override
  String get password_change_title => 'Password Change';

  @override
  String get reset_password_confirm_button => 'Reset';

  @override
  String get reset_password_email_prompt => 'Enter your email address to reset your password';

  @override
  String validation_email_sent(String emailAddress) {
    return 'An email has been sent to the address $emailAddress. Please enter the validation code and provide your new password.';
  }

  @override
  String get auth_guard_screen_title => 'Authentication required';

  @override
  String get auth_guard_screen_prompt => 'Enter your password to continue';

  @override
  String available_date_prompt(String date) {
    return 'Available on: $date';
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
    return 'Premium ads are limited to a maximum of 3, so they will be available after $date.';
  }

  @override
  String available_vip_date_prompt(String date) {
    return 'VIP ads are limited to a maximum of 3, so they will be available after $date.';
  }

  @override
  String get transfer_screen_title => 'KARA Transfer';

  @override
  String get transfer_faka_send_title => 'Transfer Sent';

  @override
  String get transfer_available_amount => 'Available Balance';

  @override
  String get transfer_section_title => 'Transfer KARA to Another Account';

  @override
  String get transfer_insufficient => 'Insufficient Balance';

  @override
  String get transfer_id_receiver_hint => 'Recipient\'s phone number';

  @override
  String get transfer_amount_send_hint => 'Amount';

  @override
  String transfer_amount_send_error_validation(String solde) {
    return 'Error: Enter a value between 1 and $solde';
  }

  @override
  String get transfer_id_receiver_error_validation => 'Error: Recipient\'s phone number';

  @override
  String get thanks_btn_text => 'Thank you!';

  @override
  String get like_btn_text => 'Like';

  @override
  String get register_password_validation => 'Error: Enter a password (6-8 characters).';

  @override
  String get register_password2_hint => 'Confirm your password';

  @override
  String get register_password2_validation => 'Error: Re-enter your password.';

  @override
  String get register_genre_masculin => 'Male';

  @override
  String get register_genre_feminin => 'Female';

  @override
  String get register_yearofbirth_hint => 'Date of birth';

  @override
  String get register_yearofbirth_validation => 'Error: Only members aged 13 and older can register';

  @override
  String get register_tel_hint => 'Phone number';

  @override
  String get register_tel_validation => 'Error: Enter 03* ** *** **/ 02* ** *** **';

  @override
  String get choose_option => 'Choose';

  @override
  String get register_address_hint => 'Province';

  @override
  String get register_address_validation => 'Error: Enter a valid address';

  @override
  String get register_accept_cgu => 'I accept the ';

  @override
  String get read_all => 'All read ✓';

  @override
  String get cgu => 'T&C';

  @override
  String get btn_register => 'Sign up';

  @override
  String get connection_error => 'Connection error';

  @override
  String get try_again => 'Try again';

  @override
  String get item_favs_removed => 'Removed from your favorites!';

  @override
  String get item_favs_added => 'Added to your favorites!';

  @override
  String get confirmation => 'Confirmation';

  @override
  String get amount_deduct => ' will be deducted from your balance to publish the ad.';

  @override
  String get wanna_continue => 'Do you want to continue?';

  @override
  String get publish => 'Publish';

  @override
  String get cancel => 'Cancel';

  @override
  String get modify => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get add => 'Add';

  @override
  String get error_upload => 'Upload error';

  @override
  String get new_announce => 'New ad';

  @override
  String get not_supported => 'Action not supported on your device.';

  @override
  String get call => 'Call';

  @override
  String get comments => 'Comments';

  @override
  String get login_required_to_comment => 'You must log in to comment.';

  @override
  String get comment_validation_error => 'Error: Add a comment.';

  @override
  String get load_more_coms => 'More comments';

  @override
  String get load_more_messages => 'Load more messages';

  @override
  String get comment_hint => 'Write a comment...';

  @override
  String announce_by(String pseudo) {
    return 'By $pseudo';
  }

  @override
  String get become_spons_title => 'Become a Sponsor or Partner';

  @override
  String get become_spons_text => 'Contact us to add your ads here as a partner or sponsor.';

  @override
  String get incomplete_info => 'Incomplete information';

  @override
  String get incomplete_info_text => 'Please fill in / verify all the information provided.';

  @override
  String get announce_favs => 'Favorite ads';

  @override
  String get menu_favs => 'Favorite menus';

  @override
  String get home => 'Home';

  @override
  String get empty_list_announce => 'No ads have been published yet.';

  @override
  String get empty_result => 'No results found.';

  @override
  String get annonce_deleted_succesfully => 'The ad has been deleted.';

  @override
  String get error_loading_image => 'Unable to load the image.';

  @override
  String get favorite => 'Favorites';

  @override
  String get my_ads => 'My Ads';

  @override
  String get page_not_found => 'Page not found';

  @override
  String get profil => 'Profile';

  @override
  String get view => 'View';

  @override
  String get download_dialog_title => 'Update';

  @override
  String get download_dialog_desc => 'Downloading...';

  @override
  String get download_dialog_error => 'Download failed';

  @override
  String get text_very_small => 'Very small';

  @override
  String get text_small => 'Small';

  @override
  String get text_medium => 'Normal';

  @override
  String get text_large => 'Large';

  @override
  String get faka_history => 'Historique FAKA';

  @override
  String get selftransfert_error => 'You cannot transfer to yourself';

  @override
  String get text_very_large => 'Very large';
}
