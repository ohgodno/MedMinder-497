//
//  ViewController.swift
//  MedMinder
//
//  Created by Simran on 4/9/21.
//

import Foundation
import UIKit

class LogView: UITableViewController {
    
    public var newLog = MedLog("", entry: "")
    
    public var logList = [MedLog]()
    
    public class func saveLogList(_ value: [MedLog]) {
        print(value)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false) {
            UserDefaults.standard.set(savedData, forKey: "logList")
        }
    }

    public class func loadLogList() -> [MedLog] {
        if let logData = UserDefaults.standard.object(forKey: "logList") as? Data {
            if let logList = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(logData) as? [MedLog] {
                return logList
            }
        }
        return [MedLog]()
    }
    
    @IBAction func addLogSave(_ segue:UIStoryboardSegue){
        print("addLogSave from addLog")
        print("newLog: \(dump(newLog))")
        logList.append(newLog)
        LogView.saveLogList(logList)
        tableView.reloadData()
    }
    
    @IBAction func addLogCancel(_ segue:UIStoryboardSegue){
        print("addLogCancel from AddLog")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logCell", for: indexPath)

        cell.textLabel?.text = logList[indexPath.row].DATE
        cell.detailTextLabel?.text = logList[indexPath.row].ENTRY
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logList = LogView.loadLogList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}



