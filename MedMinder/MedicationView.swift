//
//  ViewController.swift
//  MedMinder
//
//  Created by Harr on 3/15/21.
//

import Foundation
import UIKit

class MedicationView: UITableViewController {
    
    public var newMed = Medication("", dosage: "50mg", shape: "capsule", color: "white", expiration: NSDate(), whenToTake: "Once per day")
    
    @IBAction func addMedSave(_ segue:UIStoryboardSegue){
        print("addMedSave from addMedication")
        print("newMed: \(newMed)")
    }
    
    @IBAction func addMedCancel(_ segue:UIStoryboardSegue){
        print("addMedCancel from addMedication")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

