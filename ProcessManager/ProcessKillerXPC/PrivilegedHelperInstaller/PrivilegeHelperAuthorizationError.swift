enum PrivelegedHelperAuthorizationError: Error {
    case unsuccesfulOSStatus(String)
    case unableToCreateAuthReference
    case smJobBlessFailed(String)
}
