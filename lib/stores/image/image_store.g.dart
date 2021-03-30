// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ImageStore on _ImageStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_ImageStore.loading'))
      .value;
  Computed<bool> _$hasResultsComputed;

  @override
  bool get hasResults =>
      (_$hasResultsComputed ??= Computed<bool>(() => super.hasResults,
              name: '_ImageStore.hasResults'))
          .value;

  final _$widthAtom = Atom(name: '_ImageStore.width');

  @override
  double get width {
    _$widthAtom.reportRead();
    return super.width;
  }

  @override
  set width(double value) {
    _$widthAtom.reportWrite(value, super.width, () {
      super.width = value;
    });
  }

  final _$heightAtom = Atom(name: '_ImageStore.height');

  @override
  double get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(double value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  final _$fetchImageFutureAtom = Atom(name: '_ImageStore.fetchImageFuture');

  @override
  ObservableFuture<PickedFile> get fetchImageFuture {
    _$fetchImageFutureAtom.reportRead();
    return super.fetchImageFuture;
  }

  @override
  set fetchImageFuture(ObservableFuture<PickedFile> value) {
    _$fetchImageFutureAtom.reportWrite(value, super.fetchImageFuture, () {
      super.fetchImageFuture = value;
    });
  }

  final _$uploadImageAsyncAction = AsyncAction('_ImageStore.uploadImage');

  @override
  Future<dynamic> uploadImage() {
    return _$uploadImageAsyncAction.run(() => super.uploadImage());
  }

  final _$decodeImageAsyncAction = AsyncAction('_ImageStore.decodeImage');

  @override
  Future decodeImage() {
    return _$decodeImageAsyncAction.run(() => super.decodeImage());
  }

  final _$saveImageAsyncAction = AsyncAction('_ImageStore.saveImage');

  @override
  Future saveImage(GlobalKey<State<StatefulWidget>> globalKey) {
    return _$saveImageAsyncAction.run(() => super.saveImage(globalKey));
  }

  final _$_ImageStoreActionController = ActionController(name: '_ImageStore');

  @override
  dynamic setImage() {
    final _$actionInfo =
        _$_ImageStoreActionController.startAction(name: '_ImageStore.setImage');
    try {
      return super.setImage();
    } finally {
      _$_ImageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
width: ${width},
height: ${height},
fetchImageFuture: ${fetchImageFuture},
loading: ${loading},
hasResults: ${hasResults}
    ''';
  }
}
