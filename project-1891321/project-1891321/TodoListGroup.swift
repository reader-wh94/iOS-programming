//
//  TodoListGroup.swift
//  project-1891321
//
//  Created by Apple on 2021/05/29.
//

import Foundation

class TodoListGroup: NSObject {
    var todoLists = [TodoList]()
    
    override init() {
        super.init()
    }
    
    func modify(todolist: TodoList, index: Int) {
        todoLists[index] = todolist
    }
}
