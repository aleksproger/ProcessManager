//
//  DependenciesContainer.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import ProcessManagerCore
import Foundation
import ProcessListToAppShared

final class DependenciesContainer: ObservableObject {
  lazy var installer = PolicyRegulatedInstaller(
    installationPolicy: InstallationVerifyingPolicy(fileManager: FileManager.default),
    subject: PriviliegedHelperInstallerImpl()
  )
  
  lazy var errorHandler = LoggingErrorHandler(subject: DefaultErrorHandler())
  
  lazy var processKiller = DefaultErrorHandlingProcessKiller(
    installer: installer,
    errorHandler: errorHandler,
    connection: Connections.processKillerConnection(errorHandler: errorHandler)
  )
  
  lazy var processList = DefaultProcessListXPC(
    connection: Connections.processListConnection(errorHandler: errorHandler),
    errorHandler: errorHandler.handle
  )
  
  lazy var userOwnedPublished: Published<[ProcessModel]>.Publisher = {
    let publisherAdapter = UserOwnedProcessesPublisherAdapterImpl(
      processList: processList
    )
    
    let publisher = IntervalPublisher(
      interval: 1,
      publisher: publisherAdapter.subject()
    )
    
    return RemoveDuplicatesPublishedAdapter(
      defaultValue: [],
      publisher: publisher.eraseToAnyPublisher()
    ).$value
  }()
  
  
  lazy var allProcessesPublished: Published<[ProcessModel]>.Publisher = {
    let publisherAdapter = AllProcessesPublisherAdapterImpl(
      processList: processList
    )
    
    let publisher = IntervalPublisher(
      interval: 1,
      publisher: publisherAdapter.subject()
    )
    
    return RemoveDuplicatesPublishedAdapter(
      defaultValue: [ProcessModel](),
      publisher: publisher.eraseToAnyPublisher()
    ).$value
  }()
}
