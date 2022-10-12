# Process Manager

Process Manager app that lists all processes in the system ro processes that belong to the current user. It allows to kill any process and show alert if errors occur. It consists of several Swift packages and Xcode targets.

## Swift Packages
 - **SignalSenderPackage** - is a simplified wrapper around `<signal.h>` library
 - **LibprocPackage** - is a simplified wrapper around `<libproc.h>` library
 - **ProcessManagerCorePackage** - is a package which contains abstract and reusable code which could be asccessed from any Xcode target

## Xcode Targets
 - **ProcessManager** - is a target for main app
 - **com.alex.ProcessKillerXPCService** - is a target for privilege helper tool that is used by the app to kill processes
 - **ProcessListXPCService** - is a target for embedded XPC Service that is used by the app to retriee the list of processes
 - **Process<Killer/List>ToAppShared** - is a targets for frameworks that is used to share common constants and protocols between app and XPC services
 - **ConnectionSecurity** - is a target for framework that is used to verify the connections to the XPC service