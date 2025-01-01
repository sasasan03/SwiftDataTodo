//
//  TodoDetailView.swift
//  SwiftDataTodo
//
//  Created by sako0602 on 2024/12/30.
//

import SwiftUI
import SwiftData

struct TodoDetailView: View {
    
    @Bindable var todo: Todo
    
    var body: some View {
            Form{
                Section("Todo") {
                    TextField("", text: $todo.title)
                }
                .textCase(.none)
                Section("優先順位") {
                    Picker("", selection: $todo.priority) {
                        Text("１")
                            .tag(1)
                        Text("２")
                            .tag(2)
                        Text("３")
                            .tag(3)
                    }
                    .pickerStyle(.segmented)
                }
                Section("追加された時刻"){
                    let jDate = todo.formattedDate()
                    Text("\(jDate)")
                }
            }
            .navigationTitle("詳細画面")
    }
}

#Preview {
    //TODO: どうして下のような処理を書く必要があるのか調べ
    do {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(
            for: Todo.self,
            configurations: configuration)
        return TodoDetailView(todo: todoDummyData[0])
            .modelContainer(container)
    } catch {
        fatalError("ModelContainerの作成に失敗しました")
    }
    
//    TodoDetailView(todo: Todo(title: "あああ"))
//        .modelContainer(for: Todo.self)
    
}
