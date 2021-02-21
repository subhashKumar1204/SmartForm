//
//  OtherButtonCell.swift
//  SmartForm
//
//  Created by SUBHASH KUMAR on 15/02/21.
//

import UIKit
//MARK:- View Model
struct OtherButtonCellViewModel {
    
    var cellType : String = ""
    var title : String = ""
    var cellObject : [String : Any]?
    var viewIndex : IndexPath?
    var isBtnSelected : Bool?
    var fieldText : String?
    
    //    title
    init(with model:DashbordFormModel,viewIndex:IndexPath?,isBtnSelected:Bool = false,fieldText:String = "") {
        cellType = model.cellType
        title = model.title
        cellObject = model.cellObject
        self.viewIndex = viewIndex
        self.isBtnSelected = isBtnSelected
        self.fieldText = fieldText
    }
    
}

struct CheckOtherButtonCellViewModel {
    
    var cellType : String = ""
    var title : String = ""
    var cellObject : [String : Any]?
    var viewIndex : IndexPath?
    var isBtnSelected : Bool?
    var fieldText : String?
    
    //    title
    init(with model:DashbordFormModel,viewIndex:IndexPath?,isBtnSelected:Bool = false,fieldText:String = "") {
        cellType = model.cellType
        title = model.title
        cellObject = model.cellObject
        self.viewIndex = viewIndex
        self.isBtnSelected = isBtnSelected
        self.fieldText = fieldText
    }
    
}

//MARK:- Cell
class OtherButtonCell: UITableViewCell {
    
    static let identifier =  "OtherButtonCell"
    private var viewModel : OtherButtonCellViewModel?
    var dict : GenderOptionsModel?
    var multi_dict : MultipleOptionsModel?

    var updtDSFormModel:DashbordFormModel?
    var buttonDelegate : CellProtocol?
    private var checkViewModel : CheckOtherButtonCellViewModel?
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
    
    let otherField:UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = UIKeyboardType.default
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.backgroundColor = .white
        textField.borderStyle = UITextField.BorderStyle.bezel
        textField.returnKeyType = .done
        textField.isHidden = true
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(button)
        containerView.addSubview(otherField)
        
        
        self.contentView.addSubview(containerView)
        
