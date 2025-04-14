//
//  Keio_KLMSApp.swift
//  Keio-KLMS
//
//  Created by 小谷理人 on 2025/04/14.
//

import SwiftUI

@main
struct Keio_KLMSApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var logindata = loginData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(logindata)
        }
    }
}
