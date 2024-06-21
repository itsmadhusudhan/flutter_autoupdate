import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_autoupdate/flutter_autoupdate.dart';
import 'package:flutter_autoupdate/src/providers/provider.dart';

class Url extends Provider {
  Url(this.versionUrl);

  final String versionUrl;

  @override
  Future<UpdateResult?> fetchUpdate() async {
    var res = await Dio().get(versionUrl);
    final data = res.data is String ? jsonDecode(res.data) : res.data;
    if (data is List) {
      final list = data.map((item) => UpdateResult.fromJson(item)).toList();
      return UpdateResult(
          latestVersion: list[0].latestVersion,
          downloadUrl: list[0].downloadUrl,
          releaseNotes: list[0].releaseNotes,
          releaseDate: list[0].releaseDate,
          sha512: list[0].sha512);
    } else {
      final result = UpdateResult.fromJson(data);
      return UpdateResult(
          latestVersion: result.latestVersion,
          downloadUrl: result.downloadUrl,
          releaseNotes: result.releaseNotes,
          releaseDate: result.releaseDate,
          sha512: result.sha512);
    }
  }

  @override
  String buildUpdateUrl() {
    throw UnimplementedError();
  }
}
