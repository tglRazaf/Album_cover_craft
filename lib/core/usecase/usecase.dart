import 'package:equatable/equatable.dart';

abstract class Usecase<Type, Param> {
  Type call(Param param);
}

class NoParam extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  
}