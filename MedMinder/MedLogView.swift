//
//  ViewController.swift
//  MedMinder
//
//  Created by Harr on 3/15/21.
//

import Foundation
import UIKit

class MedLogView: UITableViewController {
    
    public var newLog = MedLogs("", entry: "")
    
    public var logList = [MedLogs]()
    
    public class func saveMedLogsList(_ value: [MedLogs]) {
        print(value)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false) {
            UserDefaults.standard.set(savedData, forKey: "logList")
        }
    }

    public class func loadMedLogsList() -> [MedLogs] {
        if let medLogData = UserDefaults.standard.object(forKey: "logList") as? Data {
            if let logList = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(medLogData) as? [MedLogs] {
                return logList
            }
        }
        return [MedLogs]()
    }
    
    @IBAction func addLogSave(_ segue:UIStoryboardSegue){
        print("addLogSave from addMedLog")
        print("newLog: \(dump(newLog))")
        logList.append(newLog)
        MedLogView.saveMedLogsList(logList)
        tableView.reloadData()
    }
    
    @IBAction func addLogCancel(_ segue:UIStoryboardSegue){
        print("addLogCancel from addMedLog")
        dismiss(animated: true, completion: nil)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedLogCell", for: indexPath)

        cell.textLabel?.text = logList[indexPath.row].DATE
        cell.detailTextLabel?.text = logList[indexPath.row].DATE
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logList = MedLogView.loadMedLogsList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}



