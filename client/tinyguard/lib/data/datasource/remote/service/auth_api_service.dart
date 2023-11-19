import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tinyguard/data/datasource/remote/api/api_client.dart';
import 'package:tinyguard/data/datasource/remote/dto/user_credentials.dart';
import 'package:tinyguard/data/datasource/remote/dto/user_register_credentials.dart';
import 'package:tinyguard/data/datasource/remote/dto/user_reset_password_credentials.dart';
import 'package:tinyguard/data/datasource/remote/entity/auth_entity.dart';
import 'package:tinyguard/data/datasource/remote/entity/reset_password_entity.dart';
import 'package:tinyguard/data/datasource/remote/entity/user_entity.dart';

enum AuthRoute {
  login('user/login'),
  resetPassword('/reset-password');

  const AuthRoute(this.path);
  final String path;
}

class AuthAPIService {
  final APIClient client;

  AuthAPIService({required this.client});

  Future<AuthEntity> login(UserCredentials credentials) async {
    String path = AuthRoute.login.path;
    debugPrint('credentials');
    debugPrint(credentials.toJson().toString());
    final response = await client.post(
        url: path,
        data: jsonEncode(credentials.toJson()),
        requestOptions: Options()
          ..headers = {"Content-Type": "application/json"});
    return AuthEntity.fromJson(response as Map<String, dynamic>);
  }

  Future<UserEntity> register(
      UserRegisterCredentials userRegisterCredentials) async {
    final response = await client.post(
      url: '',
      data: userRegisterCredentials.toJson(),
    );
    return response;
  }

  Future<UserResetPasswordEntity> resetPassword(
      UserResetPasswordCredentials credentials) async {
    String path = AuthRoute.resetPassword.path;
    final response = await client.post(
      url: path,
      data: credentials.toJson(),
    );
    return UserResetPasswordEntity.fromJson(response as Map<String, dynamic>);
  }
}
