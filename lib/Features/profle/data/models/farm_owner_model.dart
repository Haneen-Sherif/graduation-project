class FarmOwnerModel {
  String? farmAddress;
  String? address;
  String? id;
  // DateTime? birthDate;
  dynamic personalPhoto;
  String? email;
  String? userName;
  String? phoneNumber;
  bool? disabled;

  FarmOwnerModel({
    this.farmAddress,
    this.address,
    this.id,
    // this.birthDate,
    this.personalPhoto,
    this.email,
    this.userName,
    this.phoneNumber,
    this.disabled,
  });
  FarmOwnerModel.fromJson(Map<String, dynamic> json) {
    farmAddress = json['farmAddress'];
    address = json['address'];
    id = json['id'];
    // birthDate = json['birthDate'];
    personalPhoto = json['personalPhoto'];
    email = json['email'];
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
    disabled = json['disabled'];
  }

  static List<FarmOwnerModel> farmOwnerFromSnapShot(List farmOwnerSnapShot) {
    return farmOwnerSnapShot.map((data) {
      return FarmOwnerModel.fromJson(data);
    }).toList();
  }
}
