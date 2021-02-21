//
//  TitleSubTitleCell.swift
//  SmartForm
//
//  Created by SUBHASH KUMAR on 15/02/21.
//

import UIKit

//MARK:- View Model
struct TitleSubTitleCellViewModel {
    
    var cellType : String = ""
    var title : String = ""
    var cellObject : [String : Any]?

    //    title
    init(with model:DashbordFormModel) {
        cellType = model.cellType
        title = model.title
        cellObject = model.cellObject

    }
    
}

//MARK:- Cell


class TitleSubTitleCell: UITableViewCell {
    
    static let identifier =  "TitleSubTitleCell"
    private var viewModel : TitleSubTitleCellViewModel?
    
    
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
    
    let subTitleLabel:UILabel = {
        let label = UILabel()
        label.font = AppFonts.appTitleFont()
        label.textColor = AppColor.TextColors.subTitle
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
        containerView.addSubview(subTitleLabel)
        
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
        
        subTitleLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor,constant: 10).isActive = true
        
        subTitleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor,constant: 5).isActive = true
        subTitleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor,constant: -5).isActive = true
        subTitleLabel.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor,constant: -20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func configureWithViewModel(with viewModel:TitleSubTitleCellViewModel){
        self.viewModel = viewModel
        if viewModel.cellType == "disclamer" {
            self.titleLabel.text = "Disclamer:"
            self.subTitleLabel.text = viewModel.title
            self.subTitleLabel.textAlignment = .justified
            self.subTitleLabel.font = AppFonts.customFont(fontSize: 11)
        }
        
    }
    
}
