// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'addresses_bloc.dart';

sealed class AddressesState extends Equatable {
  const AddressesState();

  @override
  List<Object?> get props => [];
}

final class AddressesInitial extends AddressesState {}

class AddressesLoaded extends AddressesState {
  final List<ShippingAddress> addresses;
  final DateTime? lastTimeChanged;

  const AddressesLoaded(
      {required this.addresses, required this.lastTimeChanged});

  @override
  List<Object?> get props => [addresses, lastTimeChanged];

  AddressesLoaded copyWith({
    List<ShippingAddress>? addresses,
  }) {
    return AddressesLoaded(
      addresses: addresses ?? this.addresses,
      lastTimeChanged: DateTime.now(),
    );
  }
}

class AddressesLoading extends AddressesState {}

class AddressesError extends AddressesState {
  final String message;

  const AddressesError(this.message);

  @override
  List<Object> get props => [message];
}
