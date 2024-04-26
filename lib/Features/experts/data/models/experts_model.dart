class ExpertsModel {
  String? personalPhoto;
  String? moreInfo;
  String? address;
  String? birthDate;
  String? email;
  String? userName;
  String? phoneNumber;
  String? id;

  ExpertsModel({
    this.personalPhoto,
    this.moreInfo,
    this.address,
    this.birthDate,
    this.email,
    this.userName,
    this.phoneNumber,
    this.id,
  });

  ExpertsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    personalPhoto = json['personalPhoto'];
    moreInfo = json['moreInfo'];
    address = json['address'];
    birthDate = json['birthDate'];
    email = json['email'];
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
  }

  static List<ExpertsModel> expertsFromSnapShot(List expertsSnapShot) {
    return expertsSnapShot.map((data) {
      return ExpertsModel.fromJson(data);
    }).toList();
  }
}
