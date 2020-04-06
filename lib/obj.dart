class LoginObj {
  int totalData;
  int filteredData;
  List<Data> data;

  LoginObj({this.totalData, this.filteredData, this.data});

  LoginObj.fromJson(Map<String, dynamic> json) {
    totalData = json['TotalData'];
    filteredData = json['FilteredData'];
    if (json['Data'] != null) {
      data = new List<Data>();
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalData'] = this.totalData;
    data['FilteredData'] = this.filteredData;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int iD;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String uRL;
  String username;
  String password;

  Data(
      {this.iD,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.uRL,
        this.username,
        this.password});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    uRL = json['URL'];
    username = json['Username'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CreatedAt'] = this.createdAt;
    data['UpdatedAt'] = this.updatedAt;
    data['DeletedAt'] = this.deletedAt;
    data['URL'] = this.uRL;
    data['Username'] = this.username;
    data['Password'] = this.password;
    return data;
  }
}