        self.contentView.backgroundColor = AppColor.appBackgroundWhiteColor
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:1).isActive = true
        
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -1).isActive = true
        
        button.topAnchor.constraint(equalTo:self.containerView.topAnchor,constant: 10).isActive = true
        button.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor,constant: 10).isActive = true
        button.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        button.widthAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor,constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.button.trailingAnchor,constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor,constant: -5).isActive = true
        
        otherField.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor,constant: 10).isActive = true
        
        otherField.leadingAnchor.constraint(equalTo:self.button.trailingAnchor,constant: 10).isActive = true
        otherField.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor,constant: -5).isActive = true
        otherField.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor,constant: -0).isActive = true
        otherField.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureWithViewModel(with viewModel:OtherButtonCellViewModel, option : GenderOptionsModel?,updatedDSFormModel:DashbordFormModel?){
        self.viewModel = viewModel
        self.dict = option
       
        
        self.titleLabel.text = option?.genderType
        self.updtDSFormModel = updatedDSFormModel
     
        if updatedDSFormModel?.options.count ?? 0 > 0 {
            let row = (viewModel.viewIndex?.row ?? 0) - 1
            self.viewModel?.isBtnSelected = updatedDSFormModel?.options[row].isGenderSelected ?? false
        }
        if self.viewModel?.isBtnSelected == true{
            self.button.setImage(#imageLiteral(resourceName: "selected"), for: .normal)
            self.otherField.addTarget(self, action: #selector(textFieldDidEndEditing(_ :)), for: .editingDidEnd)
            otherField.isHidden = false

        }else{
            self.button.setImage(#imageLiteral(resourceName: "unselected"), for: .normal)
            self.otherField.text = viewModel.fieldText
            otherField.isHidden = true

        }
        let tag = viewModel.viewIndex?.row
        otherField.tag = (tag ?? 0) - 1
        self.button.tag =  (tag ?? 0) - 1
        self.button.addTarget(self, action: #selector(isRadioButtonClicked(_ :)), for: .touchUpInside)
    }
   
    
    @objc func isRadioButtonClicked(_ sender : UIButton){
        
        guard let viewModel = viewModel else {
            return
        }
        let newViewModel = viewModel //// this is struct  its not a reference type its a value type
//        newViewModel.isBtnSelected = !(viewModel.isBtnSelected ?? false)
        prepareForReuse()
        var othoptions : [GenderOptionsModel] = []
        for item in 0..<(self.updtDSFormModel?.options ?? []).count{
            let model = self.updtDSFormModel?.options[item]
            let tag = (viewModel.viewIndex?.row ?? 0) - 1
            if tag == item{
                model?.isGenderSelected = true
            }else{
                model?.isGenderSelected = false
            }
            othoptions.append(model!)
        }
        self.updtDSFormModel?.options.removeAll()
        self.updtDSFormModel?.options = othoptions
        buttonDelegate?.radioButtomOtherTableViewCell(self, didtapWith: newViewModel, updatedDSFormModel: self.updtDSFormModel!)
        configureWithViewModel(with: newViewModel, option: self.dict, updatedDSFormModel: updtDSFormModel)
       
    }
    
    
    
    func configureMultipleWithViewModel(with viewModel:CheckOtherButtonCellViewModel, option : MultipleOptionsModel?,updatedDSFormModel:DashbordFormModel?){
        self.checkViewModel = viewModel
        self.multi_dict = option
       
        
        self.titleLabel.text = option?.genderType
        self.updtDSFormModel = updatedDSFormModel
     
        
        if updatedDSFormModel?.options.count ?? 0 > 0 {
            let row = (viewModel.viewIndex?.row ?? 0) - 1
            self.checkViewModel?.isBtnSelected = updatedDSFormModel?.options[row].isGenderSelected ?? false
        }
        
        if self.checkViewModel?.isBtnSelected == true{
            self.button.setImage(#imageLiteral(resourceName: "selected"), for: .normal)
            self.otherField.addTarget(self, action: #selector(textFieldDidEndEditing(_ :)), for: .editingDidEnd)
            otherField.isHidden = false

        }else{
            self.button.setImage(#imageLiteral(resourceName: "unselected"), for: .normal)
            self.otherField.text = viewModel.fieldText
            otherField.isHidden = true

        }
        otherField.tag = (tag ) - 1
        let tag = viewModel.viewIndex?.row
        self.button.tag =  (tag ?? 0) - 1
        self.button.addTarget(self, action: #selector(isCheckMultipleButtonClicked(_ :)), for: .touchUpInside)
    }
   
    
    @objc func isCheckMultipleButtonClicked(_ sender : UIButton){
        
        guard let viewModel = checkViewModel else {
            return
        }
        var newViewModel = viewModel //// this is struct  its not a reference type its a value type
        newViewModel.isBtnSelected = !(viewModel.isBtnSelected ?? false)
        self.updtDSFormModel?.rowValue = self.dict?.genderType ?? ""
        updtDSFormModel?.options[sender.tag].isGenderSelected = newViewModel.isBtnSelected ?? false
       
        if  newViewModel.isBtnSelected == true{
            updtDSFormModel?.rowValues.insert(self.dict?.genderType ?? "", at: sender.tag)
            updtDSFormModel?.rowValue = viewModel.fieldText ?? ""
        }else{
            if (self.updtDSFormModel?.rowValues.count ?? 0)>0{
                self.updtDSFormModel?.rowValues.remove(at: sender.tag )
            }

        }
        
        prepareForReuse()
        
        buttonDelegate?.CheckButtomOtherTableViewCell(self, didtapWith: newViewModel, updatedDSFormModel: self.updtDSFormModel!)
        configureMultipleWithViewModel(with: newViewModel, option: self.multi_dict, updatedDSFormModel: updtDSFormModel)
       
    }
    
    
    @objc func textFieldDidEndEditing(_ textField : UITextField){
       
        
        guard let viewModel = viewModel else {
            return
        }
        var newViewModel = viewModel //// this is struct  its not a reference type its a value type
       
        if newViewModel.isBtnSelected == true{
            self.otherField.isHidden = false
            newViewModel.fieldText = textField.text ?? ""
            self.updtDSFormModel?.rowValue = newViewModel.fieldText ?? ""
            buttonDelegate?.radioButtomOtherTableViewCell(self, didtapWith: newViewModel, updatedDSFormModel: self.updtDSFormModel!)
        }else{
            newViewModel.fieldText = ""
            self.updtDSFormModel?.rowValue = ""
            self.otherField.isHidden = true
            buttonDelegate?.radioButtomOtherTableViewCell(self, didtapWith: newViewModel, updatedDSFormModel: self.updtDSFormModel!)
            
        }
        
        prepareForReuse()
        configureWithViewModel(with: newViewModel, option: self.dict, updatedDSFormModel: updtDSFormModel)
        
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
       
        titleLabel.text = nil
        button.backgroundColor = nil
        button.layer.borderWidth = 0
        button.setTitle(nil, for: .normal)
        
        
    }
}
