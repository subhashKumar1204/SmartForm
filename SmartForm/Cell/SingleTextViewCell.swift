//
//  SingleTextViewCell.swift
//  SmartForm
//
//  Created by SUBHASH KUMAR on 15/02/21.
//

import UIKit

import UIKit
//MARK:- View Model
struct SingleTextViewCellViewModel {
    
    var cellType : String = ""
    var title : String = ""
    var cellObject : [String : Any]?

    init(with model:DashbordFormModel) {
        cellType = model.cellType
        title = model.title
        cellObject = model.cellObject

    }
    
}

//MARK:- Cell

class SingleTextViewCell: UITableViewCell {
    
    static let identifier =  "SingleTextViewCell"
    private var viewModel : SingleTextViewCellViewModel?
    
    
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
    
    let firstTextView:UITextView = {
        let textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.keyboardType = UIKeyboardType.default
        textview.returnKeyType = UIReturnKeyType.done
        textview.autocorrectionType = UITextAutocorrectionType.no
        textview.font = UIFont.systemFont(ofSize: 13)
        textview.layer.borderWidth = 0.5
        textview.layer.borderColor = UIColor.gray.cgColor

        textview.backgroundColor = .white
        return textview
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(firstTextView)
        
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
        
        firstTextView.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor,constant: 10).isActive = true
        
        firstTextView.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor,constant: 5).isActive = true
        firstTextView.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor,constant: -5).isActive = true
        firstTextView.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor,constant: -20).isActive = true
        firstTextView.heightAnchor.constraint(equalToConstant: CGFloat(60)).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func configureWithViewModel(with viewModel:SingleTextViewCellViewModel){
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.title
        self.firstTextView.text = "Testing"//viewModel.cellType
        
    }
    
    
    
}
