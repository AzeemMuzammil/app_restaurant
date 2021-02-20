// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Manager> _$managerSerializer = new _$ManagerSerializer();

class _$ManagerSerializer implements StructuredSerializer<Manager> {
  @override
  final Iterable<Type> types = const [Manager, _$Manager];
  @override
  final String wireName = 'Manager';

  @override
  Iterable<Object> serialize(Serializers serializers, Manager object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.managerId != null) {
      result
        ..add('managerId')
        ..add(serializers.serialize(object.managerId,
            specifiedType: const FullType(String)));
    }
    if (object.userId != null) {
      result
        ..add('userId')
        ..add(serializers.serialize(object.userId,
            specifiedType: const FullType(String)));
    }
    if (object.emailAddress != null) {
      result
        ..add('emailAddress')
        ..add(serializers.serialize(object.emailAddress,
            specifiedType: const FullType(String)));
    }
    if (object.firstName != null) {
      result
        ..add('firstName')
        ..add(serializers.serialize(object.firstName,
            specifiedType: const FullType(String)));
    }
    if (object.lastName != null) {
      result
        ..add('lastName')
        ..add(serializers.serialize(object.lastName,
            specifiedType: const FullType(String)));
    }
    if (object.ref != null) {
      result
        ..add('ref')
        ..add(serializers.serialize(object.ref,
            specifiedType: const FullType(DocumentReference)));
    }
    return result;
  }

  @override
  Manager deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ManagerBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'managerId':
          result.managerId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'emailAddress':
          result.emailAddress = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'firstName':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lastName':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'ref':
          result.ref = serializers.deserialize(value,
                  specifiedType: const FullType(DocumentReference))
              as DocumentReference;
          break;
      }
    }

    return result.build();
  }
}

class _$Manager extends Manager {
  @override
  final String managerId;
  @override
  final String userId;
  @override
  final String emailAddress;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final DocumentReference ref;

  factory _$Manager([void Function(ManagerBuilder) updates]) =>
      (new ManagerBuilder()..update(updates)).build();

  _$Manager._(
      {this.managerId,
      this.userId,
      this.emailAddress,
      this.firstName,
      this.lastName,
      this.ref})
      : super._();

  @override
  Manager rebuild(void Function(ManagerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ManagerBuilder toBuilder() => new ManagerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Manager &&
        managerId == other.managerId &&
        userId == other.userId &&
        emailAddress == other.emailAddress &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        ref == other.ref;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, managerId.hashCode), userId.hashCode),
                    emailAddress.hashCode),
                firstName.hashCode),
            lastName.hashCode),
        ref.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Manager')
          ..add('managerId', managerId)
          ..add('userId', userId)
          ..add('emailAddress', emailAddress)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('ref', ref))
        .toString();
  }
}

class ManagerBuilder
    implements Builder<Manager, ManagerBuilder>, AppUserBuilder {
  _$Manager _$v;

  String _managerId;
  String get managerId => _$this._managerId;
  set managerId(String managerId) => _$this._managerId = managerId;

  String _userId;
  String get userId => _$this._userId;
  set userId(String userId) => _$this._userId = userId;

  String _emailAddress;
  String get emailAddress => _$this._emailAddress;
  set emailAddress(String emailAddress) => _$this._emailAddress = emailAddress;

  String _firstName;
  String get firstName => _$this._firstName;
  set firstName(String firstName) => _$this._firstName = firstName;

  String _lastName;
  String get lastName => _$this._lastName;
  set lastName(String lastName) => _$this._lastName = lastName;

  DocumentReference _ref;
  DocumentReference get ref => _$this._ref;
  set ref(DocumentReference ref) => _$this._ref = ref;

  ManagerBuilder();

  ManagerBuilder get _$this {
    if (_$v != null) {
      _managerId = _$v.managerId;
      _userId = _$v.userId;
      _emailAddress = _$v.emailAddress;
      _firstName = _$v.firstName;
      _lastName = _$v.lastName;
      _ref = _$v.ref;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant Manager other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Manager;
  }

  @override
  void update(void Function(ManagerBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Manager build() {
    final _$result = _$v ??
        new _$Manager._(
            managerId: managerId,
            userId: userId,
            emailAddress: emailAddress,
            firstName: firstName,
            lastName: lastName,
            ref: ref);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
