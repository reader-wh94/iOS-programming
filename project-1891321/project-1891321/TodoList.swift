//
//  TodoList.swift
//  project-1891321
//
//  Created by Apple on 2021/05/27.
//

import Foundation

class TodoList: NSObject {
    var title: String = ""
    var content: String?
    var isComplete: Bool = false
    
    init(title: String, content: String?, isComplete: Bool = false) {
        self.title = title
        self.content = content
        self.isComplete = isComplete
    }
}
