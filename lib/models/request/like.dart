class CreateLike {
  String likedType;
  int likedId;
  CreateLike({
    required this.likedId,
    required this.likedType,
  });

  Map<String, dynamic> toJson() => {
        "liked_id": likedId,
        "liked_type": likedType,
      };
}

class DeleteLike {
  String likedType;
  int likedId;
  DeleteLike({
    required this.likedId,
    required this.likedType,
  });
  Map<String, dynamic> toJson() => {
        "liked_id": likedId,
        "liked_type": likedType,
      };
}

// 如果likedType是用户，则若likedId>0,查询哪些人点赞了likedId的主页，若userId>0,则查询userId点赞了哪些人
// 若likedType不是用户，则若authorid>0,查询authorid发布内容被人点赞的记录，若userId>0,查询userId点赞了别人内容的记录。
// 在查询的时候，likedType目前中分是与不是用户，其他类型不作区分。
class QueryLikeList {
  int userId;
  int likedId;
  String likedType;
  int authorId;
  QueryLikeList({
    this.userId = 0,
    this.likedId = 0,
    this.likedType = '',
    this.authorId = 0,
  });
  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "liked_id": likedId,
        "liked_type": likedType,
        "author_id": authorId,
      };
}
