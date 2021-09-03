
import 'package:bedrive/drive/http/app-http-client.dart';
import 'package:bedrive/drive/screens/destination-picker/entry-move-type.dart';
import 'package:bedrive/drive/screens/manage-users/sharee-payload.dart';
import 'package:bedrive/drive/screens/shareable-link/shareable-link.dart';
import 'package:bedrive/drive/state/file-entry/entry-permissions.dart';
import 'package:bedrive/drive/state/file-entry/file-entry-user.dart';
import 'package:bedrive/drive/state/file-entry/file-entry.dart';
import 'package:bedrive/drive/state/offlined-entries/entry-sync-info.dart';
import 'package:bedrive/utils/local-storage.dart';
import 'package:dio/dio.dart';

class FileEntriesApi {
  FileEntriesApi(this.http, this.localStorage);
  final AppHttpClient http;
  final LocalStorage localStorage;

  String previewUrl(FileEntry fileEntry) {
    if (fileEntry.url.startsWith('http')) {
      return fileEntry.url;
    } else {
      return '${http.baseBackendUrl}/${fileEntry.url.replaceFirst('secure/', 'api/v1/')}?accessToken=${http.accessToken}';
    }
  }

  String downloadUrl(List<FileEntry> entries) {
    String hashes = entries.map((e) => e.hash).join(',');
    return '${http.backendApiUrl}/entries/download?hashes=$hashes&accessToken=${http.accessToken}';
  }

  Future<String> getFileContents(FileEntry fileEntry, {String parentId}) async {
    final options = new Options(headers: {'Content-type' : 'text/plain'});
    return http.get(previewUrl(fileEntry), options: options);
  }

  Future<String> loadEntries(Map<String, String> params, {CancelToken cancelToken}) {
    return http.get('/entries', params: params, options: Options(responseType: ResponseType.plain), cancelToken: cancelToken);
  }

  Future<FileEntry> renameFile(int id, {String name, String description}) async {
    final response = await http.put('/entries/$id', {'name': name, 'description': description});
    return FileEntry.fromJson(response['fileEntry']);
  }

  Future<List<FileEntryUser>> addUsers(List<int> entryIds, List<String> emails, SharedEntryPermissions permissions) {
    return http.post('/entries/add-users', payload: {'entryIds': entryIds, 'emails': emails, 'permissions': permissions})
      .then((response) {
        return (response['users'] as Iterable).map((u) => FileEntryUser.fromJson(u)).toList();
    });
  }

  Future<List<FileEntryUser>> updateUsers(List<int> entryIds, ShareePayload sharee) {
    return http.put('/entries/update-user/${sharee.id}', {'entryIds': entryIds, 'permissions': sharee.permissions})
      .then((response) {
        return (response['users'] as Iterable).map((u) => FileEntryUser.fromJson(u)).toList();
      });
  }

  Future<List<FileEntryUser>> removeUser(List<int> entryIds, int userId) {
    return http.post('/entries/remove-user/$userId', payload: {'entryIds': entryIds})
      .then((response) {
        return (response['users'] as Iterable).map((u) => FileEntryUser.fromJson(u)).toList();
      });
  }

  Future<ShareableLink> fetchLink(int entryId) {
    return http.get('/entries/$entryId/shareable-link')
      .then((response) {
        return ShareableLink.fromJson(response['link']);
      });
  }

  Future<ShareableLink> crupdateLink(int entryId, ShareableLink link, Map<String, dynamic> values) {
    final request = link == null
      ? http.post('/entries/$entryId/shareable-link', payload: values)
      : http.put('/shareable-links/${link.id}', values);
    return request.then((response) {
      return ShareableLink.fromJson(response['link']);
    });
  }

  Future<void> deleteLink(int linkId) {
    return http.delete('/shareable-links/$linkId');
  }

  Future<void> deleteFiles(List<int> fileIds, {bool deleteForever = false}) {
    return http.delete('/entries', {'entryIds': fileIds, 'deleteForever': deleteForever});
  }

  Future<void> restoreEntries(List<int> entryIds) {
    return http.post('/entries/restore', payload: {'entryIds': entryIds});
  }

  Future<List<FileEntry>> moveOrCopyEntries(List<int> fileIds, int destination, EntryMoveType moveType) async  {
    final endpoint = moveType == EntryMoveType.move ? 'move' : 'copy';
    final response = await http.post('/entries/$endpoint', payload: {'entryIds': fileIds, 'destination': destination});
    return (response['entries'] as Iterable).map((f) => FileEntry.fromJson(f)).toList();
  }

  Future<FileEntry> createFolder(String name, {parentId: int}) async {
    final response = await http.post('/folders', payload: {'name': name, 'parentId': parentId});
    return FileEntry.fromJson(response['folder']);
  }

  Future<dynamic> addToStarred(List<int> entryIds) {
    return http.post('/entries/star', payload: {'entryIds': entryIds});
  }

  Future<dynamic> removeFromStarred(List<int> entryIds) {
    return http.post('/entries/unstar', payload: {'entryIds': entryIds});
  }

  Future<List<EntrySyncInfo>> getSyncInfo(List<String> fileNames) async {
    final response = await http.post('/entries/sync-info', payload: {'fileNames': fileNames});
    return (response['entries'] as Iterable).map((e) => EntrySyncInfo.fromJson(e)).toList();
  }
}