//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Sandesh Shetty on 2/27/18.
//  Copyright © 2018 Sandesh Shetty. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

       loadCategory()
    }

    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add New Category"
            textField = alertTextField
        }
        
        let alertAction = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let category = Category(context: self.context)
            category.name = textField.text!
            
            self.categoryArray.append(category)
            
            self.saveCategory()
        }
        
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexpath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexpath.row]
            
        }
    }
    
    //MARK: - Data Manipulation Methods
    func saveCategory() {
        do {
           try context.save()
        } catch {
            print("Error saving category,\(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategory() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching Category, \(error)")
        }
        tableView.reloadData()
    }
    
}
