import 'package:bloc/bloc.dart';
import 'package:graduation_project/Features/experts/data/models/experts_model.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:meta/meta.dart';

part 'experts_state.dart';

class ExpertsCubit extends Cubit<ExpertsState> {
  ExpertsCubit() : super(ExpertsInitial());

  final List<ExpertsModel> expertsList = [
    ExpertsModel(
      age: 40,
      from: "California",
      mobile: "+12027953213",
      email: "john926@gmail.com",
      professionalInformation:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor nisl sit amet nisi fermentum, at bibendum mauris pulvinar. Quisque nec nisl a elit convallis tempus. Duis facilisis, dolor id volutpat ultrices, quam justo interdum neque, vel tempus libero ligula vel libero. In hac habitasse platea dictumst. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc vel nisi non mi tincidunt luctus nec nec ligula. Morbi ac efficitur justo, ut consectetur justo. Proin vel lacinia lacus. Sed vel justo hendrerit, aliquam justo et, facilisis lacus. Curabitur at justo vitae felis feugiat fringilla. Vivamus tempus tincidunt ex, non hendrerit lacus mattis ac. Sed euismod, eros in posuere facilisis, ex velit efficitur quam, vitae ullamcorper dolor mi in nisl. Quisque vel neque orci. Vivamus id pharetra libero, nec elementum sapien. Curabitur sed euismod ligula.",
      image: Assets.imagesD1,
      name: "John",
    ),
    ExpertsModel(
      age: 40,
      from: "California",
      mobile: "+12027953213",
      email: "john926@gmail.com",
      professionalInformation:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor nisl sit amet nisi fermentum, at bibendum mauris pulvinar. Quisque nec nisl a elit convallis tempus. Duis facilisis, dolor id volutpat ultrices, quam justo interdum neque, vel tempus libero ligula vel libero. In hac habitasse platea dictumst. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc vel nisi non mi tincidunt luctus nec nec ligula. Morbi ac efficitur justo, ut consectetur justo. Proin vel lacinia lacus. Sed vel justo hendrerit, aliquam justo et, facilisis lacus. Curabitur at justo vitae felis feugiat fringilla. Vivamus tempus tincidunt ex, non hendrerit lacus mattis ac. Sed euismod, eros in posuere facilisis, ex velit efficitur quam, vitae ullamcorper dolor mi in nisl. Quisque vel neque orci. Vivamus id pharetra libero, nec elementum sapien. Curabitur sed euismod ligula.",
      image: Assets.imagesD4,
      name: "Smith",
    ),
    ExpertsModel(
      age: 40,
      from: "California",
      mobile: "+12027953213",
      email: "john926@gmail.com",
      professionalInformation:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor nisl sit amet nisi fermentum, at bibendum mauris pulvinar. Quisque nec nisl a elit convallis tempus. Duis facilisis, dolor id volutpat ultrices, quam justo interdum neque, vel tempus libero ligula vel libero. In hac habitasse platea dictumst. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc vel nisi non mi tincidunt luctus nec nec ligula. Morbi ac efficitur justo, ut consectetur justo. Proin vel lacinia lacus. Sed vel justo hendrerit, aliquam justo et, facilisis lacus. Curabitur at justo vitae felis feugiat fringilla. Vivamus tempus tincidunt ex, non hendrerit lacus mattis ac. Sed euismod, eros in posuere facilisis, ex velit efficitur quam, vitae ullamcorper dolor mi in nisl. Quisque vel neque orci. Vivamus id pharetra libero, nec elementum sapien. Curabitur sed euismod ligula.",
      image: Assets.imagesD5,
      name: "Sam",
    ),
    ExpertsModel(
      age: 40,
      from: "California",
      mobile: "+12027953213",
      email: "john926@gmail.com",
      professionalInformation:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor nisl sit amet nisi fermentum, at bibendum mauris pulvinar. Quisque nec nisl a elit convallis tempus. Duis facilisis, dolor id volutpat ultrices, quam justo interdum neque, vel tempus libero ligula vel libero. In hac habitasse platea dictumst. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc vel nisi non mi tincidunt luctus nec nec ligula. Morbi ac efficitur justo, ut consectetur justo. Proin vel lacinia lacus. Sed vel justo hendrerit, aliquam justo et, facilisis lacus. Curabitur at justo vitae felis feugiat fringilla. Vivamus tempus tincidunt ex, non hendrerit lacus mattis ac. Sed euismod, eros in posuere facilisis, ex velit efficitur quam, vitae ullamcorper dolor mi in nisl. Quisque vel neque orci. Vivamus id pharetra libero, nec elementum sapien. Curabitur sed euismod ligula.",
      image: Assets.imagesD6,
      name: "David",
    ),
    ExpertsModel(
      age: 40,
      from: "California",
      mobile: "+12027953213",
      email: "john926@gmail.com",
      professionalInformation:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor nisl sit amet nisi fermentum, at bibendum mauris pulvinar. Quisque nec nisl a elit convallis tempus. Duis facilisis, dolor id volutpat ultrices, quam justo interdum neque, vel tempus libero ligula vel libero. In hac habitasse platea dictumst. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc vel nisi non mi tincidunt luctus nec nec ligula. Morbi ac efficitur justo, ut consectetur justo. Proin vel lacinia lacus. Sed vel justo hendrerit, aliquam justo et, facilisis lacus. Curabitur at justo vitae felis feugiat fringilla. Vivamus tempus tincidunt ex, non hendrerit lacus mattis ac. Sed euismod, eros in posuere facilisis, ex velit efficitur quam, vitae ullamcorper dolor mi in nisl. Quisque vel neque orci. Vivamus id pharetra libero, nec elementum sapien. Curabitur sed euismod ligula.",
      image: Assets.imagesD7,
      name: "John",
    ),
    ExpertsModel(
      age: 40,
      from: "California",
      mobile: "+12027953213",
      email: "john926@gmail.com",
      professionalInformation:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor nisl sit amet nisi fermentum, at bibendum mauris pulvinar. Quisque nec nisl a elit convallis tempus. Duis facilisis, dolor id volutpat ultrices, quam justo interdum neque, vel tempus libero ligula vel libero. In hac habitasse platea dictumst. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc vel nisi non mi tincidunt luctus nec nec ligula. Morbi ac efficitur justo, ut consectetur justo. Proin vel lacinia lacus. Sed vel justo hendrerit, aliquam justo et, facilisis lacus. Curabitur at justo vitae felis feugiat fringilla. Vivamus tempus tincidunt ex, non hendrerit lacus mattis ac. Sed euismod, eros in posuere facilisis, ex velit efficitur quam, vitae ullamcorper dolor mi in nisl. Quisque vel neque orci. Vivamus id pharetra libero, nec elementum sapien. Curabitur sed euismod ligula.",
      image: Assets.imagesD8,
      name: "John",
    ),
  ];
}
