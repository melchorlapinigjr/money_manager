import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:money_manager/model/resource_definition.dart';
import 'package:money_manager/model/resources/base_resource.dart';
import 'package:money_manager/utils/resource_helper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DBRepository {
  DBRepository._();

  static DBRepository _instance;

  Database db;
  StoreRef<String, Map<String, dynamic>> _mainStore;

  /// Get singleton instance.
  ///
  ///
  static DBRepository get instance =>
      _instance ?? (_instance = DBRepository._());

  /// Convert data items to a different [T].
  ///
  ///
  static List<T> toListType<T>(List<dynamic> data) => List<T>.from(data);

  /// Initialize database.
  ///
  ///
  Future<bool> init() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    db = await databaseFactoryIo.openDatabase(
      join(dir.path, 'money_manager.db'),
      codec: _getEncryptSembastCodec('money_manager_CODEC'),
    );
    _mainStore = StoreRef<String, Map<String, dynamic>>.main();
    final RecordRef<String, Map<String, dynamic>> recordRef =
    _mainStore.record('isInit');
    if (!await recordRef.exists(db)) {
      recordRef.put(db, <String, bool>{'init': true});
      return true;
    }
    return false;
  }

  /// Set key value pair record to database.
  ///
  ///
  Future<bool> setRecord(String key, BaseResource val) async =>
      setRecordFromMap(key, val?.toJson());

  /// Set key value pair record to database.
  ///
  ///
  Future<bool> setRecordFromMap(String key, Map<String, dynamic> val) async =>
      await _mainStore.record(key).put(db, val ?? <String, dynamic>{}) != null;

  /// Get record using the [key] from database.
  ///
  ///
  Future<T> getRecord<T extends BaseResource>(String key) async {
    final RecordRef<String, Map<String, dynamic>> recordRef =
    _mainStore.record(key);

    if (!await recordRef.exists(db)) {
      return null;
    }

    final Map<String, dynamic> record = await recordRef.get(db);
    final ResourceDefinition def = ResourceHelper.get<T>();
    return def.builder(record) as T;
  }

  /// Get record using the [key] from database.
  ///
  ///
  Future<Map<String, dynamic>> getRecordAsMap(String key) async {
    final RecordRef<String, Map<String, dynamic>> recordRef =
    _mainStore.record(key);
    return await recordRef.exists(db)
        ? Map<String, dynamic>.of(await recordRef.get(db))
        : null;
  }

  /// Get record stream using the [key] from database.
  ///
  ///
  Stream<RecordSnapshot<String, Map<String, dynamic>>> getRecordStream(
      String key) =>
      _mainStore.record(key).onSnapshot(db);

  /// Delete record.
  ///
  ///
  Future<bool> deleteRecord(String key) async {
    final RecordRef<String, Map<String, dynamic>> recordRef =
    _mainStore.record(key);

    if (await recordRef.exists(db)) {
      await recordRef.delete(db);
      return true;
    }

    return false;
  }
}

///
///
///
const String _encryptCodecSignature = 'money_managerSign';


///
///
///
SembastCodec _getEncryptSembastCodec(String password) => SembastCodec(
    signature: _encryptCodecSignature,
    codec: _EncryptCodec(_generateEncryptPassword(password)));

/// Generate an encryption password based on a user input password
///
/// It uses MD5 which generates a 16 bytes blob, size needed for Salsa20
Uint8List _generateEncryptPassword(String password) {
  final Uint8List blob =
  Uint8List.fromList(md5.convert(utf8.encode(password)).bytes);
  assert(blob.length == 16);
  return blob;
}

//--------------------------------------------------------------------------------
/// Salsa20 based Codec
///
///
class _EncryptCodec extends Codec<dynamic, String> {
  _EncryptCodec(Uint8List passwordBytes) {
    final Salsa20 salsa20 = Salsa20(Key(passwordBytes));
    _encoder = _EncryptEncoder(salsa20);
    _decoder = _EncryptDecoder(salsa20);
  }

  _EncryptEncoder _encoder;
  _EncryptDecoder _decoder;

  @override
  Converter<String, dynamic> get decoder => _decoder;

  @override
  Converter<dynamic, String> get encoder => _encoder;
}

//--------------------------------------------------------------------------------
/// Salsa20 based encoder
///
///
class _EncryptEncoder extends Converter<dynamic, String> {
  _EncryptEncoder(this.salsa20);

  final Salsa20 salsa20;

  @override
  String convert(dynamic input) {
    // Generate random initial value
    final Uint8List iv = _randBytes(8);
    final String ivEncoded = base64.encode(iv);
    assert(ivEncoded.length == 12);

    // Encode the input value
    final String encoded =
        Encrypter(salsa20).encrypt(json.encode(input), iv: IV(iv)).base64;

    // Prepend the initial value
    return '$ivEncoded$encoded';
  }
}

///
///
///
Random _random = Random.secure();

/// Random bytes generator
///
///
Uint8List _randBytes(int length) => Uint8List.fromList(
    List<int>.generate(length, (int i) => _random.nextInt(256)));

//--------------------------------------------------------------------------------
/// Salsa20 based decoder
///
///
class _EncryptDecoder extends Converter<String, dynamic> {
  _EncryptDecoder(this.salsa20);

  final Salsa20 salsa20;

  @override
  dynamic convert(String input) {
    // Read the initial value that was prepended
    assert(input.length >= 12);
    final Uint8List iv = base64.decode(input.substring(0, 12));

    // Extract the real input
    input = input.substring(12);

    // Decode the input
    final decoded =
    json.decode(Encrypter(salsa20).decrypt64(input, iv: IV(iv)));
    if (decoded is Map) {
      return decoded.cast<String, dynamic>();
    }
    return decoded;
  }
}