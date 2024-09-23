import 'package:go_router/go_router.dart';
import 'package:trump/pages/mine/export.dart';

List<GoRoute> mineRoutes = [
  GoRoute(
    name: "my_account",
    path: "my_account",
    builder: (context, state) => const MineAccountPage(),
    routes: [
      GoRoute(
          path: "charge",
          name: "charge",
          builder: (context, state) => const ChargePage()),
      GoRoute(
          path: "pay_note",
          name: "pay_note",
          builder: (context, state) => const PayNotePage()),
      GoRoute(
          path: "identity",
          name: "identity",
          builder: (context, state) => const IdentityPage()),
      GoRoute(
          path: "income",
          name: "income",
          builder: (context, state) => const IncomePage()),
    ],
  ),
  GoRoute(
    path: "fans",
    name: "fans",
    builder: (context, state) => FansPage(
        id: state.uri.queryParameters["id"] ?? "0",
        isFan: state.uri.queryParameters["is_fan"] ?? "false"),
  ),
  // "我的帐户"
  GoRoute(
      name: "my_collections",
      path: "my_collections",
      builder: (context, state) => const MineCollectionsPage()),
  // 登录
  GoRoute(
      path: "login",
      name: "login",
      builder: (context, state) => const LoginPage()),
  // 注册
  GoRoute(
      name: "register",
      path: "register",
      builder: (context, state) => const RegisterPage()),
  // "我的收藏"
  GoRoute(
      path: "invite_friends",
      name: "invite_friends",
      builder: (context, state) => const MineInviteFriendsPage()),
  // "邀请好友"
  GoRoute(
      name: "my_medals",
      path: "my_medals",
      builder: (context, state) => const MineMedalsPage()),
  // "勋章"
  GoRoute(
      name: "my_annversary_cards",
      path: "my_annversary_cards",
      builder: (context, state) => const MineAnnversaryCardsPage()),
  // "纪念卡"
  GoRoute(
      name: "light_stick",
      path: "light_stick",
      builder: (context, state) => const MineLightStickPage()),
  //"荧光棒"
  GoRoute(
      name: "my_feedback",
      path: "my_feedback",
      builder: (context, state) => const MineFeedbackPage()),
  // "意见反馈"
  GoRoute(
    name: "my_profile",
    path: "my_profile",
    builder: (context, state) => const MineProfilePage(),
    routes: [
      GoRoute(
        name: "update_name",
        path: "update_name",
        builder: (context, state) => UpdateNamePage(
          currentName: state.uri.queryParameters["current_name"] ?? "",
        ),
      ),
      GoRoute(
        name: "update_sign",
        path: "update_sign",
        builder: (context, state) => UpdateSignPage(
          sign: state.uri.queryParameters["sign"] ?? "",
        ),
      ),
    ],
  ),
  // "个人资料"
  GoRoute(
    name: "my_settings",
    path: "my_settings",
    builder: (context, state) => const MineSettingsPage(),
    routes: [
      GoRoute(
          name: "bind_phone",
          path: "bind_phone",
          builder: (context, state) => const BindPhonePage()),
      GoRoute(
          name: "bind_email",
          path: "bind_email",
          builder: (context, state) => const BindEmailPage()),
      GoRoute(
          name: "secure",
          path: "secure",
          builder: (context, state) => const SecurePage()),
      GoRoute(
          name: "preference",
          path: "preference",
          builder: (context, state) => const PreferencePage()),
      GoRoute(
          name: "blacklist",
          path: "blacklist",
          builder: (context, state) => const BlacklistPage()),
      GoRoute(
          name: "privacy",
          path: "privacy",
          builder: (context, state) => const PrivacyPage()),
      GoRoute(
          name: "about_us",
          path: "about_us",
          builder: (context, state) => const AboutUsPage()),
      GoRoute(
          name: "update_pwd",
          path: "update_pwd",
          builder: (context, state) => const UpdatePwdPage()),
    ],
  ),
  //"设置"
];
