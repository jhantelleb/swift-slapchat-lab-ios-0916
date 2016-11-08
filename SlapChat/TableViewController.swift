//
//  TableViewController.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData


class TableViewController: UITableViewController {

    var store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchData()
//        if store.messages.count == 0 { generateTestData() }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.messages.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        store.fetchData()
        self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        cell.textLabel?.text = store.messages[indexPath.row].content
        guard let createdAt = store.messages[indexPath.row].createdAt else { return cell}
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        cell.detailTextLabel?.text = dateFormatter.string(from: createdAt as Date)
        return cell
    }
    
    func generateTestData() {
        let managedContext = store.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Message", in: managedContext)
        guard let unwrappedEntity = entity else { return }
        let message = NSManagedObject(entity: unwrappedEntity, insertInto: managedContext) as! Message
        message.content = "Hello World"
        message.createdAt = NSDate()
        let message2 = NSManagedObject(entity: unwrappedEntity, insertInto: managedContext) as! Message
        message2.content = "Hello World 2"
        message2.createdAt = NSDate()
//        do {
//            try managedContext.save()
//            store.messages.append(message)
//        } catch { }
        
        store.saveContext()
        store.fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //  if segue.identifier == "addMessage" {
        //  let destVC = segue.destination as! AddMessageViewController
//            destVC.messageTextField =
        //}
    }
}
