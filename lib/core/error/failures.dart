import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failures {
  final DioException exception;
  ServerFailure({required this.exception});
}

class LocationFailure extends Failures {}
