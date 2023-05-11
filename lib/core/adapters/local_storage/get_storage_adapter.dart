// import 'package:get_storage/get_storage.dart' as get_storage;
//
// import '../../core.dart';
//
// class GetStorage implements StorageAdapter {
//   late final get_storage.GetStorage _storage;
//
//   @override
//   Future<void> init({
//     required String container,
//   }) async {
//     await get_storage.GetStorage.init(container);
//     _storage = get_storage.GetStorage(container);
//   }
//
//   @override
//   Future<bool> readBool({
//     required String key,
//     bool defaultValue = false,
//   }) async {
//     return await _storage.read(key) ?? defaultValue;
//   }
//
//   @override
//   Future<bool> writeBool({required String key, required bool value}) async {
//     try {
//       await _storage.write(key, value);
//       return true;
//     } catch (_) {
//       return false;
//     }
//   }
//
//   @override
//   Future<String> readString({required String key, String defaultValue = ''}) async {
//     return await _storage.read(key) ?? defaultValue;
//   }
//
//   @override
//   Future<String> writeString({required String key, required String value}) async {
//     await _storage.write(key, value);
//     return value;
//   }
// }
