import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/request/like.dart';
import 'package:trump/models/request/new_comment.dart';
import 'package:trump/models/request/new_post.dart';
import 'package:trump/models/request/subject.dart';
import 'package:trump/models/request/user.dart';
import 'package:trump/models/resp/models/checkin.dart';
import 'package:trump/models/resp/models/content.dart';
import 'package:trump/models/resp/models/group.dart';
import 'package:trump/models/resp/models/subject.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/models/resp/models/user_preference.dart';
import 'package:trump/models/resp/models/user_privacy.dart';
import 'package:trump/service/dio_instance.dart';
import 'package:trump/service/save.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../models/resp/index.dart';

//note: res.data是Resp结构实例
class Api {
  static Api instance = Api._();

  Api._();

  // 创建post
  Future<Post> createPost(NewPost np) async {
    Response resp =
        await DioInstance.instance().post(path: "post", data: np.toJson());
    return Post.fromJson(resp.data.data);
  }

  // 查询post详情
  Future<Post> getPostByID({required String id}) async {
    var res = await DioInstance.instance().get(
      path: "post",
      params: {"id": id},
    );
    return Post.fromJson(res.data.data);
  }

  // 删除post
  Future<bool> deletePost(int pid) async {
    Response resp =
        await DioInstance.instance().delete(path: "post", params: {"id": pid});
    return resp.data.code == 0;
  }
  // 修改post,可更新ishot属性

  // 给自己的帖子“加热”
  Future<bool> toHotPost(int id) async {
    var res = await DioInstance.instance()
        .post(path: "hot-post", params: {"post_id": id});
    return res.data.code == 0;
  }

  // 查询全部hot的帖子(作者自己加热的帖子，不是按热度排行的。)
  Future<ListResp> getHotPostList() async {
    var res = await DioInstance.instance().get(path: "hot-post-list");
    return ListResp.toListResp(res.data);
  }

  // 查询指定用户创建的post列表，需要：UserID>0,但IsFollowing为false,
  // 查询指定用户关注的话题下post列表，必要参数：IsFollowing为true,UserID
  // 查询指定话题下post列表，必要参数：SubjectID>0
  // 以上都略过，若PostType为空，则查询全部post列表，
  // 若PostType不为空，则根据类型返回post列表
  // 注意：PostSubType必须为""或是合法类型值
  Future<ListResp> getPostList({
    int uid = 0,
    String postType = "",
    String postSubType = "",
    int subjectID = 0,
    bool isFollowing = false,
    int pageIndex = 0,
    int pageSize = 0,
  }) async {
    var res = await DioInstance.instance().get(path: "post-list", params: {
      "page_index": pageIndex,
      "page_size": pageSize,
      "user_id": uid,
      "post_type": postType,
      "post_sub_type": postSubType,
      "subject_id": subjectID,
      "is_following": isFollowing,
    });
    return ListResp.toListResp(res.data);
  }

  // 注册
  Future<Resp> register(Register reg) async {
    Response resp =
        await DioInstance.instance().post(path: "register", data: reg);
    return resp.data;
  }

  // 登录
  Future<String> login(
      {required String email, required String password}) async {
    Response res = await DioInstance.instance().post(path: "login", data: {
      "email": email,
      "password": password,
    });
    return res.data.data;
  }

  // 更新自己的信息
  Future<String> updateUserInfo(User user) async {
    var res =
        await DioInstance.instance().put(path: "user", data: user.toJson());
    return res.data.data as String;
  }

  // 查询指定用户信息
  Future<User?> getUserInfo(String id) async {
    Response resp =
        await DioInstance.instance().get(path: "user", params: {"user_id": id});
    return User.fromJson(resp.data.data);
  }

  // 查询自己的信息
  Future<User?> getProfile() async {
    Response resp = await DioInstance.instance().get(path: "profile");
    if (resp.data.code != 0) {
      return null;
    } else {
      return User.fromJson(resp.data.data);
    }
  }

