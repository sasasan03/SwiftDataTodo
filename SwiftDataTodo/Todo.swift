//
//  File.swift
//  SwiftDataTodo
//
//  Created by sako0602 on 2024/12/30.
//

import Foundation
import SwiftData

@Model
class Todo{
    var title: String
    var isChecked: Bool = false
    var priority: Int = 2
    var date: Date = Date.now
    init(title: String) {
        self.title = title
    }
    
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.calendar = Calendar(identifier: .japanese)
        formatter.dateFormat = "MM月dd日 HH:mm"
        return formatter.string(from: date)
    }
    
}


var todoDummyData = [
    Todo(title: "洗濯"),
    Todo(title: "掃除"),
    Todo(title: "買い物"),
]
