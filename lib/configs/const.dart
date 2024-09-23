import 'package:flutter/material.dart';

class TrumpCommon {
  static const String baseURL = "http://192.168.1.134:3000/";
  //static const String baseURL = "https://api0.toysns.site/";

  static String avatar =
      "https://images.unsplash.com/photo-1580128660010-fd027e1e587a";

  static TextStyle appBarTitleStyle =
      const TextStyle(color: Colors.black, fontSize: 20);
  static TextStyle greyText =
      TextStyle(color: Colors.grey.shade600, fontSize: 12);
  static double appBarTitleSpacing = 0;
}

class TrumpSize {
  static double appBarHeight = 48;
  static double leadingWidth = 36;
  static double searchAppBarHeight = 108;
}

class Constants {
  static Color backgroundColor = Colors.grey.shade200;

  static const String currencyTypeCoin = "coin"; //活跃可获得(金币/松子)
  static const String currencyTypeCash = "cash"; // 充钱可获得(现金/松果)
  static const String currencyTypeExp = "exp"; // 经验值
  // "积分"; // 升级或其他方式可获得，最难获得

  static const String postTypeActivity = "activity";
  static const String postTypeTrip = "trip";
  static const String postTypeThread = "thread";
  static const String postTypeTrends = "trends";
  static const String postTypeGoods = "goods";

  static const String postSubTypeVote = "vote";
  static const String postSubTypeTextWithImages = "text-images";
  static const String postSubTypeShortText = "short-text";
  static const String postSubTypeLongText = "long-text";
  static const String postSubTypeVoice = "voice";
  static const String postSubTypeNews = "news";
  static const String postSubTypeInterview = "interview";
  static const String postSubTypeAtlas = "atlas";
  static const String postSubTypeVideo = "video";
  static const String postSubTypeMV = "mv";

  static const String likedTypeUser = "user";
  static const String likedTypeComment = "comment";
  static const String likedTypePost = "post";
  // static const String likedTypeThread = "thread";
  // static const String likedTypeTrip = "trip"; // 行程
  // static const String likedTypeActivity = "activity"; // 活动
  // static const String likedTypeTrend = "trend"; // “官方动态”、、行程、活动、商品，都是post

  static const String searchTypeThread = "thread";
  static const String searchTypeSubject = "subject";
  static const String searchTypeUser = "user";
  static const String searchTypeGroup = "group";
  static const String searchTypeInGroup = "in-group";
  static const String searchTypeFriend = "friend";
  static const String searchTypeFans = "fans";
  static const String searchTypeFollowing = "following";

  static const TextStyle titleStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  static TextStyle secondTitleStyle =
      TextStyle(color: Colors.grey.shade700, fontSize: 14);

  // 点击发布按钮时，选择发布项
  static const String publishOptionTextAndImages = "text-images"; // 图文,没标题
  static const String publishOptionShortText = "short-text"; // 短文字，没标题
  static const String publishOptionLongText = "long-text"; // 长文字
  static const String publishOptionVoice = "voice"; // 语音
  static const String publishOptionVideo = "video"; // 视频
  static const String publishOptionDraft = "draft"; // 草稿箱
  static const String publishOptionVote = "vote"; // 投票
  static const String publishOptionSubject = "subject"; // 申请话题

  // 查询指定用户收藏的post时，type值
  static const String CollectingTypeActivity = "activity";
  static const String CollectingTypeTrends = "trends";
  static const String CollectingTypeTrip = "trip";
  static const String CollectingTypeInSubject = "in-subject";

  static const String noticeTypeLike = "like"; //点赞
  static const String noticeTypeComment = "comment"; //评论
  static const String noticeTypeAt = "at"; //@
  static const String noticeTypeOfficial = "official"; // 官方消息通知
  // static const String noticeTypeLevelUp = "level-up"; //等级提升
  // static const String noticeTypeActivity = "activity"; //活动
  // static const String noticeTypeTrip = "trip"; //行程

  // static const String messageTypeLeaveGroup = "leave-group";
  // static const String messageTypeWithdraw = "withdraw";
  static const String messageContentTypeLeaveGroup = "leave-group";
  static const String messageContentTypeWithdraw = "withdraw";
}
