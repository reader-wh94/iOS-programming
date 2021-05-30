//
//  ListGroup.swift
//  project-1891321
//
//  Created by Apple on 2021/05/30.
//

import Foundation

class ListGroup: NSObject {
    var lists = [TodoList]()
    
    override init() {
        super.init()
    }
    
    func modify(list: TodoList, index: Int) {
        lists[index] = list
    }
}
