//
//  UserGroup.swift
//  ch09-1891321-tableView
//
//  Created by mac028 on 2021/04/23.
//

import Foundation

class UserGroup: NSObject{
    var users = [User]()
    override init(){
        super.init()
    }
    func testData(){
        for _ in 0...10{
            users.append(User(random: true))
        }
    }
    func count() -> Int{
        return users.count
    }
    func addUser(user:User){
        users.append(user)
    }
    func modifyUser(user:User, index:Int){
        users[index] = user
    }
    func removeUser(index: Int){
        users.remove(at: index)
    }
}
