import 'package:mips/common/common.dart';
import 'package:mips/domain/contracts/update_repository.dart';

class CheckUpdateUseCase {
  final UpdateRepository updateRepository;

  const CheckUpdateUseCase({required this.updateRepository});

  Future<Result<Failure, String>> call(String currentVersion) async {
    var result = await updateRepository.checkUpdate();
    if (result.isSuccess()) {
      if (!checkIfNewVersion(
        availableVersion: result.getSuccess() ?? "",
        currentVersion: currentVersion,
      )) {
        return Error(NoAvailableAppUpdateFailure());
      }
    }
    return result;
  }

  bool checkIfNewVersion({
    required String availableVersion,
    required String currentVersion,
  }) {
    AppUtils.showDebugLog(
      runtimeType,
      "VersionFromServer:$availableVersion, VersionFromAPP:$currentVersion",
    );
    // Helper to parse version parts.
    // It ensures a consistent structure of [major, minor, patch, buildNumber].
    // Missing parts are treated as 0.
    if (availableVersion.isEmpty || currentVersion.isEmpty) {
      return false;
    }

    // Parse both available and current version strings into consistent lists of integers.
    final List<int> availableParts = _parseVersionParts(availableVersion);
    final List<int> currentParts = _parseVersionParts(currentVersion);
    // Iterate through the consistent version parts (major, minor, patch, build number)
    // to compare them sequentially. Both lists will now always have 4 elements.
    for (int i = 0; i < availableParts.length; i++) {
      // Compare the current part.
      // If available is greater, it's newer.
      if (availableParts[i] > currentParts[i]) {
        return true;
      }
      // If available is smaller, it's older.
      if (availableParts[i] < currentParts[i]) {
        return false;
      }
      // If they are equal, continue to the next part.
    }

    // If all parts are equal, the versions are identical, so it's not newer.
    return false;
  }

  List<int> _parseVersionParts(String versionString) {
    final List<String> mainAndBuild = versionString.split('-');
    final List<String> versionNumbersStr = mainAndBuild[0].split('.');

    // Initialize with default values (0) for major, minor, patch
    List<int> parsedParts = [0, 0, 0];

    // Parse major, minor, patch components, up to 3 parts.
    for (int i = 0; i < versionNumbersStr.length && i < 3; i++) {
      parsedParts[i] = int.tryParse(versionNumbersStr[i]) ?? 0;
    }

    // Parse build number. If not present, default to 0.
    final int buildNumber = mainAndBuild.length > 1
        ? (int.tryParse(mainAndBuild[1]) ?? 0)
        : 0;

    // Return a list of 4 integers: [major, minor, patch, buildNumber]
    return [...parsedParts, buildNumber];
  }
}
