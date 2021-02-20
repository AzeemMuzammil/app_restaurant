// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Order extends Order {
  @override
  final String orderID;
  @override
  final DocumentReference orderedUserRef;
  @override
  final String orderedUserName;
  @override
  final Timestamp orderPlacedTime;
  @override
  final FieldValue orderPlacedTimeServerTS;
  @override
  final String orderCurrentStatus;
  @override
  final List<String> orderedProducts;
  @override
  final double orderSubTotal;
  @override
  final DocumentReference ref;

  factory _$Order([void Function(OrderBuilder) updates]) =>
      (new OrderBuilder()..update(updates)).build();

  _$Order._(
      {this.orderID,
      this.orderedUserRef,
      this.orderedUserName,
      this.orderPlacedTime,
      this.orderPlacedTimeServerTS,
      this.orderCurrentStatus,
      this.orderedProducts,
      this.orderSubTotal,
      this.ref})
      : super._();

  @override
  Order rebuild(void Function(OrderBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderBuilder toBuilder() => new OrderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Order &&
        orderID == other.orderID &&
        orderedUserRef == other.orderedUserRef &&
        orderedUserName == other.orderedUserName &&
        orderPlacedTime == other.orderPlacedTime &&
        orderPlacedTimeServerTS == other.orderPlacedTimeServerTS &&
        orderCurrentStatus == other.orderCurrentStatus &&
        orderedProducts == other.orderedProducts &&
        orderSubTotal == other.orderSubTotal &&
        ref == other.ref;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc(0, orderID.hashCode),
                                    orderedUserRef.hashCode),
                                orderedUserName.hashCode),
                            orderPlacedTime.hashCode),
                        orderPlacedTimeServerTS.hashCode),
                    orderCurrentStatus.hashCode),
                orderedProducts.hashCode),
            orderSubTotal.hashCode),
        ref.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Order')
          ..add('orderID', orderID)
          ..add('orderedUserRef', orderedUserRef)
          ..add('orderedUserName', orderedUserName)
          ..add('orderPlacedTime', orderPlacedTime)
          ..add('orderPlacedTimeServerTS', orderPlacedTimeServerTS)
          ..add('orderCurrentStatus', orderCurrentStatus)
          ..add('orderedProducts', orderedProducts)
          ..add('orderSubTotal', orderSubTotal)
          ..add('ref', ref))
        .toString();
  }
}

class OrderBuilder implements Builder<Order, OrderBuilder> {
  _$Order _$v;

  String _orderID;
  String get orderID => _$this._orderID;
  set orderID(String orderID) => _$this._orderID = orderID;

  DocumentReference _orderedUserRef;
  DocumentReference get orderedUserRef => _$this._orderedUserRef;
  set orderedUserRef(DocumentReference orderedUserRef) =>
      _$this._orderedUserRef = orderedUserRef;

  String _orderedUserName;
  String get orderedUserName => _$this._orderedUserName;
  set orderedUserName(String orderedUserName) =>
      _$this._orderedUserName = orderedUserName;

  Timestamp _orderPlacedTime;
  Timestamp get orderPlacedTime => _$this._orderPlacedTime;
  set orderPlacedTime(Timestamp orderPlacedTime) =>
      _$this._orderPlacedTime = orderPlacedTime;

  FieldValue _orderPlacedTimeServerTS;
  FieldValue get orderPlacedTimeServerTS => _$this._orderPlacedTimeServerTS;
  set orderPlacedTimeServerTS(FieldValue orderPlacedTimeServerTS) =>
      _$this._orderPlacedTimeServerTS = orderPlacedTimeServerTS;

  String _orderCurrentStatus;
  String get orderCurrentStatus => _$this._orderCurrentStatus;
  set orderCurrentStatus(String orderCurrentStatus) =>
      _$this._orderCurrentStatus = orderCurrentStatus;

  List<String> _orderedProducts;
  List<String> get orderedProducts => _$this._orderedProducts;
  set orderedProducts(List<String> orderedProducts) =>
      _$this._orderedProducts = orderedProducts;

  double _orderSubTotal;
  double get orderSubTotal => _$this._orderSubTotal;
  set orderSubTotal(double orderSubTotal) =>
      _$this._orderSubTotal = orderSubTotal;

  DocumentReference _ref;
  DocumentReference get ref => _$this._ref;
  set ref(DocumentReference ref) => _$this._ref = ref;

  OrderBuilder();

  OrderBuilder get _$this {
    if (_$v != null) {
      _orderID = _$v.orderID;
      _orderedUserRef = _$v.orderedUserRef;
      _orderedUserName = _$v.orderedUserName;
      _orderPlacedTime = _$v.orderPlacedTime;
      _orderPlacedTimeServerTS = _$v.orderPlacedTimeServerTS;
      _orderCurrentStatus = _$v.orderCurrentStatus;
      _orderedProducts = _$v.orderedProducts;
      _orderSubTotal = _$v.orderSubTotal;
      _ref = _$v.ref;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Order other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Order;
  }

  @override
  void update(void Function(OrderBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Order build() {
    final _$result = _$v ??
        new _$Order._(
            orderID: orderID,
            orderedUserRef: orderedUserRef,
            orderedUserName: orderedUserName,
            orderPlacedTime: orderPlacedTime,
            orderPlacedTimeServerTS: orderPlacedTimeServerTS,
            orderCurrentStatus: orderCurrentStatus,
            orderedProducts: orderedProducts,
            orderSubTotal: orderSubTotal,
            ref: ref);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
