public struct Libproc {
    public static let wrapper: LibprocWrapper = LibprocWrapperImpl(userIDFetcher: UserIDFetcherImpl())
}
