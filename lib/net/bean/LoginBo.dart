class LoginBo {
  int code;
  String msg;
  LoginInfoBo data;
  int count;

  LoginBo({this.code, this.msg, this.data, this.count});

  LoginBo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new LoginInfoBo.fromJson(json['data']) : null;
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['count'] = this.count;
    return data;
  }
}

class LoginInfoBo {
  int userId;
  String username;
  String password;
  String role;
  String avatar;
  String nickname;
  String token;
  int planId;
  String createTime;
  String updateTime;

  LoginInfoBo(
      {this.userId,
      this.username,
      this.password,
      this.role,
      this.avatar,
      this.nickname,
      this.token,
      this.planId,
      this.createTime,
      this.updateTime});

  LoginInfoBo.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    password = json['password'];
    role = json['role'];
    avatar = json['avatar'];
    nickname = json['nickname'];
    token = json['token'];
    planId = json['planId'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['password'] = this.password;
    data['role'] = this.role;
    data['avatar'] = this.avatar;
    data['nickname'] = this.nickname;
    data['token'] = this.token;
    data['planId'] = this.planId;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    return data;
  }
}
