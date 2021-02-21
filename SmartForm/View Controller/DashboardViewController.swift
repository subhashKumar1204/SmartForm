//
//  DashboardViewController.swift
//  SmartForm
//
//  Created by SUBHASH KUMAR on 14/02/21.
//

import UIKit

// Dashboard View
class DashboardViewController: BaseViewController,CellProtocol {
    

    
    private var viewModel: DashboardViewModel?
    
    private let dashboardTableView: UITableView = {
        let tableVw = UITableView()
        tableVw.register(PageTitleCell.self, forCellReuseIdentifier: PageTitleCell.identifier)
        tableVw.register(SingleFieldCell.self, forCellReuseIdentifier: SingleFieldCell.identifier)
        tableVw.register(TitleSubTitleCell.self, forCellReuseIdentifier: TitleSubTitleCell.identifier)
        tableVw.register(RadioButtomCell.self, forCellReuseIdentifier: RadioButtomCell.identifier)
        tableVw.register(SingleTextViewCell.self, forCellReuseIdentifier: SingleTextViewCell.identifier)
       
        tableVw.register(OtherButtonCell.self, forCellReuseIdentifier: OtherButtonCell.identifier)
        tableVw.register(CheckButtomCell.self, forCellReuseIdentifier: CheckButtomCell.identifier)

        
        tableVw.register(SingleButtonCell.self, forCellReuseIdentifier: SingleButtonCell.identifier)
        
        //textView
        
        return tableVw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Survey Form"
        self.setUpTableView()
        self.viewModel = DashboardViewModel()
        self.viewModel?.fetchFormData()
        
        self.dashboardTableView.reloadData()
    }

    
    
    func setUpTableView() {
        
        view.addSubview(dashboardTableView)
        dashboardTableView.translatesAutoresizingMaskIntoConstraints = false
        dashboardTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        dashboardTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        dashboardTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        dashboardTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        dashboardTableView.dataSource = self
        dashboardTableView.delegate = self
        dashboardTableView.tableFooterView = UIView(frame: CGRect.zero)
        dashboardTableView.rowHeight = UITableView.automaticDimension
        dashboardTableView.backgroundColor = .white
        dashboardTableView.separatorStyle = .none
    }
    
    
}