  // 退出登录
  Future<bool> logout() async {
    Response resp = await DioInstance.instance().delete(path: "logout");
    return resp.data.code == 0;
  }

  // 搜索
  // 根据关键字和类型查询
  Future<ListResp> searchWithKeyword(String keyword, String searchType) async {
    Response resp = await DioInstance.instance().get(path: "search", params: {
      "keyword": keyword,
      "type": searchType,
    });
    return ListResp.toListResp(resp.data);
  }

  // 创建话题
  Future<Subject?> createSubject(NewSubject ns) async {
    var res = await DioInstance.instance().post(path: "subject", data: ns);
    return Subject.fromJson(res.data.data);
  }

  // 查询话题详情
  Future<Resp> getSubjectDetail({required String id}) async {
    Response resp =
        await DioInstance.instance().get(path: "subject", params: {"id": id});
    return resp.data;
  }
  // 删除话题，删除之后，相关post如何？
  // 修改话题信息

  // 查询话题列表
  Future<ListResp> getSubjectList(
      {int limit = 100,
      String orderBy = '',
      bool isRecommended = false}) async {
    Response resp =
        await DioInstance.instance().get(path: "subject-list", params: {
      "limit": limit,
      "order_by": orderBy,
      "is_recommended": isRecommended,
    });
    return ListResp.toListResp(resp.data);
  }

  // 发表评论
  Future<bool> createComment(NewComment nc) async {
    Response resp =
        await DioInstance.instance().post(path: "comment", data: nc.toJson());
    return resp.data.code == 0;
  }

  // 删除评论
  Future<bool> deleteComment(int cid) async {
    Response resp = await DioInstance.instance()
        .delete(path: "comment", params: {"id": cid});
    return resp.data.code == 0;
  }

  // 查询评论详情
  Future<Resp> getCommentDetail(String id) async {
    Response resp =
        await DioInstance.instance().get(path: "comment", params: {"id": id});
    return resp.data;
  }

  // 根据post查询评论列表
  Future<ListResp> getCommentListByPostID(String id) async {
    Response res = await DioInstance.instance()
        .get(path: "comment-list", params: {"post_id": id});
    return ListResp.toListResp(res.data);
  }

  // 根据parent_id查询评论的回复列表
  Future<ListResp> getCommentListByParentID(String id) async {
    Response res = await DioInstance.instance()
        .get(path: "comment-list", params: {"parent_id": id});
    return ListResp.toListResp(res.data);
  }

  // 点赞
  Future<bool> createLike(CreateLike data) async {
    var res = await DioInstance.instance().post(
      path: "like",
      data: data.toJson(),
    );
    return (res.data.code == 0);
  }

  // 取消点赞
  Future<bool> deleteLike(DeleteLike params) async {
    var res = await DioInstance.instance()
        .delete(path: "like", data: params.toJson());
    return res.data.code == 0;
  }

  //

  // 查询点赞记录列表
  Future<ListResp> getLikeList(QueryLikeList params) async {
    var res = await DioInstance.instance()
        .get(path: "like-list", params: params.toJson());
    return ListResp.toListResp(res.data);
  }

  // 签到
  //获取今天签到的用户列表
  //获取某用户的全部签到记录

  // 收藏只能收藏post
  Future<bool> collectPost(int postId) async {
    var res = await DioInstance.instance()
        .post(path: "collection", data: {"post_id": postId});
    return res.data.code == 0;
  }

  // 取消收藏post
  Future<bool> cancelCollectPost(int postId, {bool removeAll = false}) async {
    var res = await DioInstance.instance().delete(path: "collection", params: {
      "post_id": postId,
      "remove_all": removeAll,
    });
    return res.data.code == 0;
  }

  // 查询收藏的post(trends, activity,trip, in-subject)
  Future<ListResp> getCollectingPostList(
      {int uid = 0, String type = ""}) async {
    var res = await DioInstance.instance().get(
        path: "collecting-post-list", params: {"type": type, "user_id": uid});
    return ListResp.toListResp(res.data);
  }

