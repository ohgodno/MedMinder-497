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
    
    public var medicationList = [Medication]()
    
    public class func saveMedicationList(_ value: [Medication]) {
        print(value)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false) {
            UserDefaults.standard.set(savedData, forKey: "medicationList")
        }
    }

    public class func loadMedicationList() -> [Medication] {
        if let medicationData = UserDefaults.standard.object(forKey: "medicationList") as? Data {
            if let medicationList = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(medicationData) as? [Medication] {
                return medicationList
            }
        }
        return [Medication]()
    }
    
    @IBAction func addMedSave(_ segue:UIStoryboardSegue){
        print("addMedSave from addMedication")
        print("newMed: \(dump(newMed))")
        medicationList.append(newMed)
        MedicationView.saveMedicationList(medicationList)
        tableView.reloadData()
    }
    
    @IBAction func addMedCancel(_ segue:UIStoryboardSegue){
        print("addMedCancel from addMedication")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicationList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationCell", for: indexPath)

        cell.textLabel?.text = medicationList[indexPath.row].NAME
        cell.detailTextLabel?.text = medicationList[indexPath.row].DOSAGE
//        cell.imageView?.image = UIImage(named: country.isoCode)

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//            return "Section \(section)"
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        medicationList = MedicationView.loadMedicationList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


