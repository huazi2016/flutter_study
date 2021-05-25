class RoomBo {
  int code;
  String msg;
  List<RoomDetailBo> data;
  int count;

  RoomBo({this.code, this.msg, this.data, this.count});

  RoomBo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<RoomDetailBo>();
      json['data'].forEach((v) {
        data.add(new RoomDetailBo.fromJson(v));
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

class RoomDetailBo {
  int questionId;
  String course;
  bool isPaper;
  String title;
  String type;
  String content;
  String anwser;
  String teacher;
  String createTime;
  String updateTime;
  int score;

  RoomDetailBo(
      {this.questionId,
      this.course,
      this.isPaper,
      this.title,
      this.type,
      this.content,
      this.anwser,
      this.teacher,
      this.createTime,
      this.updateTime,
      this.score});

  RoomDetailBo.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    course = json['course'];
    isPaper = json['isPaper'];
    title = json['title'];
    type = json['type'];
    content = json['content'];
    anwser = json['anwser'];
    teacher = json['teacher'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['course'] = this.course;
    data['isPaper'] = this.isPaper;
    data['title'] = this.title;
    data['type'] = this.type;
    data['content'] = this.content;
    data['anwser'] = this.anwser;
    data['teacher'] = this.teacher;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['score'] = this.score;
    return data;
  }
}