  // 关注用户或话题
  // 关注
  Future<bool> createFollow(String followedType, int followedId) async {
    var res = await DioInstance.instance().post(
        path: "follow",
        data: {"followed_type": followedType, "followed_id": followedId});
    return res.data.code == 0;
  }

  // 取消关注
  Future<bool> deleteFollow(String followedType, int followedId) async {
    var res = await DioInstance.instance().delete(
        path: "follow",
        data: {"followed_type": followedType, "followed_id": followedId});
    return res.data.code == 0;
  }

  // 查询指定用户关注的话题列表/用户列表
  Future<ListResp> getFollowingList(String followedType, [int uid = 0]) async {
    var res = await DioInstance.instance().get(path: "following-list", params: {
      "followed_type": followedType,
      "user_id": uid.toString(),
    });
    return ListResp.toListResp(res.data);
  }

  // 查询某话题或用户的粉丝（关注者）
  Future<ListResp> getFans(String followedType, [int uid = 0]) async {
    var res = await DioInstance.instance().get(path: "fans", params: {
      "followed_type": followedType,
      "followed_id": uid.toString(),
    });
    return ListResp.toListResp(res.data);
  }

  // 获取指定角色创建的最新内容（帖子和评论）
  //todo: 如果一篇内容也没有会怎么样？
  Future<Content> getLatestContent(String roleName) async {
    var res = await DioInstance.instance()
        .get(path: "latest-content-by-role", params: {"role_name": roleName});
    return Content.fromJson(res.data.data);
  }

  // 获取指定角色创建的全部内容
  Future<ListResp> getContentList(int roleId) async {
    var res = await DioInstance.instance()
        .get(path: "list-by-role", params: {"role_id": roleId.toString()});
    return ListResp.toListResp(res.data);
  }

  // 黑名单 // 查询某用户被哪些人拉黑了
  Future<ListResp> getBlacklist(int uid, {bool inBlacklist = false}) async {
    var res = await DioInstance.instance().get(
      path: "blacklist",
      params: {"user_id": uid, "in_blacklist": inBlacklist},
    );
    return ListResp.toListResp(res.data);
  }

  // 拉黑
  Future<bool> block(int uid) async {
    var res = await DioInstance.instance()
        .post(path: "block", data: {"blocked_user_id": uid});
    return res.data.code == 0;
  }

  // 取消拉黑
  Future<bool> cancelBlock(int uid) async {
    var res = await DioInstance.instance()
        .delete(path: "block", params: {"blocked_user_id": uid});
    return res.data.code == 0;
  }

  // 举报

  // 单文件上传
  Future<Resp> uploadSingleFile(FormData fd) async {
    var res = await DioInstance.instance().post(path: "file", data: fd);
    return res.data;
  }
  // 多文件上传
  // 根据文件名查询文件记录

  // 查询option值
  Future<String> getOptionValue(String key) async {
    var res =
        await DioInstance.instance().get(path: "option", params: {"key": key});
    return res.data.data;
  }

  // 投票
  Future<bool> vote(int postId, int voteOptionId) async {
    var resp = await DioInstance.instance().post(
        path: "vote",
        data: {"post_id": postId, "vote_option_id": voteOptionId});
    return resp.data.code == 0;
  }

  // 获取自己的消息通知列表
  Future<ListResp> getMyNoticeList(List<String> types) async {
    var res = await DioInstance.instance()
        .get(path: "notice-list", params: {"types": types});
    return ListResp.toListResp(res.data);
  }

  // 提出建议与反馈advice
  Future<bool> createAdvice(String content, String adviceType) async {
    var res = await DioInstance.instance()
        .post(path: "advice", data: {"content": content, "type": adviceType});
    return res.data.code == 0;
  }

  // 查询所有advice,如果传入uid,则查询指定用户创建的
  Future<ListResp> getAdviceList({int uid = 0}) async {
    var res = await DioInstance.instance()
        .get(path: "advice-list", params: {"user_id": uid});
    return ListResp.toListResp(res.data);
  }

