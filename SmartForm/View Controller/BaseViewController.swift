//
//  BaseViewController.swift
//  SmartForm
//
//  Created by SUBHASH KUMAR on 14/02/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColor.appBackgroundWhiteColor
        setUpNavigation()
    }
  
    //setting up the Navigation bar color
    func setUpNavigation() {
        self.navigationController?.navigationBar.barTintColor = AppColor.NavigationColors.navigationBarColors
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:AppColor.NavigationColors.navigationBarTitleColors]
    }
    
    
    func displayAlert(msg : Any, title : String?) {
        
        let otherAlert = UIAlertController(title: title ?? "Information ", message: msg as? String, preferredStyle: .alert)
        
        let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        otherAlert.addAction(dismiss)
        
        present(otherAlert, animated: true, completion: nil)
    }
}
