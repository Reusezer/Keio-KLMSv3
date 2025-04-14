//
//  ContentView.swift
//  Keio-KLMS
//
//  Created by 小谷理人 on 2025/04/14.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var showOpening = true
    // Whether we have triggered the fade-out animation
    @State private var fadeOut = false
    var body: some View {
        Group{
            if showOpening {
                StartView()
                    .opacity(fadeOut ? 0 : 1)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeOut(duration: 1)) {
                                fadeOut = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showOpening = false
                            }
                        }
                    }
            }else {
                MainView()
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