extension DashboardViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModel?.dashbordFormArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let pgmodelView = self.viewModel?.dashbordFormArray[section] {
            if pgmodelView.cellType == "singleSelection" {

                print(pgmodelView)
                let row = pgmodelView.options.count
                return row + 1
            }else if pgmodelView.cellType == "multipleSelection" {
                
                print(pgmodelView)
                let row = pgmodelView.multi_options.count
                return row + 1
            }
            
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PageTitleCell.identifier, for: indexPath) as? PageTitleCell else{
            return UITableViewCell()
        }
        
        
        
        if let pgmodelView = self.viewModel?.dashbordFormArray[indexPath.section] {
            
            if pgmodelView.cellType == "PageTitle" {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PageTitleCell.identifier, for: indexPath) as? PageTitleCell else{
                    return UITableViewCell()
                }
                
                let pagetitleModelView = PageTitleCellViewModel(with: pgmodelView)
                cell.configureWithViewModel(with: pagetitleModelView)
                return cell
            }
            else if pgmodelView.cellType == "textField" {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SingleFieldCell.identifier, for: indexPath) as? SingleFieldCell else{
                    return UITableViewCell()
                }
                
                let singleFieldModelView = SingleFieldCellViewModel(with: pgmodelView)
                cell.fieldDelegate = self
                cell.configureWithViewModel(with: singleFieldModelView, indexpath: indexPath)

                return cell
            }
            
            else if pgmodelView.cellType == "TitleSubTitle" ||  pgmodelView.cellType ==  "disclamer" {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleSubTitleCell.identifier, for: indexPath) as? TitleSubTitleCell else{
                    return UITableViewCell()
                }
                
                let titleSubTitleModelView = TitleSubTitleCellViewModel(with: pgmodelView)
                cell.configureWithViewModel(with: titleSubTitleModelView)

                return cell
            }
            else if pgmodelView.cellType == "textView" {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SingleTextViewCell.identifier, for: indexPath) as? SingleTextViewCell else{
                    return UITableViewCell()
                }
                
                let titleTextViewModelView = SingleTextViewCellViewModel(with: pgmodelView)
                cell.configureWithViewModel(with: titleTextViewModelView)

                return cell
            }
            else if pgmodelView.cellType == "singleSelection" {
                
                if indexPath.row == 0 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: PageTitleCell.identifier, for: indexPath) as? PageTitleCell else{
                        return UITableViewCell()
                    }
                    
                    let pagetitleModelView = PageTitleCellViewModel(with: pgmodelView)
                    cell.configureWithViewModel(with: pagetitleModelView)
                    
                    return cell
                }else {
                    let objects = (pgmodelView.options ?? []) as [GenderOptionsModel]
                    if objects.count > 0 {
                        let row = indexPath.row
                        let dict = objects[row - 1] as GenderOptionsModel

                        if (dict.genderType == "Other") {
                            guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherButtonCell.identifier, for: indexPath) as? OtherButtonCell else{
                                return UITableViewCell()
                            }
                            
                            
                            let otherButtonView = OtherButtonCellViewModel(with: pgmodelView,viewIndex: indexPath)
                            cell.buttonDelegate = self
                            cell.configureWithViewModel(with: otherButtonView, option: dict, updatedDSFormModel: pgmodelView)

                            return cell
                        }else{
                            guard let cell = tableView.dequeueReusableCell(withIdentifier: RadioButtomCell.identifier, for: indexPath) as? RadioButtomCell else{
                                return UITableViewCell()
                            }
                            
                            
                            var radioModelView = RadioButtomCellViewModel(with: pgmodelView,viewIndex: indexPath)
                            radioModelView.viewIndex = indexPath
                            cell.configureWithViewModel(with: radioModelView, option: dict, updatedDSFormModel: pgmodelView)
                            cell.buttonDelegate = self
                            return cell
                        }
                    }
                    
                   
               
                }
                
            }else if pgmodelView.cellType == "multipleSelection" {
                
                if indexPath.row == 0 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: PageTitleCell.identifier, for: indexPath) as? PageTitleCell else{
                        return UITableViewCell()
                    }
                    
                    let pagetitleModelView = PageTitleCellViewModel(with: pgmodelView)
                    cell.configureWithViewModel(with: pagetitleModelView)
                    
                    return cell
                }else {
                    let objects = (pgmodelView.multi_options ?? []) as [MultipleOptionsModel]
                    if objects.count > 0 {
                        let row = indexPath.row
                        let dict = objects[row - 1] as MultipleOptionsModel

                        if (dict.genderType == "Other") {
                            guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherButtonCell.identifier, for: indexPath) as? OtherButtonCell else{
                                return UITableViewCell()
                            }
                            
                            
                            let otherButtonView = CheckOtherButtonCellViewModel(with: pgmodelView,viewIndex: indexPath)
                            cell.buttonDelegate = self
                            cell.configureMultipleWithViewModel(with: otherButtonView, option: dict, updatedDSFormModel: pgmodelView)

                            return cell
                        }else{
                            guard let cell = tableView.dequeueReusableCell(withIdentifier: CheckButtomCell.identifier, for: indexPath) as? CheckButtomCell else{
                                return UITableViewCell()
                            }
                            
                            
                            var radioModelView = CheckButtomCellViewModel(with: pgmodelView,viewIndex: indexPath)
                            radioModelView.viewIndex = indexPath
                            cell.configureMultipleWithViewModel(with: radioModelView, option: dict, updatedDSFormModel: pgmodelView)
                            cell.buttonDelegate = self
                            return cell
                        }
                    }
                    
                   
               
                }
                
            }
            else if pgmodelView.cellType == "button" {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SmartForm.SingleButtonCell.identifier, for: indexPath) as? SingleButtonCell else{
                    return UITableViewCell()
                }
                
                let singleButtonViewModelView = SingleButtonCellViewModel(with: pgmodelView, viewIndex: indexPath)
                cell.singleBtnDelegate = self
                cell.configureWithViewModel(with: singleButtonViewModelView, formViewModel: pgmodelView)

                return cell
            }
            
            

        }
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func GetButtonAction(indexPath: IndexPath, object: Any) {
        print(indexPath,object)
    }
    func GetTextFieldData(indexPath: IndexPath, object: Any) {
        print(indexPath,object)
        let model =  viewModel?.dashbordFormArray[indexPath.section]
        model?.rowValue = object as? String ?? ""
        dashboardTableView.reloadSections([indexPath.section ], with: .automatic)

    }
   
    func radioButtomTableViewCell(_ cell: RadioButtomCell, didtapWith viewModel: RadioButtomCellViewModel, updatedDSFormModel: DashbordFormModel) {
        dashboardTableView.reloadSections([viewModel.viewIndex?.section ?? 0], with: .automatic)
    }
    func radioButtomOtherTableViewCell(_ cell: OtherButtonCell, didtapWith viewModel: OtherButtonCellViewModel, updatedDSFormModel: DashbordFormModel) {
        dashboardTableView.reloadSections([viewModel.viewIndex?.section ?? 0], with: .automatic)
    }
    
    func CheckButtomTableViewCell(_ cell: RadioButtomCell, didtapWith viewModel: CheckButtomCellViewModel, updatedDSFormModel: DashbordFormModel) {
        dashboardTableView.reloadRows(at: [viewModel.viewIndex!], with: .automatic)
    }
    func CheckButtomOtherTableViewCell(_ cell: OtherButtonCell, didtapWith viewModel: CheckOtherButtonCellViewModel, updatedDSFormModel: DashbordFormModel) {
        dashboardTableView.reloadRows(at: [viewModel.viewIndex!], with: .automatic)
    }
    
    func SingleButtonTableViewCell(_ cell: SingleButtonCell, didtapWith viewModel: SingleButtonCellViewModel, updatedDSFormModel: DashbordFormModel) {
        //let model = viewModel as DashbordFormModel
        let dataArr =  self.viewModel?.dashbordFormArray as? [DashbordFormModel] ?? []
        var dataDict : Dictionary<String,AnyObject> = [:]
        for item in dataArr {
            if item.rowValues.count>0{
                dataDict[item.title] = "\(item.rowValues as [String] ?? [])" as AnyObject
            }else{
            dataDict[item.title] = "\(item.rowValue as String ?? "")" as AnyObject
            }
            
        }
        
        
        print(dataDict.description)
   
        self.displayAlert(msg: dataDict.description, title: "User Information")
    }
}
