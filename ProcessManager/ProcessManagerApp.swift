//
//  ProcessManagerApp.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import Foundation
import SwiftUI
import ProcessListToAppShared

@main
struct ProcessManagerApp: App {
  @StateObject var dependencies = DependenciesContainer()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(dependencies)
    }
  }
}