  // 更新advice的状态
  Future<bool> getAdviceListByUser(int id, String status) async {
    var res = await DioInstance.instance()
        .put(path: "advice", data: {"id": id, "status": status});
    return res.data.code == 0;
  }

  // 查询用户偏好设置
  Future<UserPreference> getUserPreference() async {
    var res = await DioInstance.instance().get(path: "user-preference");
    return UserPreference.fromJson(res.data.data);
  }

  // 更新用户偏好设置
  Future<bool> updateUserPreference(UserPreference data) async {
    var res = await DioInstance.instance()
        .put(path: "user-preference", data: data.toJson());
    return res.data.code == 0;
  }

  // 查询用户隐私设置
  Future<UserPrivacy> getUserPrivacy() async {
    var res = await DioInstance.instance().get(path: "user-privacy");
    return UserPrivacy.fromJson(res.data.data);
  }

  // 更新用户隐私设置
  Future<bool> updateUserPrivacy(UserPrivacy data) async {
    var res = await DioInstance.instance()
        .put(path: "user-privacy", data: data.toJson());
    return res.data.code == 0;
  }

  // 输入邀请码，被邀请
  Future<bool> beInvited(String code) async {
    var res = await DioInstance.instance()
        .post(path: "be-invite", data: {"code": int.parse(code)});
    return res.data.code == 0;
  }

  // 查询(邀请者)--> 自己写了谁的邀请码
  Future<User?> getInviter() async {
    var res = await DioInstance.instance().get(path: "inviter");
    if (res.data.data != null) {
      return User.fromJson(res.data.data);
    } else {
      return null;
    }
  }

  // 查询自己邀请了哪些人
  Future<ListResp> getBeInvitedUserList() async {
    var res = await DioInstance.instance().get(path: "invited-user-list");
    return ListResp.toListResp(res.data);
  }

  // 查询并返回所有群
  Future<ListResp> getGroupList({bool isEntered = false}) async {
    var res = await DioInstance.instance()
        .get(path: "group-list", params: {"is_entered": isEntered});
    return ListResp.toListResp(res.data);
  }

  // 查询群详情
  Future<Group?> getGroupDetail(String id) async {
    var res = await DioInstance.instance()
        .get(path: "group", params: {"group_id": id});
    print("返回群xfsj：${res.data.code}--${res.data.data.toString()}");
    if (res.data.data != null) {
      return Group.fromJson(res.data.data);
    } else {
      return null;
    }
  }

  // 加群
  Future<bool> enterGroup(int gid) async {
    var res = await DioInstance.instance()
        .post(path: "in-group", data: {"group_id": gid});
    return res.data.code == 0;
  }

  // 退群
  Future<bool> leaveGroup(int gid) async {
    var res = await DioInstance.instance()
        .delete(path: "in-group", data: {"group_id": gid});
    return res.data.code == 0;
  }

  // 创建群
  // 销毁群并清空群成员,todo:清空群消息

  // 建立与服务端的ws连接
  Future<WebSocketChannel> connect() async {
    String token = await SaveService.readString();
    final channel = WebSocketChannel.connect(Uri.parse(
        "${TrumpCommon.baseURL.replaceFirst("http", "ws")}chat?token=$token"));
    return channel;
  }

  // 查询聊天记录列表
  Future<ListResp> getMsgList({int groupId = 0, int toUserId = 0}) async {
    var res = await DioInstance.instance().get(
        path: "msg-list",
        params: {"group_id": groupId, "to_user_id": toUserId});
    return ListResp.toListResp(res.data);
  }

  // 创建task
  // 修改task设置信息

  // 查询全部task
  Future<ListResp> getAllTask() async {
    var res = await DioInstance.instance().get(path: "task-list");
    return ListResp.toListResp(res.data);
  }

  // 查询今天的task-note记录列表
  Future<ListResp> getTodayTaskNoteList() async {
    var res = await DioInstance.instance().get(path: "task-note-list");
    return ListResp.toListResp(res.data);
  }

  // 查询今日任务进度
  Future<int> getTaskProgress() async {
    var res = await DioInstance.instance().get(path: "task-progress");
    return res.data.data;
  }

