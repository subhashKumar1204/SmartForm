//
//  DashboardViewModel.swift
//  SmartForm
//
//  Created by SUBHASH KUMAR on 16/02/21.
//

import Foundation
import UIKit

class DashboardViewModel {

    var dataDict : JSONDictionary = [:]
    var dashbordFormArray : [DashbordFormModel] = []

    
    func fetchFormData() {
        dataDict =  Parser.loadJson(fileName: "SmartForm", key: "dashboard")
        self.dashbordFormArray.removeAll()
        self.dashbordFormArray = self.fetchSmartFormList(dict: dataDict)
        
    }
    
    func fetchSmartFormList(dict : JSONDictionary) -> [DashbordFormModel] {
       
        print(dict)
        var formArray : [DashbordFormModel] = []
        let list = dict["smartOptions"] as? [JSONDictionary] ?? []
        for item in list {
            let model = DashbordFormModel()
            model.cellType = item["cellType"] as? String ?? ""
            model.title = item["title"] as? String ?? ""
            model.cellObject = item["cellObject"] as? JSONDictionary
            
            if model.cellType == "singleSelection" {
                let optionArr = item["options"] as? [JSONDictionary]
                if optionArr?.count ?? 0 > 0 {
                    model.options.removeAll()
                }
                for item1 in optionArr ?? [] {
                    model.options.append(GenderOptionsModel(item1 as AnyObject))
                    
                }
            }else if model.cellType == "multipleSelection" {
                let optionArr = item["options"] as? [JSONDictionary]
                if optionArr?.count ?? 0 > 0 {
                    model.multi_options.removeAll()
                }
                for item1 in optionArr ?? [] {
                    model.multi_options.append(MultipleOptionsModel(item1 as AnyObject))
                    
                }
            }
           
            
            formArray.append(model)
        }
        return formArray
    }
  
}


