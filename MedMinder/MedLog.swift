//
//  MedLog.swift
//  MedMinder
//
//  Created by Simran on 4/9/21.
//
import Foundation
import SwiftyJSON
import Alamofire

public class MedLog: NSObject, NSCoding {
    var DATE: String!
    var ENTRY: String!
    
    init(_ date: String, entry: String){
        self.DATE       = date
        self.ENTRY     = entry
    }
    
    public required init(coder decoder: NSCoder) {
        DATE       = decoder.decodeObject(forKey: "DATE") as? String
        ENTRY     = decoder.decodeObject(forKey: "ENTRY") as? String
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(self.DATE,       forKey: "DATE")
        coder.encode(self.ENTRY,     forKey: "ENTRY")
    }
}
