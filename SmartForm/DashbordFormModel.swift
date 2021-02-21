//
//  DashbordFormModel.swift
//  SmartForm
//
//  Created by SUBHASH KUMAR on 14/02/21.
//

import Foundation

class DashbordFormModel {
    var cellType : String = ""
    var title : String = ""
    var cellObject : [String : Any]?
    var options = [GenderOptionsModel]()
    var multi_options = [MultipleOptionsModel]()

    var rowValue : String = ""
    var rowValues : [String] = []

    
    
}
class GenderOptionsModel {
    var genderType : String = ""
    var isGenderSelected : Bool = false
    var inputType : String = ""
    var cellObject : Dictionary<String,AnyObject> = [:]
    
    convenience init(_ response : AnyObject) {
        self.init()
        
        self.genderType = response["object"] as? String ?? ""
        self.inputType = response["inputType"] as? String ?? ""
        self.cellObject = response["cellObject"] as? Dictionary<String,AnyObject> ?? [:]
         
    }
    
}


class MultipleOptionsModel {
    var genderType : String = ""
    var isGenderSelected : Bool = false
    var inputType : String = ""
    var cellObject : Dictionary<String,AnyObject> = [:]
    
    convenience init(_ response : AnyObject) {
        self.init()
        
        self.genderType = response["object"] as? String ?? ""
        self.inputType = response["inputType"] as? String ?? ""
        self.cellObject = response["cellObject"] as? Dictionary<String,AnyObject> ?? [:]
         
    }
    
}
