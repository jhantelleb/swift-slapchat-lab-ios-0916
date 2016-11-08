//
//  AddMessageViewController.swift
//  SlapChat
//
//  Created by Jhantelle Belleza on 11/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class AddMessageViewController: UIViewController {

    var store = DataStore.sharedInstance
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBAction func saveButton(_ sender: AnyObject) {
        if !(messageTextField.text?.isEmpty)! {
        let managedContext = store.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Message", in: managedContext)
        guard let unwrappedEntity = entity else { return }
        let message = NSManagedObject(entity: unwrappedEntity, insertInto: managedContext) as! Message
        message.content = messageTextField.text
        message.createdAt = NSDate()
        store.saveContext()
        self.dismiss(animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


}
