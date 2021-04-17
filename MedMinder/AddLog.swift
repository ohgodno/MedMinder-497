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
    



    @IBOutlet weak var TodaysDate: UITextField!
    @IBOutlet weak var SaveBut: UIBarButtonItem!
    @IBOutlet weak var TodaysEntry: UITextField!
    @IBOutlet weak var CancelBut: UIBarButtonItem!
    @IBOutlet var table: UITableView!

    
    @IBAction func saveLog(_ sender: Any) {
        performSegue(withIdentifier: "saveValidLog", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? LogView {
            nextViewController.newLog = MedLog(TodaysDate.text!, entry: TodaysEntry.text!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
