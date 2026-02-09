// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get app_name => 'MIPS';

  @override
  String get app_version => '1.0';

  @override
  String get loading_error => '发生错误，请稍后重试。';

  @override
  String get error_operation => '发生错误，请重试。';

  @override
  String duration_week(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count周',
      one: '$count周',
    );
    return '$_temp0';
  }

  @override
  String duration_month(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count个月',
      one: '$count个月',
    );
    return '$_temp0';
  }

  @override
  String duration_year(num count) {
    return '$count年';
  }

  @override
  String announce_count(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 广告',
      one: '$count 公告',
    );
    return '$_temp0';
  }

  @override
  String get found_ad_that_might_interest_you => '我在MIPS上找到一个你可能感兴趣的广告。';

  @override
  String online_ads_from(String name) {
    return '来自$name的在线广告';
  }

  @override
  String get delete_all => '全部删除';

  @override
  String get you_earned_kara_bonus => '您已获得 KARA 奖励！';

  @override
  String get optional => '选修的';

  @override
  String get ad_id => '广告 ID';

  @override
  String get ad_id_is_required => '需要广告 ID';

  @override
  String get add_the_ad_id => '添加广告 ID';

  @override
  String get ad_id_doesnt_exist => '广告 ID 不存在';

  @override
  String get ad_is_already_pending => '申请已在待处理中';

  @override
  String get survey_results => '民意调查结果';

  @override
  String get choose_province => '选择省份';

  @override
  String get become_kara_partner => '成为 KARA 合作伙伴';

  @override
  String get request_successfully_sent => '请求已成功发送';

  @override
  String get submit_your_request => '提交您的请求';

  @override
  String get ads_default_title => 'MIPS - 超级应用';

  @override
  String get toast_disconnected => '您当前处于离线状态。';

  @override
  String get recents_announces => '近期公告';

  @override
  String get announce_sent => '广告已发送';

  @override
  String get free => '自由的';

  @override
  String get login_intro => 'MIPS 为您提供数千篇论文出版物';

  @override
  String get register_intro => 'MIPS 等你來體驗！';

  @override
  String get notifications => '通知';

  @override
  String get ad_modified => '修改的';

  @override
  String get announce_sent_extedendtext => '您的广告已成功发布！';

  @override
  String get plainte_sent => '提交成功';

  @override
  String get plainte_sent_extendedtext => '感谢您，您的反馈将帮助我们改进 MIPS。';

  @override
  String get announce_mahapartenaire_sent_extendedtext => '行政团队将审查您的请求。';

  @override
  String get categoris => '类别';

  @override
  String get announce_detail => '广告详情';

  @override
  String get title => '标题';

  @override
  String get ann_title_hint => '在此输入广告标题';

  @override
  String get ann_title_validation_error => '错误：请为广告添加标题';

  @override
  String get ann_desc_title => '简短描述';

  @override
  String get ann_desc_hint => '在此添加非常简短的描述';

  @override
  String get ann_desc_validation_error => '错误：请添加简短描述';

  @override
  String get ann_desc_long_title => '详细描述';

  @override
  String get ann_desc_long_hint => '在此添加您的广告详细描述';

  @override
  String get ann_desc_long_validation_error => '错误：请添加广告的详细信息';

  @override
  String get ann_emplacement_title => '地点';

  @override
  String get ann_emplacement_hint => '地点（例如：Ankorondrano Antananarivo, Antsirabe）';

  @override
  String get ann_emplacement_validation_error => '错误：请指定一个地点';

  @override
  String get ann_contact_title => '联系方式';

  @override
  String get ann_contact_hint => '例: 034 00 000 00';

  @override
  String get exemple_pref_hint => '例: ';

  @override
  String add_images_titles(int imagecount) {
    return '添加图片（最多$imagecount张）';
  }

  @override
  String get add_photo_label => '照片';

  @override
  String add_images_capture_titles(int imagecount) {
    return '屏幕截图 ($imagecount 最大)';
  }

  @override
  String get send => '发送';

  @override
  String sondage_theme_title(int numero) {
    return '主题 $numero';
  }

  @override
  String sondage_fin(String datelimit) {
    return '结束: $datelimit';
  }

  @override
  String get complaints_and_suggestions => '投诉和建议';

  @override
  String get kara_transfer => 'KARA转账';

  @override
  String get using_kara => '使用 KARA';

  @override
  String get announcement_extension => '公告延期';

  @override
  String get survey_participation => '调查参与';

  @override
  String get first_connection => '首次连接';

  @override
  String get ad_consultation => '广告咨询';

  @override
  String get daily_connection => '每日联系';

  @override
  String get some_may_be_hidden => '部分广告可能已被隐藏。';

  @override
  String get followed => '跟进';

  @override
  String get connexion_security => '连接与安全';

  @override
  String get notice => '注意';

  @override
  String get enter_the_validation_code => '请输入验证码';

  @override
  String get create_new_more_secure_password => '创建一个新的、更安全的密码';

  @override
  String get enter_old_pass => '请输入旧密码';

  @override
  String get attention => '注意力';

  @override
  String get delete_title1 => '您确定要删除您的帐户吗？';

  @override
  String get delete_subtitle1 => '删除您的帐户将导致您的个人数据和您在平台上的所有活动被永久删除。';

  @override
  String get delete_title2 => '你还想继续吗？';

  @override
  String get delete_subtitle2 => '如果您希望继续，请确认此操作。';

  @override
  String get confirm => '确认';

  @override
  String member_since(String date) {
    return '自$date年起成为会员';
  }

  @override
  String get verified_phone => '已验证的电话号码';

  @override
  String count_annonces(String count) {
    return '$count 个广告';
  }

  @override
  String followed_by_count_member(String count) {
    return '随后有 $count 位成员';
  }

  @override
  String you_follow_count_member(String count) {
    return '您关注了 $count 位成员';
  }

  @override
  String get announces => '广告';

  @override
  String get followeds => '随后';

  @override
  String get estimate => '估计';

  @override
  String get extend_validity => '延长';

  @override
  String get send_announce => '发送广告';

  @override
  String get modify_announce => '编辑广告';

  @override
  String get modify_profil_title => '账户信息';

  @override
  String get announce_partner => '合作伙伴广告';

  @override
  String get announce_sponsor => '赞助广告';

  @override
  String get become_sponsor => '成为赞助商';

  @override
  String get become_partner => '成为合作伙伴';

  @override
  String get available_soon => '即将推出！';

  @override
  String get ann_option_title => '发布选项';

  @override
  String get choose_langue => '选择语言';

  @override
  String get ann_option_choose_type => '选择您的广告类型';

  @override
  String get ann_option_choose_duration => '选择发布时长';

  @override
  String get ann_total_amount => '总额';

  @override
  String get ann_mod_title => '编辑您的广告';

  @override
  String get ann_mod_done => '更改已保存';

  @override
  String get sondage_submit_response => '提交回复';

  @override
  String get sondage_validation_error => '错误：请选择一个选项';

  @override
  String get sondage_submit_success => '您的回复已记录，感谢您的参与。';

  @override
  String get alert_diag_title_error => '错误';

  @override
  String get alert_diag_title_message => '发生错误，请重试。';

  @override
  String get alert_dial_auth_requiered_title => '需要登录';

  @override
  String get alert_dial_auth_requiered_text => '登录以充分体验MIPS应用！轻松发布广告、评论和与广告互动。';

  @override
  String get continuer => '继续';

  @override
  String get fermer => '关闭';

  @override
  String get avatar => '头像';

  @override
  String get voirDetail => '查看更多详情';

  @override
  String get total => '总计';

  @override
  String get faka_bonus => 'KARA 奖金';

  @override
  String get bonus => '奖金：';

  @override
  String get phone_duplicate_error => '이미 사용된 전화번호입니다';

  @override
  String get option_paiement => '支付选项';

  @override
  String get recommander_by => '推荐人（可选）';

  @override
  String get recommander_agent_hint => '推荐人的电话号码';

  @override
  String get connexion => '登录';

  @override
  String get please_wait => '请稍候...';

  @override
  String get inscription => '注册';

  @override
  String get cgu_title => '条款和条件 (T&C)';

  @override
  String get cgu_section1_title => '1. 关于应用程序';

  @override
  String get cgu_section1_text => 'MIPS应用是一个使用FAKA代币发布和查看广告的平台。本条款和条件(T&C)定义了注册用户和非注册用户使用应用的规则。';

  @override
  String get cgu_section2_title => '2. 接受条款和条件';

  @override
  String get cgu_section2_text => '通过访问MIPS应用，用户确认已阅读本条款和条件并同意遵守。';

  @override
  String get cgu_section3_title => '3. 注册和用户账户';

  @override
  String get cgu_section3_text => '要访问某些功能，用户必须通过提供以下信息创建账户：\n- 用户名\n- 性别\n- 出生年份\n- 居住地\n- 密码\n- 电子邮件\n- 电话号码\n\n用户同意提供准确且最新的信息。如果提供的信息不准确，MIPS保留暂停或删除账户的权利。';

  @override
  String get cgu_section4_title => '4. 无需登录使用（无认证）';

  @override
  String get cgu_section4_text => '未注册用户可以访问应用的某些功能，例如查看广告。然而，发布广告和某些互动需要用户账户。';

  @override
  String get cgu_section5_title => '5. FAKA代币';

  @override
  String get cgu_section5_text => 'FAKA代币用于发布广告。获取和使用FAKA代币的条款在MIPS的特定条件中定义。';

  @override
  String get cgu_section6_title => '6. 个人信息保护';

  @override
  String get cgu_section6_text => '注册时提供的信息将根据我们的隐私政策进行处理。未经用户同意，个人信息不会出售或与第三方共享。';

  @override
  String get cgu_section7_title => '7. 用户责任';

  @override
  String get cgu_section7_text => '用户同意：\n- 不发布包含虚假、非法或冒犯性信息的广告。\n- 遵守适用法律和第三方权利。\n- 不将应用用于欺诈或恶意目的。';

  @override
  String get cgu_section8_title => '8. 条款和条件变更';

  @override
  String get cgu_section8_text => 'MIPS保留随时修改本条款和条件的权利。用户将通过应用收到更改通知。';

  @override
  String get cgu_section9_title => '9. 联系方式';

  @override
  String get cgu_section9_text => '如对条款和条件有任何疑问，用户可通过应用或电子邮件联系MIPS团队。';

  @override
  String get diag_auth_error_title => '认证错误';

  @override
  String get diag_auth_error_text => '请检查您输入的信息是否正确。';

  @override
  String get diag_register_error_title => '注册错误';

  @override
  String diag_register_error_text(String errorMessage) {
    return '注册过程中发生错误。\n错误：[$errorMessage]';
  }

  @override
  String get diag_error_title => '错误';

  @override
  String diag_error_text(String errorMessage) {
    return '发生了一个错误。\n错误：[$errorMessage]';
  }

  @override
  String get profil_change_pass_text => '更改密码';

  @override
  String get changer => '更改';

  @override
  String get tips_mahaol_title => '[通知]';

  @override
  String get tips_mahaol_desc => '请分享可能让其他成员感兴趣的任何新闻。诽谤和任何耸人听闻的内容将导致处罚。每篇帖子，作者将获得相当于<一周内收到的“感谢”数量 * 20 KARA>的信用。';

  @override
  String get data_managing => '보안 및 데이터 관리';

  @override
  String get login_text_intro => '登录MIPS以充分体验应用';

  @override
  String get login_username_hint => '电话号码或电子邮件';

  @override
  String get login_username_validation_error => '错误：请输入您的电话号码或电子邮件地址';

  @override
  String get login_password_hint => '密码';

  @override
  String get login_password_validation_error => '错误：请输入您的密码';

  @override
  String get login_stayconnected => '保持登录';

  @override
  String get login_forgot_password => '忘记密码？';

  @override
  String get login_not_member => '还不是会员？';

  @override
  String get login_signup => '注册';

  @override
  String get menu_profil_account_info => '账户信息';

  @override
  String get menu_profil_myavatar => '我的头像 / KARA';

  @override
  String get menu_profil_delete_data_texte => '请求删除您的账户和个人信息。';

  @override
  String get menu_profil_avatar_desc => '您当前的头像';

  @override
  String get menu_profil_solde_disponible => '可用余额';

  @override
  String get mips_unit => 'KARA';

  @override
  String get ariary_unit => 'Ar';

  @override
  String get logout => '退出登录';

  @override
  String get gerer => '管理';

  @override
  String get annonce => '广告';

  @override
  String get setting_langue => '语言';

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
  String get setting_font_size => '文字大小';

  @override
  String get setting_about => '关于';

  @override
  String get empty_message_list => '尚未收到消息';

  @override
  String new_version_available(String version) {
    return '新版本可用：$version';
  }

  @override
  String get announcements_of_follow_ups => '后续行动公告';

  @override
  String get description => '描述';

  @override
  String get rewards_description => '你通过这些任务获得的 KARA 将添加到你的余额中；你可以用它们来发布你的广告。';

  @override
  String get rewards_title => '观看广告，赚取 KARA';

  @override
  String get rewards_subtitle1 => '看完所有广告，即可额外赚取';

  @override
  String get rewards_subtitle2 => '50KARA';

  @override
  String get rewards_subtitle3 => '';

  @override
  String get conversion => '换算';

  @override
  String get publish_annoucement => '发布广告';

  @override
  String get please_contact_us => '请通过 contact@mips.mg 联系我们';

  @override
  String get currency => '货币';

  @override
  String get source => '来源';

  @override
  String get note => '笔记';

  @override
  String get note_exchange_description => '此信息为数据源提供的前一日收盘数据。本公司对任何错误概不负责。';

  @override
  String get calculation => '换算';

  @override
  String get exchange_rate => '汇率';

  @override
  String get follow => '跟随';

  @override
  String get followers => '订阅者';

  @override
  String get noone_follow_me_title => '您目前没有任何订阅者';

  @override
  String get noone_follow_me_description => '会员可以订阅您的个人资料，这样他们就不会错过您的任何公告。';

  @override
  String get followings => '订阅';

  @override
  String get follow_anyone_title => '您目前尚未关注任何成员';

  @override
  String get follow_anyone_description => '点击成员个人资料上的“关注”按钮，确保您不会错过他们的任何公告。';

  @override
  String get delete_account => '\'删除帐户';

  @override
  String get delete_your_account => '删除您的帐户';

  @override
  String get create_new_strong_password => '创建一个新的、更安全的密码';

  @override
  String get account => '帳戶';

  @override
  String get my_account => '我的帳戶';

  @override
  String get wallet => '錢包';

  @override
  String get my_wallet => '我的錢包';

  @override
  String get rewards => '主要的';

  @override
  String get get_mips => '取得 KARA';

  @override
  String get list_of_operations => '操作列表';

  @override
  String get earnings => '效益';

  @override
  String get all => '全部';

  @override
  String get expenses => '開支';

  @override
  String get transfers => '轉會';

  @override
  String get payer => '支付';

  @override
  String get update => '更新';

  @override
  String get empty_mes_annonces_list => '您还没有发布任何广告';

  @override
  String get empty_mes_favoris_list => '您还没有添加任何收藏';

  @override
  String get messages_screen_title => '消息';

  @override
  String get setting_about_app_title => '关于应用程序';

  @override
  String get setting_about_app_desc1 => 'MIPS 是一个直观的平台，旨在简化广告的发布和浏览。无论您是想卖东西、买东西还是探索，应用程序都提供了多种类别的选择，包括日常用品、家具、车辆等等。';

  @override
  String get setting_about_app_desc2 => '通过 MIPS，您可以使用 KARA 代币发布广告或提升广告的可见度。通过直接在应用程序中与社区互动，您可以免费获得代币，从而使体验既便捷又充满活力。';

  @override
  String get setting_about_propriete_title => '知识产权';

  @override
  String get setting_about_propriete_annonce => '广告';

  @override
  String get setting_about_propriete_annonce_text => '发布广告的用户拥有其发布内容的权利，并对所提供信息的准确性负责。任何不适当的内容都可以通过电子邮件 contact@mips.mg 向我们的团队报告。';

  @override
  String get setting_about_propriete_app => '应用程序';

  @override
  String get setting_about_propriete_app_text => 'MIPS 中使用的图标来源于 Icons8.fr 网站。';

  @override
  String get setting_about_propriete_data_title => '数据收集与隐私';

  @override
  String get setting_about_propriete_data_text => 'MIPS 致力于通过仅收集最少的个人信息来保护您的隐私，即：您的年龄、电话号码、电子邮件地址和居住省份。您可以随时通过个人资料菜单请求删除这些数据。';

  @override
  String get setting_about_propriete_contact_title => '联系方式';

  @override
  String get setting_about_propriete_contact_text => '如有任何问题、建议或需要帮助，请通过以下电子邮件地址联系我们：contact@mips.mg / +261 38 28 309 29';

  @override
  String get setting_title => '设置';

  @override
  String get forgot_password_title => '忘记密码';

  @override
  String get acheter_faka => '购买';

  @override
  String get transferer_faka => '转移';

  @override
  String get password_reset_success_toast => '您的密码已成功重置。';

  @override
  String get delete_account_dialog_confirm_title => '您真的想删除您的账户吗？';

  @override
  String get transfert_dialog_confirm_title => '您想继续转账吗？';

  @override
  String get transfert_dialog_number => '收款人号码';

  @override
  String get transfert_dialog_amount => '发送金额';

  @override
  String get maha_partenaire_title => 'Maha 合作伙伴 / 广告注册';

  @override
  String welcome_user(String pseudo) {
    return '欢迎您，$pseudo！';
  }

  @override
  String get or_text => '或';

  @override
  String get choose_img => '选择图片';

  @override
  String get browse_image => '浏览图片';

  @override
  String get conseil_tip => '< 为了保护发布消息的顾问的个人信息，我们不会披露其个人资料。 >';

  @override
  String get reserver => '预订';

  @override
  String respond_count(String count) {
    return '<累计回复人数：$count>';
  }

  @override
  String get ads_up => '顶部广告';

  @override
  String get ads_down => '底部广告';

  @override
  String get transferMessagePart1 => '您将要转账';

  @override
  String get transferMessagePart2 => 'Faka到账户';

  @override
  String get logout_done => '成功退出登录。';

  @override
  String get delete_done => '账户已删除。';

  @override
  String get register_title => '注册';

  @override
  String get register_text => '加入MIPS，创建并发布您的广告，体验更多功能！';

  @override
  String get register_pseudo_hint => '您的用户名';

  @override
  String get register_pseudo_validation => '错误：请输入您的用户名。';

  @override
  String get register_mail_hint => '您的电子邮件';

  @override
  String get register_mail_validation => '错误：请输入有效的电子邮件地址。';

  @override
  String get register_password_hint => '您的密码';

  @override
  String get register_new_password_hint => '新密码';

  @override
  String get reset_password_title => '账户恢复';

  @override
  String get change_password_title => '更改密码';

  @override
  String get old_password_hint => '旧密码';

  @override
  String get reset_password_submit_button => '发送';

  @override
  String get validation_code_prompt => '验证码';

  @override
  String get password_change_title => '更改密码';

  @override
  String get reset_password_confirm_button => '重置';

  @override
  String get reset_password_email_prompt => '输入您的电子邮件地址以重置密码';

  @override
  String validation_email_sent(String emailAddress) {
    return '已向地址 $emailAddress 发送了一封电子邮件。请输入验证代码并提供您的新密码。';
  }

  @override
  String get auth_guard_screen_title => '需要认证';

  @override
  String get auth_guard_screen_prompt => '输入您的密码以继续';

  @override
  String available_date_prompt(String date) {
    return '可用日期：$date';
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
    return '高级广告最多限制为3个，因此将在$date之后可用。';
  }

  @override
  String available_vip_date_prompt(String date) {
    return 'VIP广告最多限制为3个，因此将在$date之后可用。';
  }

  @override
  String get transfer_screen_title => 'FAKA 转账';

  @override
  String get transfer_faka_send_title => '转账已发送';

  @override
  String get transfer_available_amount => '可用余额';

  @override
  String get transfer_section_title => '向其他账户转账 FAKA';

  @override
  String get transfer_insufficient => '余额不足';

  @override
  String get transfer_id_receiver_hint => '收件人电话号码';

  @override
  String get transfer_amount_send_hint => '金额';

  @override
  String transfer_amount_send_error_validation(String solde) {
    return '错误：输入 1 到 $solde 之间的值';
  }

  @override
  String get transfer_id_receiver_error_validation => '错误：收件人电话号码';

  @override
  String get thanks_btn_text => '谢谢！';

  @override
  String get like_btn_text => '喜欢';

  @override
  String get register_password_validation => '错误：输入密码（6-8个字符）。';

  @override
  String get register_password2_hint => '确认您的密码';

  @override
  String get register_password2_validation => '错误：请再次输入您的密码。';

  @override
  String get register_genre_masculin => '男性';

  @override
  String get register_genre_feminin => '女性';

  @override
  String get register_yearofbirth_hint => '出生日期';

  @override
  String get register_yearofbirth_validation => '错误：只有13岁及以上的会员可以注册';

  @override
  String get register_tel_hint => '电话号码';

  @override
  String get register_tel_validation => '错误：输入03X XX XXX XX / 02X XX XXX XX';

  @override
  String get choose_option => '选择';

  @override
  String get register_address_hint => '省';

  @override
  String get register_address_validation => '错误：请输入有效地址';

  @override
  String get register_accept_cgu => '我接受';

  @override
  String get read_all => '全部已读 ✓';

  @override
  String get cgu => '条款和条件';

  @override
  String get btn_register => '注册';

  @override
  String get connection_error => '连接错误';

  @override
  String get try_again => '重试';

  @override
  String get item_favs_removed => '已从您的收藏夹中移除！';

  @override
  String get item_favs_added => '已添加到您的收藏夹！';

  @override
  String get confirmation => '确认';

  @override
  String get amount_deduct => '将从您的余额中扣除以发布广告。';

  @override
  String get wanna_continue => '您想继续吗？';

  @override
  String get publish => '发布';

  @override
  String get cancel => '取消';

  @override
  String get modify => '编辑';

  @override
  String get delete => '删除';

  @override
  String get add => '添加';

  @override
  String get error_upload => '上传错误';

  @override
  String get new_announce => '新广告';

  @override
  String get not_supported => '您的设备不支持此操作。';

  @override
  String get call => '拨打';

  @override
  String get comments => '评论';

  @override
  String get login_required_to_comment => '您必须登录才能发表评论。';

  @override
  String get comment_validation_error => '错误：请添加评论。';

  @override
  String get load_more_coms => '更多评论';

  @override
  String get load_more_messages => '加载更多消息';

  @override
  String get comment_hint => '写评论...';

  @override
  String announce_by(String pseudo) {
    return '由$pseudo发布';
  }

  @override
  String get become_spons_title => '成为赞助商或合作伙伴';

  @override
  String get become_spons_text => '联系我们以作为合作伙伴或赞助商在此添加您的广告。';

  @override
  String get incomplete_info => '信息不完整';

  @override
  String get incomplete_info_text => '请填写/验证所有提供的信息。';

  @override
  String get announce_favs => '收藏的广告';

  @override
  String get menu_favs => '收藏的菜单';

  @override
  String get home => '主页';

  @override
  String get empty_list_announce => '尚未发布任何广告。';

  @override
  String get empty_result => '未找到结果。';

  @override
  String get annonce_deleted_succesfully => '广告已删除。';

  @override
  String get error_loading_image => '无法加载图片。';

  @override
  String get favorite => '收藏';

  @override
  String get my_ads => '我的广告';

  @override
  String get page_not_found => '页面未找到';

  @override
  String get profil => '个人资料';

  @override
  String get view => '查看';

  @override
  String get download_dialog_title => '更新';

  @override
  String get download_dialog_desc => '正在下载...';

  @override
  String get download_dialog_error => '下载失败';

  @override
  String get text_very_small => '非常小';

  @override
  String get text_small => '小';

  @override
  String get text_medium => '正常';

  @override
  String get text_large => '大';

  @override
  String get faka_history => 'FAKA历史记录';

  @override
  String get selftransfert_error => '您不能转账给自己';

  @override
  String get text_very_large => '非常大';
}
