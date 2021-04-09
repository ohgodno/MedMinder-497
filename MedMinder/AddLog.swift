//
//  AddLog.swift
//  MedMinder
//
//  Created by Simran on 4/9/21.
//

import Foundation
import UIKit
import JVFloatLabeledTextField

class AddLog: UITableViewController, UITextFieldDelegate {
    
    @objc func action() {
        view.endEditing(true)
    }
    
    @IBOutlet weak var SaveBut: UIBarButtonItem!
    @IBOutlet weak var CancelBut: UIBarButtonItem!
    @IBOutlet weak var TodaysDate: UITableViewCell!
    @IBOutlet var table: UITableView!
    @IBOutlet weak var TodaysEntry: UITableViewCell!
    
    @IBAction func saveLog(_ sender: Any) {
        performSegue(withIdentifier: "saveValidLog", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? LogView {
            nextViewController.newLog = MedLog("june 3rd", entry: "stomachaches")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
