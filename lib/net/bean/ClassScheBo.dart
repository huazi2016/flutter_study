class ClassScheBo {
  int code;
  String msg;
  List<ScheBo> data;
  int count;

  ClassScheBo({this.code, this.msg, this.data, this.count});

  ClassScheBo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<ScheBo>();
      json['data'].forEach((v) {
        data.add(new ScheBo.fromJson(v));
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

class ScheBo {
  String week;
  List<Infobo> infobo;

  ScheBo({this.week, this.infobo});

  ScheBo.fromJson(Map<String, dynamic> json) {
    week = json['week'];
    if (json['infobo'] != null) {
      infobo = new List<Infobo>();
      json['infobo'].forEach((v) {
        infobo.add(new Infobo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['week'] = this.week;
    if (this.infobo != null) {
      data['infobo'] = this.infobo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Infobo {
  int id;
  String teacher;
  String course;
  String time;

  Infobo({this.id, this.teacher, this.course, this.time});

  Infobo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacher = json['teacher'];
    course = json['course'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['teacher'] = this.teacher;
    data['course'] = this.course;
    data['time'] = this.time;
    return data;
  }
}
