import 'package:bedrive/drive/screens/manage-users/sharee-payload.dart';
import 'package:bedrive/drive/state/drive-state.dart';
import 'package:bedrive/drive/state/file-entry/entry-permissions.dart';
import 'package:bedrive/drive/state/file-entry/file-entry-user.dart';
import 'package:flutter/material.dart';

class ManageEntryUsersState extends ChangeNotifier {
  ManageEntryUsersState(this.driveState);

  SharedEntryPermissions permissionForNewUsers = SharedEntryPermissions();
  final DriveState driveState;
  bool loading = false;
  int updatingUserId;
  bool shareButtonEnabled = false;

  addUsers(List<int> entryIds, List<String> emails) async {
    toggleLoading(true);
    try {
      final users = await driveState.api.addUsers(entryIds, emails, permissionForNewUsers);
      return driveState.updateEntryUsers(entryIds, users);
    } finally {
      toggleLoading(false);
    }
  }

  removeUser(List<int> entryIds, int userId) async {
    toggleLoading(true);
    try {
      return await driveState.unshare(entryIds, userId);
    } finally {
      toggleLoading(false);
    }
  }

  Future<List<FileEntryUser>> updateUsers(List<int> entryIds, ShareePayload sharee) async {
    toggleLoading(true, userId: sharee.id);
    try {
      final users = await driveState.api.updateUsers(entryIds, sharee);
      return driveState.updateEntryUsers(entryIds, users);
    } finally {
      toggleLoading(false);
    }
  }

  toggleLoading(bool loading, {int userId}) {
    updatingUserId = userId;
    this.loading = loading;
    notifyListeners();
  }

  toggleShareButtonState(bool enabled) {
    shareButtonEnabled = enabled;
    notifyListeners();
  }

  setPermissionsForNewUsers(SharedEntryPermissions permissions) {
    permissionForNewUsers = permissions;
    notifyListeners();
  }
}