//
//  AddMedication.swift
//  MedMinder
//
//  Created by Harr on 3/15/21.
//

import Foundation
import UIKit
import JVFloatLabeledTextField

class AddMedication: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var selectedDosageUnits: String! = "mg"
    var dosageUnitsOptions = ["mg", "ml", "fl oz", "pills", "tablets"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // number of session
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dosageUnitsOptions.count // number of dropdown items
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dosageUnitsOptions[row] // dropdown item
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDosageUnits = dosageUnitsOptions[row] // selected item
        dosage.text = selectedDosageUnits + " ▼"
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        dosage.tintColor = .clear
        dosage.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        dosage.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        view.endEditing(true)
    }
    
    @IBOutlet var table:                 UITableView!
    @IBOutlet weak var SaveButton:       UIBarButtonItem!
    @IBOutlet weak var medicationName:   JVFloatLabeledTextField!
    @IBOutlet weak var CancelButton:     UIBarButtonItem!
    @IBOutlet weak var dosage:           UITextField!
    @IBOutlet weak var whenToTakeDetail: UILabel!
    @IBOutlet weak var howToTakeDetail:  UILabel!
    @IBOutlet weak var pillShapeDetail:  UILabel!
    @IBOutlet weak var pillColorDetail:  UILabel!
    @IBOutlet var refillableSwitch:      UISwitch!
    public var selectedDetailLabel:      UILabel = UILabel()
    public var navTitleOptions:          String = ""
    public var selectedOptions:          [String] = []
    public var colorsOptions:            [UIColor] = []
    public var shapesOptions:            [UIImage] = []
    public var textFieldError:           [Bool] = [false, false]
    
    @IBAction func saveMed(_ sender: Any) {
        if (checkAllFields()){
            print(":)")
            performSegue(withIdentifier: "saveValidMed", sender: nil)
        } else {
            print(":(")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? MedicationView {
            nextViewController.newMed = ["name": medicationName.text!]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createPickerView()
        dismissPickerView()
    }

    
    public func checkAllFields() -> Bool {
            let boxes = [medicationName, dosage]
            let detailLabels = [whenToTakeDetail, howToTakeDetail, pillShapeDetail, pillColorDetail]
            var goodBoxes:[Bool] = [true]
//            for i in 0..<2 {
//                if (boxes[i]?.text == nil || boxes[i].text == "") {
//                    boxes[i].setError(self.errorWithLocalizedDescription("Please fill in this box"), animated: true)
//                    goodBoxes.append(false)
//                    textFieldError[i] = true
//                } else {
//                    boxes[i].underlineColor = MaterialColor.green.accent3
//                    goodBoxes.append(true)
//                    textFieldError[i] = false
//                    boxes[i].errorFont = UIFont(name: "Helvetica", size: 0)
//                    boxes[i].placeholderColor = MaterialColor.green.accent3
//                    boxes[i].errorColor = MaterialColor.green.accent3
//                }
//                tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0), NSIndexPath(forRow: 1, inSection: 0)], withRowAnimation: .Automatic)
//                tableView.reloadData()
//            }
//            for i in detailLabels {
//                if (i.text == "Choose" || i.text == "Set") {
//                    i.textColor = MaterialColor.red.accent3
//                    goodBoxes.append(false)
//                } else {
//                    i.textColor = MaterialColor.green.accent3
//                    goodBoxes.append(true)
//                }
//            }
            return !goodBoxes.contains(false)
        }

}

