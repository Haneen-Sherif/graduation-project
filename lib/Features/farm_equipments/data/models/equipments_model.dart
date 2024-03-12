// class EquipmentsModel {
//   final String name;
//   final String description;
//   final String image;
//   final int count;

//   const EquipmentsModel({
//     required this.name,
//     required this.description,
//     required this.image,
//     required this.count,
//   });
// }

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

  // static List<EquipmentsModel> equipmentsFromSnapShot(dynamic data) {
  //   if (data is List) {
  //     return data.map((item) => EquipmentsModel.fromJson(item)).toList();
  //   } else if (data is Map<String, dynamic>) {
  //     // If it's a single object instead of a list, convert it to a list with one item
  //     return [EquipmentsModel.fromJson(data)];
  //   } else {
  //     throw ArgumentError('Invalid data type');
  //   }
  // }

  static List<EquipmentsModel> equipmentsFromSnapShot(List equipmentsSnapShot) {
    return equipmentsSnapShot.map((data) {
      return EquipmentsModel.fromJson(data);
    }).toList();
  }
}
