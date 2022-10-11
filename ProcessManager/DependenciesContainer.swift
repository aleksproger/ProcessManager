//
//  DependenciesContainer.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import Foundation

final class DependenciesContainer: ObservableObject {
  lazy var installer = PolicyRegulatedInstaller(
    installationPolicy: InstallationVerifyingPolicy(fileManager: FileManager.default),
    subject: PriviliegedHelperInstallerImpl()
  )
  
  lazy var errorHandler = LoggingErrorHandler(subject: DefaultErrorHandler())
    
  lazy var processKiller = InstallableProcessKiller(
    installer: installer,
    errorHandler: errorHandler.handle,
    connection: Connections.processKillerConnection
  )
  
  lazy var processList = DefaultProcessListXPC(
    connection: Connections.processListConnection,
    errorHandler: errorHandler.handle
  )
  
  lazy var processesPublisherAdapter = ProcessesPublisherAdapterImpl(
    processList: processList
  )
  
  lazy var publisher = IntervalPublisher(
    interval: 2,
    publisher: ProcessesPublisherAdapterImpl(processList: self.processList).subject()
  )
  
  lazy var processesPublished = RemoveDuplicatesPublishedAdapter(
    defaultValue: [],
    publisher: publisher.eraseToAnyPublisher()
  )
}
