class NewsBo {
  int code;
  String msg;
  List<NewsInfoBo> data;
  int count;

  NewsBo({this.code, this.msg, this.data, this.count});

  NewsBo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<NewsInfoBo>();
      json['data'].forEach((v) {
        data.add(new NewsInfoBo.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class NewsInfoBo {
  int messageId;
  String type;
  String title;
  String content;
  String teacher;
  String student;
  String createTime;
  String talkId;
  String updateTime;

  NewsInfoBo(
      {this.messageId,
      this.type,
      this.title,
      this.content,
      this.teacher,
      this.student,
      this.createTime,
      this.talkId,
      this.updateTime});

  NewsInfoBo.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    type = json['type'];
    title = json['title'];
    content = json['content'];
    teacher = json['teacher'];
    student = json['student'];
    createTime = json['createTime'];
    talkId = json['talkId'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageId'] = this.messageId;
    data['type'] = this.type;
    data['title'] = this.title;
    data['content'] = this.content;
    data['teacher'] = this.teacher;
    data['student'] = this.student;
    data['createTime'] = this.createTime;
    data['talkId'] = this.talkId;
    data['updateTime'] = this.updateTime;
    return data;
  }
}
