//
//  Parser.swift
//  SmartForm
//
//  Created by SUBHASH KUMAR on 14/02/21.
//

import UIKit

class Parser {

    class func loadJson(fileName: String,key:String) -> Dictionary<String,AnyObject> {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let dictionary = object as? [String: AnyObject] {
                    let object = dictionary[key] as? Dictionary<String,AnyObject> ?? [:]
                    return object
                }
            } catch {
            //    PrintClass("Error!! Unable to parse  \(fileName).json")
            }
        }
        return [:]
    }
    
    
}
