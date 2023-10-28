import 'package:tinyguard/data/datasource/remote/entity/base_response_entity.dart';
import 'package:tinyguard/data/datasource/remote/entity/device_entity.dart';

class UserEntity extends BaseResponseApiEntity {
  late int id;
  late String username;
  late int age;
  late String phone_number;
  late String email;
  late List<DeviceEntity> devices;

  UserEntity(super.body);

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(json);
  }

  @override
  void initialValue() {
    this.devices = [];
    this.id = body['id'];
    this.username = body['username'];
    this.age = body['age'];
    this.phone_number = body['phone_number'];
    this.email = body['email'];
    for (var element in body['devices']) {
      this.devices.add(DeviceEntity(element)..user = this);
    }
  }
}