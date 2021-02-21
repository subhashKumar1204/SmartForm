//
//  PageTitleCell.swift
//  SmartForm
//
//  Created by SUBHASH KUMAR on 15/02/21.
//

import UIKit

//MARK:- View Model
struct PageTitleCellViewModel {
    
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
class PageTitleCell: UITableViewCell {
    
    static let identifier =  "PageTitleCell"
    private var viewModel : PageTitleCellViewModel?
    
    
    let containerView:UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.appBackgroundWhiteColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    //default property
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = AppFonts.headerFont()
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
        self.contentView.addSubview(containerView)
        self.contentView.backgroundColor = AppColor.appBackgroundWhiteColor
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:10).isActive = true
        
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -10).isActive = true
        
        containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(40)).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor,constant: -5).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func configureWithViewModel(with viewModel:PageTitleCellViewModel){
        
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.title
        
    }
    
}
