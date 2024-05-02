import 'dart:typed_data';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:gcloud/storage.dart';
import 'package:mime/mime.dart';

class CloudApi {
  final auth.ServiceAccountCredentials _credentials;
  auth.AutoRefreshingAuthClient? _client;

  CloudApi(String json)
      : _credentials = auth.ServiceAccountCredentials.fromJson(json);

  Future<ObjectInfo> save(String name, Uint8List imgBytes, {String? title, String? description}) async {
    // Create a client
    if (_client == null)
      _client =
          await auth.clientViaServiceAccount(_credentials, Storage.SCOPES);

    // Instantiate objects to cloud storage
    var storage = Storage(_client!, 'Image Upload Google Storage');
    var bucket = storage.bucket('ihbaryol');

    // Save to bucket
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final type = lookupMimeType(name);
    final metadata = ObjectMetadata(
      contentType: type,
      custom: {
        'timestamp': '$timestamp',
      },
    );

    // Add title and description to metadata if provided
    if (title != null) metadata.custom!['title'] = title;
    if (description != null) metadata.custom!['description'] = description;

    return await bucket.writeBytes(name, imgBytes, metadata: metadata);
  }
}
