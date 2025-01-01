//
//  SwiftDataTodoApp.swift
//  SwiftDataTodo
//
//  Created by sako0602 on 2024/12/30.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataTodoApp: App {
    
    let modelContainer: ModelContainer?
    
    init() {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: false)
            modelContainer = try ModelContainer(for: Todo.self, configurations: configuration)
        } catch {
            modelContainer = nil
            fatalError("SwiftDataの初期化に失敗しました：\(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer!)
//        .modelContainer(for: Todo.self, inMemory: false ,isAutosaveEnabled: true, isUndoEnabled: false)
//        .modelContainer(for: Todo.self)
        
    }
}
