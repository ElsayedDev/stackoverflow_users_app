import 'package:dio/dio.dart';
import 'package:stackoverflow_users_app/features/users/data/models/reputation_history_response.dart';
import 'package:stackoverflow_users_app/features/users/data/models/users_response.dart';

abstract class UsersRemoteDataSource {
  Future<UsersResponse> getUsers(int page);
  Future<ReputationHistoryResponse> getReputation(int userId, int page);
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  UsersRemoteDataSourceImpl(
    this._client, {
    this.pageSize = 20,
  });

  final Dio _client;
  final int pageSize;

  @override
  Future<UsersResponse> getUsers(int page) async {
    final response = await _client.get<Map<String, dynamic>>(
      'users',
      queryParameters: <String, dynamic>{
        'page': page,
        'pagesize': pageSize,
        'order': 'desc',
        'sort': 'reputation',
      },
    );

    final data = response.data;
    if (data == null) {
      throw const FormatException('Empty response when fetching users.');
    }

    return UsersResponse.fromJson(data);
  }

  @override
  Future<ReputationHistoryResponse> getReputation(int userId, int page) async {
    final response = await _client.get<Map<String, dynamic>>(
      'users/$userId/reputation-history',
      queryParameters: <String, dynamic>{
        'page': page,
        'pagesize': pageSize,
      },
    );

    final data = response.data;
    if (data == null) {
      throw const FormatException('Empty response when fetching reputation.');
    }

    return ReputationHistoryResponse.fromJson(data);
  }
}
