//
//  ContentView.swift
//  SwiftDataTodo
//
//  Created by sako0602 on 2024/12/30.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\Todo.priority, order: .reverse)]
    ) private var todos:[Todo]
    @State private var path = NavigationPath()
    @State private var text = ""
    @State private var sortOrder = SortDescriptor(\Todo.title)
    
    var body: some View {
        NavigationStack(path: $path) {
            Form {
                Section {
                    HStack{
                        TextField("入力してください", text: $text)
                        Button("追加") {
                            addTask(title: text)
                        }
                    }
                }
                Section("追加された項目") {
                    if !todos.isEmpty {
                        ForEach(todos){ todo in
                            NavigationLink(value: todo) {
                                listRow(todo: todo)
                            }
                        }
                        .onDelete(perform: delete)
                    } else {
                        Text("⚠️Todoを入力してください")
                    }
                }
            }
            .navigationTitle("TODOリスト")
            .navigationDestination(for: Todo.self, destination: TodoDetailView.init)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("sort", selection: $sortOrder){
                        
                    }
                }
            }
        }
    }
    
    private func changeIsCheck(todo: Todo){
        todo.isChecked.toggle()
    }
    
    private func addTask(title: String){
        let addTodo = Todo(title: title)
        modelContext.insert(addTodo)
        self.text = ""
    }
    
    private func delete(_ indexSet: IndexSet){
        for index in indexSet {
            let deleteTodo = todos[index]
            modelContext.delete(deleteTodo)
        }
    }
    
    //MARK: ListRow
    private func listRow(todo: Todo) -> some View {
        HStack {
            Image(systemName: todo.isChecked
                  ? "checkmark.circle"
                  : "circle.dotted")
                .onTapGesture {
                    changeIsCheck(todo: todo)
                }
            Text(todo.title)
            Spacer()
            VStack {
                let jDate = todo.formattedDate()
                Text("\(jDate)")
                Text("優先度：\(todo.priority)")
            }
        }
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: Todo.self)
}