  // 每日登录(task)
  Future<bool> dailyLogin() async {
    var res = await DioInstance.instance().get(path: "login");
    return res.data.code == 0;
  }

  // 在线时长加一分钟
  Future<bool> addOnlineMinutes() async {
    var res = await DioInstance.instance().put(path: "online-minutes");
    return res.data.code == 0;
  }

  // 领取任务奖励
  Future<bool> getTaskReward(int taskId) async {
    var res = await DioInstance.instance()
        .get(path: "task-reward", params: {"task_id": taskId});
    return res.data.code == 0;
  }

  // 排行榜
  // Rate       string `json:"rate" form:"rate"`               // day,weekday
  // Type       string `form:"type" json:"type"`               // 'hot'|'checkin'|level|coin
  // EntityType string `json:"entity_type" form:"entity_type"` // 资源实体类型：user/post(thread)
  Future<ListResp> getRankList(
      {String rate = "day",
      String type = "hot",
      String entityType = "post"}) async {
    var res = await DioInstance.instance().get(
        path: "rank-list",
        params: {"rate": rate, "type": type, "entity_type": entityType});
    return ListResp.toListResp(res.data);
  }

  // 签到
  Future<bool> checkin() async {
    var res = await DioInstance.instance().post(path: "checkin");
    return res.data.code == 0;
  }

  // 补签
  Future<bool> reCheckin(
      {required int year, required int month, required int day}) async {
    var res = await DioInstance.instance().post(path: "re-checkin", data: {
      "year": year,
      "month": month,
      "day": day,
    });
    return res.data.code == 0;
  }

  // 今天是否签到
  Future<bool> todayIsCheckedIn() async {
    var res = await DioInstance.instance().get(path: "is-checked-in");
    if (res.data.code == 0) {
      return (res.data.data);
    } else {
      return false;
    }
  }

  // 查询指定用户全部签到记录，如果不传userid,就默认查询当前用户的，若当前用户未登录，也没传userid,则返回空数据
  Future<Checkin?> getCheckinList({int uid = 0, int? year, int? month}) async {
    year ??= DateTime.now().year;
    month ??= DateTime.now().month;
    var res = await DioInstance.instance().get(
        path: "checkin-list",
        params: {"user_id": uid, "year": year, "month": month});
    if (res.data.data != null && res.data.code == 0) {
      return Checkin.fromJson(res.data.data);
    } else {
      return null;
    }
  }

  // 支付
  Future<String> pay(Map<String, int> goodsList) async {
    var res = await DioInstance.instance()
        .post(path: "pay", data: {"goods_list": goodsList});
    return res.data.msg;
  }

  // 查询全部支付记录
  Future<ListResp> getPayNoteList() async {
    var res = await DioInstance.instance().get(path: "pay-note-list");
    return ListResp.toListResp(res.data);
  }

  // 查询全部支付过的商品
  Future<ListResp> getPaiedGoodsList() async {
    var res = await DioInstance.instance().get(path: "paied-goods-list");
    return ListResp.toListResp(res.data);
  }

  // 根据商品名称查询支付过的某商品的数量
  Future<dynamic> getGoodsCount(String title) async {
    var res = await DioInstance.instance()
        .get(path: "goods-count", params: {"title": title});
    if (res.data.code == 0) {
      return (res.data.data);
    }

    return "0";
  }

  // 获取验证码
  // accountStr是手机号或邮箱号，type值是email|phone
  Future<bool> getVeriCode(
      {required String accountStr, required String type}) async {
    var res = await DioInstance.instance().get(path: "veri-code", params: {
      "account_str": accountStr,
      "type": type,
    });
    return res.data.code == 0;
  }

  Future<bool> validateVeriCode({
    required String accountStr,
    required String type,
    required String code,
  }) async {
    var res = await DioInstance.instance().post(path: "veri-code", data: {
      "account_str": accountStr,
      "type": type,
      "code": code,
    });
    return res.data.code == 0;
  }
}
