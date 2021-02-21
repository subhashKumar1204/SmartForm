//
//  SingleFieldCell.swift
//  SmartForm
//
//  Created by SUBHASH KUMAR on 15/02/21.
//

import UIKit
//MARK:- View Model
struct SingleFieldCellViewModel {
    
    var cellType : String = ""
    var title : String = ""
    var cellObject : [String : Any]?
    var rowValue : String = ""

    init(with model:DashbordFormModel) {
        cellType = model.cellType
        title = model.title
        cellObject = model.cellObject
        rowValue = model.rowValue
    }
    
}

//MARK:- Cell

class SingleFieldCell: UITableViewCell {
    
    static let identifier =  "SingleFieldCell"
    private var viewModel : SingleFieldCellViewModel?
    var fieldDelegate : CellProtocol?
    var setIndexPath : IndexPath?
    let containerView:UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.appBackgroundWhiteColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
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
    
    let firstField:UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.backgroundColor = .white
        textField.borderStyle = UITextField.BorderStyle.bezel
        return textField
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(firstField)
        
        self.contentView.addSubview(containerView)
        
        self.contentView.backgroundColor = AppColor.appBackgroundWhiteColor
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:10).isActive = true
        
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -10).isActive = true
        
        
        titleLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor,constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor,constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor,constant: -5).isActive = true
        
        firstField.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor,constant: 10).isActive = true
        
        firstField.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor,constant: 5).isActive = true
        firstField.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor,constant: -5).isActive = true
        firstField.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor,constant: -20).isActive = true
        firstField.heightAnchor.constraint(equalToConstant: CGFloat(40)).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func configureWithViewModel(with viewModel:SingleFieldCellViewModel,indexpath:IndexPath){
        self.viewModel = viewModel
        self.setIndexPath = indexpath
        self.titleLabel.text = viewModel.title
        self.firstField.text = viewModel.rowValue
        self.firstField.tag = indexpath.row
        self.firstField.addTarget(self, action: #selector(textFieldDidEndEditing(_ :)), for: .editingDidEnd)
    }
    
    
    @objc func textFieldDidEndEditing(_ textField : UITextField){
        guard let indexPath = self.setIndexPath else { return }
        fieldDelegate?.GetTextFieldData(indexPath:  indexPath, object: textField.text ?? "")
        
    }
    
}
