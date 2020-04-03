abstract class BlocEvent {}

class BlocLoading extends BlocEvent {}

class BlocLoaded extends BlocEvent {
  dynamic value;

  BlocLoaded(this.value);
}

class BlocFailed extends BlocEvent {
  String mess;

  BlocFailed(this.mess);
}
