// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Menu extends Menu {
  @override
  final String menuId;
  @override
  final String menuName;
  @override
  final String description;
  @override
  final double pricePerUnit;
  @override
  final String imageUrl;
  @override
  final DocumentReference ref;

  factory _$Menu([void Function(MenuBuilder) updates]) =>
      (new MenuBuilder()..update(updates)).build();

  _$Menu._(
      {this.menuId,
      this.menuName,
      this.description,
      this.pricePerUnit,
      this.imageUrl,
      this.ref})
      : super._();

  @override
  Menu rebuild(void Function(MenuBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MenuBuilder toBuilder() => new MenuBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Menu &&
        menuId == other.menuId &&
        menuName == other.menuName &&
        description == other.description &&
        pricePerUnit == other.pricePerUnit &&
        imageUrl == other.imageUrl &&
        ref == other.ref;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, menuId.hashCode), menuName.hashCode),
                    description.hashCode),
                pricePerUnit.hashCode),
            imageUrl.hashCode),
        ref.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Menu')
          ..add('menuId', menuId)
          ..add('menuName', menuName)
          ..add('description', description)
          ..add('pricePerUnit', pricePerUnit)
          ..add('imageUrl', imageUrl)
          ..add('ref', ref))
        .toString();
  }
}

class MenuBuilder implements Builder<Menu, MenuBuilder> {
  _$Menu _$v;

  String _menuId;
  String get menuId => _$this._menuId;
  set menuId(String menuId) => _$this._menuId = menuId;

  String _menuName;
  String get menuName => _$this._menuName;
  set menuName(String menuName) => _$this._menuName = menuName;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  double _pricePerUnit;
  double get pricePerUnit => _$this._pricePerUnit;
  set pricePerUnit(double pricePerUnit) => _$this._pricePerUnit = pricePerUnit;

  String _imageUrl;
  String get imageUrl => _$this._imageUrl;
  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  DocumentReference _ref;
  DocumentReference get ref => _$this._ref;
  set ref(DocumentReference ref) => _$this._ref = ref;

  MenuBuilder();

  MenuBuilder get _$this {
    if (_$v != null) {
      _menuId = _$v.menuId;
      _menuName = _$v.menuName;
      _description = _$v.description;
      _pricePerUnit = _$v.pricePerUnit;
      _imageUrl = _$v.imageUrl;
      _ref = _$v.ref;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Menu other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Menu;
  }

  @override
  void update(void Function(MenuBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Menu build() {
    final _$result = _$v ??
        new _$Menu._(
            menuId: menuId,
            menuName: menuName,
            description: description,
            pricePerUnit: pricePerUnit,
            imageUrl: imageUrl,
            ref: ref);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
