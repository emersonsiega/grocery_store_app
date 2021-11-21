import 'package:mockito/mockito.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPathProviderPlatformSuccess extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String> getTemporaryPath() async {
    return "/tmp";
  }

  @override
  Future<String> getApplicationSupportPath() async {
    return "/tmp";
  }

  @override
  Future<String> getLibraryPath() async {
    return "/tmp";
  }

  @override
  Future<String> getApplicationDocumentsPath() async {
    return "/tmp";
  }

  @override
  Future<String> getExternalStoragePath() async {
    return "/tmp";
  }

  @override
  Future<List<String>> getExternalCachePaths() async {
    return <String>["/tmp"];
  }

  @override
  Future<List<String>> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return <String>["/tmp"];
  }

  @override
  Future<String> getDownloadsPath() async {
    return "/tmp";
  }
}

class MockPathProviderPlatformError extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String> getTemporaryPath() async {
    throw Exception();
  }

  @override
  Future<String> getApplicationSupportPath() async {
    return "/tmp";
  }

  @override
  Future<String> getLibraryPath() async {
    return "/tmp";
  }

  @override
  Future<String> getApplicationDocumentsPath() async {
    return "/tmp";
  }

  @override
  Future<String> getExternalStoragePath() async {
    return "/tmp";
  }

  @override
  Future<List<String>> getExternalCachePaths() async {
    return <String>["/tmp"];
  }

  @override
  Future<List<String>> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return <String>["/tmp"];
  }

  @override
  Future<String> getDownloadsPath() async {
    return "/tmp";
  }
}
