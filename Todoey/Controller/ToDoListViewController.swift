//
//  ViewController.swift
//  Todoey
//
//  Created by Sandesh Shetty on 2/3/18.
//  Copyright © 2018 Sandesh Shetty. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    
//    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.pList")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        print(dataFilePath!)
        
//        let item = Item()
//        item.title = "Find Mike"
//        itemArray.append(item)
//
//        let item1 = Item()
//        item1.title = "Buy Eggs"
//        itemArray.append(item1)
//
//
//        let item2 = Item()
//        item2.title = "Destroy Demogorgon"
//        itemArray.append(item2)

        //loading with UserDefaults pList
//        if let items = defaults.array(forKey: "toDoeyArray") as? [Item] {
//            itemArray = items
//        }
        
        //Loading while using NSCoder FileManager.defaults
        loadItems()
        
    }

    //MARK - TableView Datasource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none

        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
        
    }

    //MARK - Table View Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }//equal to below code
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add item button on our UIAlert
            print(textField.text!)
            
            let item = Item()
            item.title = textField.text!
            
            self.itemArray.append(item)
        
//            self.defaults.set(self.itemArray, forKey: "toDoeyArray")
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            //print(alertTextField.text)
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    //MARK - Model Manipulation Methods
    func saveItems(){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array,\(error)")
        }
        self.tableView.reloadData()

    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!) {
                let decoder = PropertyListDecoder()
            do {
                   itemArray = try decoder.decode([Item].self, from: data)
            }catch {
                print("Error while decoding item array, \(error)")
            }
            
        }
    }
}

