//
//  RadioButtomCell.swift
//  SmartForm
//
//  Created by SUBHASH KUMAR on 15/02/21.
//

import UIKit

//MARK:- View Model
struct RadioButtomCellViewModel {
    
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


//MARK:- Cell

class RadioButtomCell: UITableViewCell {
    
    static let identifier =  "RadioButtomCell"
    private var viewModel : RadioButtomCellViewModel?
    var buttonDelegate : CellProtocol?
    var dict : GenderOptionsModel?
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
    
    
    func configureWithViewModel(with viewModel:RadioButtomCellViewModel, option : GenderOptionsModel?, updatedDSFormModel: DashbordFormModel?){
        self.viewModel = viewModel
        self.dict = option
        self.titleLabel.text = option?.genderType as? String ?? ""
        self.updtDSFormModel?.rowValues = []
        self.updtDSFormModel = updatedDSFormModel
        if updatedDSFormModel?.options.count ?? 0 > 0 {
            let row = (viewModel.viewIndex?.row ?? 0) - 1
            self.viewModel?.isBtnSelected = updatedDSFormModel?.options[row].isGenderSelected ?? false
        }
       
        if self.viewModel?.isBtnSelected == true{
            self.button.setImage(#imageLiteral(resourceName: "selected"), for: .normal)
        }else{
            self.button.setImage(#imageLiteral(resourceName: "unselected"), for: .normal)
        }
        self.button.addTarget(self, action: #selector(isRadioButtonClicked(_ :)), for: .touchUpInside)
        let tag = viewModel.viewIndex?.row
        self.button.tag =  (tag ?? 0) - 1
    }
    
    @objc func isRadioButtonClicked(_ sender : UIButton){
        
       
        guard let viewModel = viewModel else {
            return
        }
        
        var newViewModel = viewModel //// this is struct  its not a reference type its a value type
//        newViewModel.isBtnSelected = !(viewModel.isBtnSelected ?? false)
        
//        buttonDelegate?.radioButtomTableViewCell(self, didtapWith: newViewModel)
        var othoptions : [GenderOptionsModel] = []
       
        for item in 0..<(self.updtDSFormModel?.options ?? []).count{
            let model = self.updtDSFormModel?.options[item]
            let tag = (viewModel.viewIndex?.row ?? 0) - 1
            if tag == item{
                model?.isGenderSelected = true
                self.updtDSFormModel?.rowValue = self.dict?.genderType ?? ""
             
            }else{
                model?.isGenderSelected = false
            }
            othoptions.append(model!)
        }
       
        self.updtDSFormModel?.options.removeAll()
        self.updtDSFormModel?.options = othoptions
        
        prepareForReuse()
        buttonDelegate?.radioButtomTableViewCell(self, didtapWith: newViewModel, updatedDSFormModel: self.updtDSFormModel!)
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
