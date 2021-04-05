//
//  AddMedLog.swift
//  MedMinder
//
//  Created by Simran on 4/5/21.
//

import Foundation
import UIKit
import JVFloatLabeledTextField
import FirebaseDatabase

class AddMedLog: UITableViewController, UITextFieldDelegate {
    
    @objc func action() {
        view.endEditing(true)
    }
    
    @IBOutlet var table:                 UITableView!
    @IBOutlet weak var SaveButton:       UIBarButtonItem!
    @IBOutlet weak var TodaysDate:   JVFloatLabeledTextField!
    @IBOutlet weak var CancelButton:     UIBarButtonItem!
    @IBOutlet weak var TodaysEntry:           JVFloatLabeledTextField!
    public var textFieldError:           [Bool] = [false, false]
    
    @IBAction func saveLog(_ sender: Any) {
        if (checkAllFields()){
            print(":)")
            performSegue(withIdentifier: "saveMedLog", sender: nil)
        } else {
            print(":(")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? MedLogView {
            nextViewController.newLog = MedLogs(TodaysDate.text!, entry: TodaysEntry.text!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    public func checkAllFields() -> Bool {
        return true //!goodBoxes.contains(false)
    }
}


