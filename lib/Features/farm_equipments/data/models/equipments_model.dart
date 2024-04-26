class EquipmentsModel {
  int? id;
  String? photoPath;
  String? name;
  String? description;
  int? count;
  String? ownerId;

  EquipmentsModel({
    this.id,
    this.photoPath,
    this.name,
    this.description,
    this.count,
    this.ownerId,
  });
  EquipmentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photoPath = json['photoPath'];
    name = json['name'];
    description = json['description'];
    count = json['count'];
    ownerId = json['ownerId'];
  }

  static List<EquipmentsModel> equipmentsFromSnapShot(List equipmentsSnapShot) {
    return equipmentsSnapShot.map((data) {
      return EquipmentsModel.fromJson(data);
    }).toList();
  }
}
