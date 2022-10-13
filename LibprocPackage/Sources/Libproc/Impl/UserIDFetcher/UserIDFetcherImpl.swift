import SystemConfiguration

final class UserIDFetcherImpl: UserIDFetcher {
    enum FetchError: Error { case unableToFetchUserID }

    func getUserID() -> Result<uid_t, Error> {
        var uid: uid_t = 0
        var gid: gid_t = 0

        guard SCDynamicStoreCopyConsoleUser(nil, &uid, &gid) != nil else {
            return .failure(FetchError.unableToFetchUserID)
        }

        return .success(uid)
    }

}
