//
//  TodoListViewController.swift
//  project-1891321
//
//  Created by Apple on 2021/05/27.
//

import UIKit

var list = [TodoList]()

class TodoListViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var todoListTableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    var mainTitleString: String=""
}

extension TodoListViewController {
    @IBAction func editingTable(_ sender: UIBarButtonItem) {
        if todoListTableView.isEditing == true {
            todoListTableView.isEditing = false
            sender.title = "Edit"
        } else {
            todoListTableView.isEditing = true
            sender.title = "Done"
        }
    }
}

extension TodoListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
        
        loadAllData()
        self.navigationItem.title = "📝 TodoList 📝"
    }
}

extension TodoListViewController{
    override func viewDidAppear(_ animated: Bool) {
        saveAllData()
        todoListTableView.reloadData()
    }
}

extension TodoListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = list[indexPath.row].title
        cell.detailTextLabel?.text = list[indexPath.row].content
        
        if list[indexPath.row].isComplete {
            cell.accessoryType = .checkmark
            
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        list.remove(at: indexPath.row)
        todoListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if list[indexPath.row].isComplete {
            list[indexPath.row].isComplete = false
            checkFalseList(sourceIndex: indexPath.row, destinationIndex: list.count)
        } else {
            list[indexPath.row].isComplete = true
            checkTrueList(sourceIndex: indexPath.row, destinationIndex: list.count)
        }
        todoListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = list[sourceIndexPath.row]
        list.remove(at: sourceIndexPath.row)
        list.insert(todo, at: destinationIndexPath.row)
        todoListTableView.reloadData()
    }
}

extension TodoListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addTodoList = segue.destination as! AddTodoListViewController
        addTodoList.titleStr = mainTitleString
    }
}

extension TodoListViewController {
    func checkTrueList(sourceIndex: Int, destinationIndex: Int) {
        let todo = list[sourceIndex]
        list.remove(at: sourceIndex)
        list.insert(todo, at: destinationIndex-1)
    }
    
    func checkFalseList(sourceIndex: Int, destinationIndex: Int) {
        let todo = list[sourceIndex]
        list.remove(at: sourceIndex)
        list.insert(todo, at: 0)
    }
}

extension TodoListViewController {
    func loadAllData() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "items") as? [[String: NSObject]] else {
            return
        }
        
        list = data.map {
            var title = $0["title"] as? String
            var content = $0["content"] as? String
            var isComplete = $0["isComplete"] as? Bool
            
            return TodoList(title: title!, content: content!, isComplete: isComplete!)
        }
    }
    
    func saveAllData() {
        let data = list.map {
            [
                "title": $0.title,
                "content": $0.content!,
                "isComplete": $0.isComplete
            ]
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "items")
        userDefaults.synchronize()
    }
}
