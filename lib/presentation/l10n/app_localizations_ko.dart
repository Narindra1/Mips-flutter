// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get app_name => 'MIPS';

  @override
  String get app_version => '1.0';

  @override
  String get loading_error => '오류가 발생했습니다. 나중에 다시 시도해 주세요.';

  @override
  String get error_operation => '오류가 발생했습니다. 다시 시도해 주세요.';

  @override
  String duration_week(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count주',
      one: '$count주',
    );
    return '$_temp0';
  }

  @override
  String duration_month(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count개월',
      one: '$count개월',
    );
    return '$_temp0';
  }

  @override
  String duration_year(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count년',
      one: '$count년',
    );
    return '$_temp0';
  }

  @override
  String announce_count(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 광고',
      one: '$count 발표',
    );
    return '$_temp0';
  }

  @override
  String get found_ad_that_might_interest_you => 'MIPS에서 당신이 관심을 가질 만한 광고를 하나 찾았습니다.';

  @override
  String online_ads_from(String name) {
    return '$name의 온라인 광고';
  }

  @override
  String get you_earned_kara_bonus => 'KARA 보너스를 받으셨습니다!';

  @override
  String get optional => '선택 과목';

  @override
  String get ad_id => '광고 ID';

  @override
  String get ad_id_is_required => '광고 ID가 필요합니다.';

  @override
  String get add_the_ad_id => '광고 ID를 추가하세요';

  @override
  String get ad_id_doesnt_exist => '광고 ID가 존재하지 않습니다.';

  @override
  String get ad_is_already_pending => '이미 신청서가 접수되어 심사 중입니다.';

  @override
  String get survey_results => '여론조사 결과';

  @override
  String get choose_province => '해당 지역을 선택하세요';

  @override
  String get become_kara_partner => 'KARA 파트너가 되세요';

  @override
  String get request_successfully_sent => '요청이 성공적으로 전송되었습니다.';

  @override
  String get submit_your_request => '요청을 제출하세요';

  @override
  String get ads_default_title => 'MIPS - 슈퍼 앱';

  @override
  String get toast_disconnected => '현재 오프라인 상태입니다.';

  @override
  String get recents_announces => '최근 공지사항';

  @override
  String get announce_sent => '광고 전송됨';

  @override
  String get free => '무료';

  @override
  String get login_intro => 'MIPS는 수천 개의 논문 출판을 제공합니다.';

  @override
  String get register_intro => 'MIPS가 당신을 기다리고 있습니다!';

  @override
  String get notifications => '알림';

  @override
  String get ad_modified => '수정됨';

  @override
  String get announce_sent_extedendtext => '광고가 성공적으로 게시되었습니다!';

  @override
  String get plainte_sent => '제출 성공';

  @override
  String get plainte_sent_extendedtext => '감사합니다. 귀하의 피드백은 MIPS를 개선하는 데 도움이 될 것입니다.';

  @override
  String get announce_mahapartenaire_sent_extendedtext => '관리 팀이 귀하의 요청을 검토할 것입니다.';

  @override
  String get categoris => '카테고리';

  @override
  String get announce_detail => '광고 세부 정보';

  @override
  String get title => '제목';

  @override
  String get ann_title_hint => '여기에 광고 제목을 입력하세요';

  @override
  String get ann_title_validation_error => '오류: 광고 제목을 추가해 주세요';

  @override
  String get ann_desc_title => '간략한 설명';

  @override
  String get ann_desc_hint => '여기에 매우 짧은 설명을 추가하세요';

  @override
  String get ann_desc_validation_error => '오류: 간략한 설명을 추가해 주세요';

  @override
  String get ann_desc_long_title => '상세 설명';

  @override
  String get ann_desc_long_hint => '여기에 광고의 상세 설명을 추가하세요';

  @override
  String get ann_desc_long_validation_error => '오류: 광고 세부 정보를 추가해 주세요';

  @override
  String get ann_emplacement_title => '위치';

  @override
  String get ann_emplacement_hint => '위치 (예: Ankorondrano Antananarivo, Antsirabe)';

  @override
  String get ann_emplacement_validation_error => '오류: 위치를 지정해 주세요';

  @override
  String get ann_contact_title => '연락처';

  @override
  String get ann_contact_hint => '예: 034 00 000 00';

  @override
  String get exemple_pref_hint => '예: ';

  @override
  String add_images_titles(int imagecount) {
    return '이미지 추가 (최대 $imagecount개)';
  }

  @override
  String get add_photo_label => '사진';

  @override
  String add_images_capture_titles(int imagecount) {
    return '스크린샷 ($imagecount 최대)';
  }

  @override
  String get send => '보내기';

  @override
  String sondage_theme_title(int numero) {
    return '테마 $numero';
  }

  @override
  String sondage_fin(String datelimit) {
    return '종료: $datelimit';
  }

  @override
  String get complaints_and_suggestions => '불만 및 제안';

  @override
  String get kara_transfer => 'KARA의 전송';

  @override
  String get using_kara => 'KARA를 사용하여';

  @override
  String get announcement_extension => '공지 연장';

  @override
  String get survey_participation => '설문조사 참여';

  @override
  String get first_connection => '첫 번째 연결';

  @override
  String get ad_consultation => '광고 컨설팅';

  @override
  String get daily_connection => '매일의 연결';

  @override
  String get some_may_be_hidden => '일부 광고는 숨겨져 있을 수 있습니다.';

  @override
  String get followed => '후속 조치';

  @override
  String get connexion_security => '연결 및 보안';

  @override
  String get notice => '알아채다';

  @override
  String get enter_the_validation_code => '인증 코드를 입력하세요';

  @override
  String get create_new_more_secure_password => '새롭고 더 안전한 비밀번호를 만드세요';

  @override
  String get enter_old_pass => '이전 비밀번호를 입력하세요';

  @override
  String get attention => '주목';

  @override
  String get delete_title1 => '계정을 삭제하시겠습니까?';

  @override
  String get delete_subtitle1 => '계정을 삭제하면 개인 데이터와 플랫폼에서의 활동이 영구적으로 삭제됩니다.';

  @override
  String get delete_title2 => '계속 진행하시겠습니까?';

  @override
  String get delete_subtitle2 => '계속 진행하려면 이 작업을 확인해 주세요.';

  @override
  String get confirm => '확인하다';

  @override
  String member_since(String date) {
    return '$date부터 회원이 되었습니다';
  }

  @override
  String get verified_phone => '인증된 전화번호';

  @override
  String count_annonces(String count) {
    return '$count개의 광고';
  }

  @override
  String followed_by_count_member(String count) {
    return '$count명의 회원이 팔로우함';
  }

  @override
  String you_follow_count_member(String count) {
    return '$count명의 회원을 팔로우하고 있습니다.';
  }

  @override
  String get announces => '광고';

  @override
  String get followeds => '뒤따랐다';

  @override
  String get estimate => '추정';

  @override
  String get extend_validity => '연장';

  @override
  String get send_announce => '광고 전송';

  @override
  String get modify_announce => '광고 수정';

  @override
  String get modify_profil_title => '계정 정보';

  @override
  String get announce_partner => '파트너 광고';

  @override
  String get announce_sponsor => '스폰서 광고';

  @override
  String get become_sponsor => '스폰서 되기';

  @override
  String get become_partner => '파트너 되기';

  @override
  String get available_soon => '곧 출시됩니다!';

  @override
  String get ann_option_title => '게시 옵션';

  @override
  String get choose_langue => '언어 선택';

  @override
  String get ann_option_choose_type => '광고 유형을 선택하세요';

  @override
  String get ann_option_choose_duration => '게시 기간을 선택하세요';

  @override
  String get ann_total_amount => '총액';

  @override
  String get ann_mod_title => '광고 수정';

  @override
  String get ann_mod_done => '변경 사항이 저장되었습니다';

  @override
  String get sondage_submit_response => '응답 제출';

  @override
  String get sondage_validation_error => '오류: 옵션을 선택해 주세요';

  @override
  String get sondage_submit_success => '귀하의 응답이 기록되었습니다. 참여해 주셔서 감사합니다.';

  @override
  String get alert_diag_title_error => '오류';

  @override
  String get alert_diag_title_message => '오류가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get alert_dial_auth_requiered_title => '로그인 필요';

  @override
  String get alert_dial_auth_requiered_text => 'MIPS 앱을 완전히 즐기려면 로그인하세요! 광고 게시, 댓글 작성, 광고와 쉽게 상호작용할 수 있습니다.';

  @override
  String get continuer => '계속';

  @override
  String get fermer => '닫기';

  @override
  String get avatar => '아바타';

  @override
  String get voirDetail => '자세히 보기';

  @override
  String get total => '총계';

  @override
  String get faka_bonus => 'KARA 보너스';

  @override
  String get bonus => '보너스:';

  @override
  String get phone_duplicate_error => '이미 사용된 전화번호입니다';

  @override
  String get option_paiement => '결제 옵션';

  @override
  String get recommander_by => '추천인 (선택 사항)';

  @override
  String get recommander_agent_hint => '추천인의 전화번호';

  @override
  String get connexion => '로그인';

  @override
  String get please_wait => '잠시 기다려 주세요...';

  @override
  String get inscription => '회원가입';

  @override
  String get cgu_title => '이용약관 (T&C)';

  @override
  String get cgu_section1_title => '1. 애플리케이션 소개';

  @override
  String get cgu_section1_text => 'MIPS 앱은 FAKA 토큰을 사용하여 광고를 게시하고 조회하는 플랫폼입니다. 본 이용약관(T&C)은 등록된 사용자와 비등록 사용자를 포함한 앱 사용 규칙을 정의합니다.';

  @override
  String get cgu_section2_title => '2. 이용약관 동의';

  @override
  String get cgu_section2_text => 'MIPS 앱에 접속함으로써 사용자는 본 이용약관을 읽었으며 이에 동의함을 인정합니다.';

  @override
  String get cgu_section3_title => '3. 회원가입 및 사용자 계정';

  @override
  String get cgu_section3_text => '특정 기능에 접근하려면 사용자는 다음 정보를 제공하여 계정을 생성해야 합니다:\n- 사용자 이름\n- 성별\n- 출생 연도\n- 거주지\n- 비밀번호\n- 이메일\n- 전화번호\n\n사용자는 정확하고 최신 정보를 제공할 것을 약속합니다. 부정확한 정보가 제공될 경우, MIPS는 계정을 정지하거나 삭제할 권리를 보유합니다.';

  @override
  String get cgu_section4_title => '4. 로그인 없이 사용 (인증 없음)';

  @override
  String get cgu_section4_text => '비등록 사용자는 광고 조회와 같은 앱의 특정 기능에 접근할 수 있습니다. 그러나 게시 및 일부 상호작용에는 사용자 계정이 필요합니다.';

  @override
  String get cgu_section5_title => '5. FAKA 토큰';

  @override
  String get cgu_section5_text => 'FAKA 토큰은 광고 게시를 위해 사용됩니다. FAKA 토큰의 획득 및 사용 조건은 MIPS의 특정 조건에 정의되어 있습니다.';

  @override
  String get cgu_section6_title => '6. 개인정보 보호';

  @override
  String get cgu_section6_text => '회원가입 시 제공된 정보는 당사의 개인정보 보호정책에 따라 처리됩니다. 사용자의 동의 없이 개인정보가 제3자에게 판매되거나 공유되지 않습니다.';

  @override
  String get cgu_section7_title => '7. 사용자 책임';

  @override
  String get cgu_section7_text => '사용자는 다음을 약속합니다:\n- 거짓, 불법, 또는 모욕적인 정보를 포함한 광고를 게시하지 않음.\n- 관련 법률 및 제3자의 권리를 준수함.\n- 앱을 사기적이거나 악의적인 목적으로 사용하지 않음.';

  @override
  String get cgu_section8_title => '8. 이용약관 변경';

  @override
  String get cgu_section8_text => 'MIPS는 본 이용약관을 언제든지 수정할 권리를 보유합니다. 변경 사항은 앱을 통해 사용자에게 통지됩니다.';

  @override
  String get cgu_section9_title => '9. 연락처';

  @override
  String get cgu_section9_text => '이용약관에 대한 질문이 있는 경우, 사용자는 앱 또는 이메일을 통해 MIPS 팀에 연락할 수 있습니다.';

  @override
  String get diag_auth_error_title => '인증 오류';

  @override
  String get diag_auth_error_text => '입력한 정보가 올바른지 확인해 주세요.';

  @override
  String get diag_register_error_title => '회원가입 오류';

  @override
  String diag_register_error_text(String errorMessage) {
    return '회원가입 중 오류가 발생했습니다.\n오류: [$errorMessage]';
  }

  @override
  String get diag_error_title => '오류';

  @override
  String diag_error_text(String errorMessage) {
    return '오류가 발생했습니다.\n오류: [$errorMessage]';
  }

  @override
  String get profil_change_pass_text => '비밀번호 변경';

  @override
  String get changer => '변경';

  @override
  String get tips_mahaol_title => '[공지]';

  @override
  String get tips_mahaol_desc => '다른 회원들에게 흥미로울 수 있는 모든 소식을 공유해 주세요. 명예훼손 및 선정적인 내용은 제재를 받게 됩니다. 각 게시물에 대해 작성자는 <일주일 동안 받은 \'감사\' 수 * 20 KARA>에 해당하는 크레딧을 받게 됩니다.';

  @override
  String get data_managing => '보안 및 데이터 관리';

  @override
  String get login_text_intro => 'MIPS 앱을 완전히 즐기려면 로그인하세요';

  @override
  String get login_username_hint => '전화번호 또는 이메일';

  @override
  String get login_username_validation_error => '오류: 전화번호 또는 이메일 주소를 입력하세요';

  @override
  String get login_password_hint => '비밀번호';

  @override
  String get login_password_validation_error => '오류: 비밀번호를 입력하세요';

  @override
  String get login_stayconnected => '로그인 유지';

  @override
  String get login_forgot_password => '비밀번호를 잊으셨나요?';

  @override
  String get login_not_member => '아직 회원이 아니신가요?';

  @override
  String get login_signup => '회원가입';

  @override
  String get menu_profil_account_info => '계정 정보';

  @override
  String get menu_profil_myavatar => '내 아바타 / KARA';

  @override
  String get menu_profil_delete_data_texte => '계정 및 개인 정보 삭제를 요청하세요.';

  @override
  String get menu_profil_avatar_desc => '현재 아바타';

  @override
  String get menu_profil_solde_disponible => '사용 가능한 잔액';

  @override
  String get mips_unit => 'KARA';

  @override
  String get ariary_unit => 'Ar';

  @override
  String get logout => '로그아웃';

  @override
  String get gerer => '관리';

  @override
  String get annonce => '광고';

  @override
  String get setting_langue => '언어';

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
  String get setting_font_size => '텍스트 크기';

  @override
  String get setting_about => '소개';

  @override
  String get empty_message_list => '아직 받은 메시지가 없습니다';

  @override
  String new_version_available(String version) {
    return '새 버전 사용 가능: $version';
  }

  @override
  String get announcements_of_follow_ups => '후속 조치 발표';

  @override
  String get description => '설명';

  @override
  String get rewards_description => '이러한 퀘스트를 통해 획득한 MIP는 잔액에 추가되며, 이를 사용하여 광고를 게시할 수 있습니다.';

  @override
  String get rewards_title => '광고를 시청하고 Mips를 적립하세요';

  @override
  String get rewards_subtitle1 => '모든 광고를 시청하고';

  @override
  String get rewards_subtitle2 => '50KARA';

  @override
  String get rewards_subtitle3 => '를 추가로 획득하세요';

  @override
  String get conversion => '환산';

  @override
  String get publish_annoucement => '광고를 게재하세요';

  @override
  String get please_contact_us => 'contact@mips.mg로 문의해주세요.';

  @override
  String get currency => '통화';

  @override
  String get source => '원천';

  @override
  String get note => '메모';

  @override
  String get note_exchange_description => '본 정보는 소스에서 제공한 전날 종가 데이터를 기반으로 합니다. 당사는 어떠한 오류에 대해서도 책임을 지지 않습니다.';

  @override
  String get calculation => '환율';

  @override
  String get exchange_rate => '환산';

  @override
  String get follow => '따르다';

  @override
  String get followers => '구독자';

  @override
  String get noone_follow_me_title => '현재 구독자가 없습니다.';

  @override
  String get noone_follow_me_description => '회원들은 귀하의 프로필을 구독하여 귀하의 공지사항을 놓치지 않을 수 있습니다.';

  @override
  String get followings => '구독';

  @override
  String get follow_anyone_title => '아직 팔로우하는 멤버가 없습니다.';

  @override
  String get follow_anyone_description => '회원의 프로필에서 \"팔로우\"를 클릭하면 해당 회원의 공지사항을 놓치지 않을 수 있습니다.';

  @override
  String get delete_account => '계정 삭제';

  @override
  String get delete_your_account => '계정 삭제';

  @override
  String get create_new_strong_password => '새롭고 더 안전한 비밀번호를 만드세요';

  @override
  String get account => '계정';

  @override
  String get my_account => '내 계정';

  @override
  String get wallet => '지갑';

  @override
  String get my_wallet => '내 지갑';

  @override
  String get rewards => '초기';

  @override
  String get get_mips => 'Mips를 받으세요';

  @override
  String get list_of_operations => '작업 목록';

  @override
  String get earnings => '수입';

  @override
  String get all => '모두';

  @override
  String get expenses => '경비';

  @override
  String get transfers => '전송';

  @override
  String get payer => '지불';

  @override
  String get update => '업데이트';

  @override
  String get empty_mes_annonces_list => '아직 광고를 게시하지 않았습니다';

  @override
  String get empty_mes_favoris_list => '아직 즐겨찾기를 추가하지 않았습니다';

  @override
  String get messages_screen_title => '메시지';

  @override
  String get setting_about_app_title => '애플리케이션 정보';

  @override
  String get setting_about_app_desc1 => 'MIPS는 광고 게시 및 검색을 간소화하도록 설계된 직관적인 플랫폼입니다. 판매, 구매 또는 탐색을 원하든, 이 애플리케이션은 일상 용품, 가구, 차량 등 다양한 카테고리를 제공합니다.';

  @override
  String get setting_about_app_desc2 => 'MIPS에서는 KARA 토큰을 사용하여 광고를 게시하거나 가시성을 높일 수 있습니다. 애플리케이션 내에서 커뮤니티와 상호작용하여 무료로 토큰을 획득할 수 있으며, 이를 통해 접근 가능하고 역동적인 경험을 제공합니다.';

  @override
  String get setting_about_propriete_title => '지적 재산권';

  @override
  String get setting_about_propriete_annonce => '광고';

  @override
  String get setting_about_propriete_annonce_text => '광고를 게시하는 사용자는 게시물에 대한 권리를 소유하며 제공된 정보의 정확성에 책임이 있습니다. 부적절한 콘텐츠는 contact@mips.mg으로 우리 팀에 신고할 수 있습니다.';

  @override
  String get setting_about_propriete_app => '애플리케이션';

  @override
  String get setting_about_propriete_app_text => 'MIPS에서 사용된 아이콘은 Icons8.fr 웹사이트에서 가져왔습니다.';

  @override
  String get setting_about_propriete_data_title => '데이터 수집 및 개인정보 보호';

  @override
  String get setting_about_propriete_data_text => 'MIPS는 최소한의 개인 정보만 수집하여 사용자의 개인정보를 보호하는 데 전념합니다. 즉, 사용자의 나이, 전화번호, 이메일 주소, 거주 지역만 수집합니다. 프로필 메뉴를 통해 언제든지 이 데이터 삭제를 요청할 수 있습니다.';

  @override
  String get setting_about_propriete_contact_title => '연락처';

  @override
  String get setting_about_propriete_contact_text => '질문, 제안 또는 도움이 필요한 경우 다음 이메일 주소로 연락해 주세요: contact@mips.mg / +261 38 28 309 29';

  @override
  String get setting_title => '설정';

  @override
  String get forgot_password_title => '비밀번호 찾기';

  @override
  String get acheter_faka => '구매';

  @override
  String get transferer_faka => '전송';

  @override
  String get password_reset_success_toast => '비밀번호가 성공적으로 재설정되었습니다.';

  @override
  String get delete_account_dialog_confirm_title => '정말로 계정을 삭제하시겠습니까?';

  @override
  String get transfert_dialog_confirm_title => '이체를 계속하시겠습니까?';

  @override
  String get transfert_dialog_number => '수취인 번호';

  @override
  String get transfert_dialog_amount => '송금 금액';

  @override
  String get maha_partenaire_title => 'Maha 파트너 / 광고 등록';

  @override
  String welcome_user(String pseudo) {
    return '$pseudo님, 환영합니다!';
  }

  @override
  String get or_text => '또는';

  @override
  String get choose_img => '이미지 선택';

  @override
  String get browse_image => '이미지 탐색';

  @override
  String get conseil_tip => '< 메시지를 게시한 상담자의 개인 정보를 보호하기 위해, 우리는 그들의 개인 정보를 공개하지 않습니다. >';

  @override
  String get reserver => '예약';

  @override
  String respond_count(String count) {
    return '<응답자 누적 수: $count>';
  }

  @override
  String get ads_up => '상단 광고';

  @override
  String get ads_down => '하단 광고';

  @override
  String get transferMessagePart1 => '당신은 이체할 것입니다';

  @override
  String get transferMessagePart2 => 'Mips를 계좌로';

  @override
  String get logout_done => '로그아웃이 완료되었습니다.';

  @override
  String get delete_done => '계정이 삭제되었습니다.';

  @override
  String get register_title => '회원가입';

  @override
  String get register_text => 'MIPS에 가입하여 광고를 만들고 게시하며 더 많은 기능을 즐겨보세요!';

  @override
  String get register_pseudo_hint => '사용자 이름';

  @override
  String get register_pseudo_validation => '오류: 사용자 이름을 입력하세요.';

  @override
  String get register_mail_hint => '이메일';

  @override
  String get register_mail_validation => '오류: 유효한 이메일 주소를 입력하세요.';

  @override
  String get register_password_hint => '비밀번호';

  @override
  String get register_new_password_hint => '새 비밀번호';

  @override
  String get reset_password_title => '계정 복구';

  @override
  String get change_password_title => '비밀번호 변경';

  @override
  String get old_password_hint => '旧密码';

  @override
  String get reset_password_submit_button => '보내기';

  @override
  String get validation_code_prompt => '인증 코드';

  @override
  String get password_change_title => '비밀번호 변경';

  @override
  String get reset_password_confirm_button => '재설정';

  @override
  String get reset_password_email_prompt => '비밀번호를 재설정하려면 이메일 주소를 입력하세요';

  @override
  String validation_email_sent(String emailAddress) {
    return '$emailAddress 주소로 이메일이 전송되었습니다. 인증 코드를 입력하고 새 비밀번호를 제공하십시오.';
  }

  @override
  String get auth_guard_screen_title => '인증 필요';

  @override
  String get auth_guard_screen_prompt => '계속하려면 비밀번호를 입력하세요';

  @override
  String available_date_prompt(String date) {
    return '사용 가능 날짜: $date';
  }

  @override
  String todays_date_prompt(String date) {
    return '날짜 : $date';
  }

  @override
  String format_date_ddmmyy(String date) {
    return '$date';
  }

  @override
  String available_premium_date_prompt(String date) {
    return '프리미엄 광고는 최대 3개로 제한되며, $date 이후에 가능합니다.';
  }

  @override
  String available_vip_date_prompt(String date) {
    return 'VIP 광고는 최대 3개로 제한되며, $date 이후에 가능합니다.';
  }

  @override
  String get transfer_screen_title => 'FAKA 전송';

  @override
  String get transfer_faka_send_title => '전송 완료';

  @override
  String get transfer_available_amount => '사용 가능한 잔액';

  @override
  String get transfer_section_title => '다른 계좌로 FAKA 전송';

  @override
  String get transfer_insufficient => '잔액 부족';

  @override
  String get transfer_id_receiver_hint => '수신자의 전화번호';

  @override
  String get transfer_amount_send_hint => '금액';

  @override
  String transfer_amount_send_error_validation(String solde) {
    return '오류: 1에서 $solde 사이의 값을 입력하세요';
  }

  @override
  String get transfer_id_receiver_error_validation => '오류: 수신자의 전화번호';

  @override
  String get thanks_btn_text => '감사합니다!';

  @override
  String get like_btn_text => '좋아요';

  @override
  String get register_password_validation => '오류: 비밀번호를 입력하세요 (6-8자).';

  @override
  String get register_password2_hint => '비밀번호 확인';

  @override
  String get register_password2_validation => '오류: 비밀번호를 다시 입력하세요.';

  @override
  String get register_genre_masculin => '남성';

  @override
  String get register_genre_feminin => '여성';

  @override
  String get register_yearofbirth_hint => '생년월일';

  @override
  String get register_yearofbirth_validation => '오류: 13세 이상의 회원만 등록할 수 있습니다';

  @override
  String get register_tel_hint => '전화번호';

  @override
  String get register_tel_validation => '오류: 03* ** *** **/ 02* ** *** ** 입력';

  @override
  String get choose_option => '선택';

  @override
  String get register_address_hint => '도';

  @override
  String get register_address_validation => '오류: 유효한 주소를 입력하세요';

  @override
  String get register_accept_cgu => '이용약관에 동의합니다 ';

  @override
  String get read_all => '모두 읽음 ✓';

  @override
  String get cgu => '이용약관';

  @override
  String get btn_register => '회원가입';

  @override
  String get connection_error => '연결 오류';

  @override
  String get try_again => '다시 시도';

  @override
  String get item_favs_removed => '즐겨찾기에서 제거되었습니다!';

  @override
  String get item_favs_added => '즐겨찾기에 추가되었습니다!';

  @override
  String get confirmation => '확인';

  @override
  String get amount_deduct => '광고 게시를 위해 잔액에서 차감됩니다.';

  @override
  String get wanna_continue => '계속하시겠습니까?';

  @override
  String get publish => '게시';

  @override
  String get cancel => '취소';

  @override
  String get modify => '수정';

  @override
  String get delete => '삭제';

  @override
  String get add => '추가';

  @override
  String get error_upload => '업로드 오류';

  @override
  String get new_announce => '새 광고';

  @override
  String get not_supported => '이 기기에서 지원되지 않는 작업입니다.';

  @override
  String get call => '전화';

  @override
  String get comments => '댓글';

  @override
  String get login_required_to_comment => '댓글을 작성하려면 로그인해야 합니다.';

  @override
  String get comment_validation_error => '오류: 댓글을 추가하세요.';

  @override
  String get load_more_coms => '더 많은 댓글';

  @override
  String get load_more_messages => '더 많은 메시지 불러오기';

  @override
  String get comment_hint => '댓글을 작성하세요...';

  @override
  String announce_by(String pseudo) {
    return '$pseudo 작성';
  }

  @override
  String get become_spons_title => '스폰서 또는 파트너 되기';

  @override
  String get become_spons_text => '파트너 또는 스폰서로 광고를 추가하려면 문의해 주세요.';

  @override
  String get incomplete_info => '정보 미완성';

  @override
  String get incomplete_info_text => '입력한 모든 정보를 작성/확인해 주세요.';

  @override
  String get announce_favs => '즐겨찾기 광고';

  @override
  String get menu_favs => '즐겨찾기 메뉴';

  @override
  String get home => '홈';

  @override
  String get empty_list_announce => '아직 게시된 광고가 없습니다.';

  @override
  String get empty_result => '결과를 찾을 수 없습니다.';

  @override
  String get annonce_deleted_succesfully => '광고가 삭제되었습니다.';

  @override
  String get error_loading_image => '이미지를 불러올 수 없습니다.';

  @override
  String get favorite => '즐겨찾기';

  @override
  String get my_ads => '내 광고';

  @override
  String get page_not_found => '페이지를 찾을 수 없습니다';

  @override
  String get profil => '프로필';

  @override
  String get view => '보기';

  @override
  String get download_dialog_title => '업데이트';

  @override
  String get download_dialog_desc => '다운로드 중...';

  @override
  String get download_dialog_error => '다운로드 실패';

  @override
  String get text_very_small => '매우 작게';

  @override
  String get text_small => '작게';

  @override
  String get text_medium => '보통';

  @override
  String get text_large => '크게';

  @override
  String get faka_history => 'FAKA 내역';

  @override
  String get selftransfert_error => '자신에게 이체할 수 없습니다';

  @override
  String get text_very_large => '매우 크게';
}
