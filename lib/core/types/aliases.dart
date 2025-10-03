import 'package:dartz/dartz.dart';
import 'package:stackoverflow_users_app/core/error/failures.dart';

typedef EitherFailure<T> = Either<Failure, T>;
typedef FutureEither<T> = Future<EitherFailure<T>>;
typedef StreamEither<T> = Stream<EitherFailure<T>>;
typedef VoidEither = EitherFailure<void>;
typedef NoParams = void;
