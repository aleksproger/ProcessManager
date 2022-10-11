//
//  Toolbar.swift
//  ProcessManager
//
//  Created by Aleksei Sapitskii on 11.10.2022.
//

import SwiftUI

struct Toolbar: ToolbarContent {
    var body: some ToolbarContent {
      ToolbarItem(placement: .navigation) {
        Button(action: toggleSidebar) {
          Image(systemName: "sidebar.left")
        }
      }
    }
  
  func toggleSidebar() {
    NSApp.keyWindow?
      .contentViewController?
      .tryToPerform(
        #selector(NSSplitViewController.toggleSidebar(_:)),
        with: nil
      )
  }
}
