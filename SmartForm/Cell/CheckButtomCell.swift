//
//  CheckButtomCell.swift
//  SmartForm
//
//  Created by SUBHASH KUMAR on 21/02/21.
//

import UIKit

//MARK:- View Model
struct CheckButtomCellViewModel {
    
    var cellType : String = ""
    var title : String = ""
    var viewIndex : IndexPath?
    var isBtnSelected : Bool?
    var cellObject : [String : Any]?

    //    title
    init(with model:DashbordFormModel,viewIndex:IndexPath,isBtnSelected:Bool = false) {
        cellType = model.cellType
        title = model.title
        cellObject = model.cellObject
//        self.viewIndex = viewIndex
        self.isBtnSelected = isBtnSelected
    }
    
}


class CheckButtomCell: UITableViewCell {
    
    static let identifier =  "CheckButtomCell"
    private var checkViewModel : CheckButtomCellViewModel?
    var buttonDelegate : CellProtocol?
    var multiDict : MultipleOptionsModel?
    var updtDSFormModel:DashbordFormModel?
    
    
    let containerView:UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.appBackgroundWhiteColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    let button:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.layer.cornerRadius = 6.0
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.clear.cgColor
        return button
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = AppFonts.appTitleFont()
        label.textColor = AppColor.TextColors.title
        label.backgroundColor = AppColor.appBackgroundWhiteColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLinesCapability
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(button)
        
        self.contentView.addSubview(containerView)
        
        self.contentView.backgroundColor = AppColor.appBackgroundWhiteColor
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:1).isActive = true
        
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -1).isActive = true
        containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(50)).isActive = true
        
        button.topAnchor.constraint(equalTo:self.containerView.topAnchor,constant: 10).isActive = true
        button.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor,constant: 10).isActive = true
        button.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        button.widthAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor,constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.button.trailingAnchor,constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor,constant: -5).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor,constant: -10).isActive = true
        self.button.setImage(#imageLiteral(resourceName: "unselected"), for: .normal)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureMultipleWithViewModel(with viewModel:CheckButtomCellViewModel, option : MultipleOptionsModel?, updatedDSFormModel: DashbordFormModel?){
        self.checkViewModel = viewModel
        self.multiDict = option
        
        self.titleLabel.text = option?.genderType ?? ""
        let tag = viewModel.viewIndex?.row
        self.button.tag =  (tag ?? 0) - 1
        self.updtDSFormModel = updatedDSFormModel
        let row = (viewModel.viewIndex?.row ?? 0) - 1
        if updatedDSFormModel?.multi_options.count ?? 0 > 0 {
         
            self.checkViewModel?.isBtnSelected = updatedDSFormModel?.multi_options[row].isGenderSelected ?? false
        }
       
        if self.checkViewModel?.isBtnSelected == true{
            self.button.setImage(#imageLiteral(resourceName: "checkIcon"), for: .normal)
           
        }else{
            self.button.setImage(#imageLiteral(resourceName: "uncheckIcon"), for: .normal)
        }
        self.button.addTarget(self, action: #selector(isCheckMultipleButtonClicked(_ :)), for: .touchUpInside)
       
    }
    
    @objc func isCheckMultipleButtonClicked(_ sender : UIButton){
        
        
        guard let viewModel = checkViewModel else {
            return
        }
        
        var newViewModel = viewModel //// this is struct  its not a reference type its a value type
        newViewModel.isBtnSelected = !(viewModel.isBtnSelected ?? false)
        
        
        if  newViewModel.isBtnSelected == true{
//            self.updtDSFormModel?.rowValues.insert(self.multiDict?.genderType ?? "", at: sender.tag)
        }else{
            if (self.updtDSFormModel?.rowValues.count ?? 0)>0{
                self.updtDSFormModel?.rowValues.remove(at: sender.tag )
            }

        }
        
        updtDSFormModel?.multi_options[sender.tag].isGenderSelected = newViewModel.isBtnSelected ?? false
        prepareForReuse()
        
        buttonDelegate?.CheckButtomTableViewCell(self, didtapWith: newViewModel, updatedDSFormModel: self.updtDSFormModel!)
        configureMultipleWithViewModel(with: newViewModel, option: self.multiDict, updatedDSFormModel: updtDSFormModel)
        
        
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
       
        titleLabel.text = nil
        button.backgroundColor = nil
        button.layer.borderWidth = 0
        button.setTitle(nil, for: .normal)
        
        
    }
    
}

