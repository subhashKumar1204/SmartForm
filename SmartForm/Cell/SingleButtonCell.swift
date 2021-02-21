//
//  SingleButtonCell.swift
//  SmartForm
//
//  Created by SUBHASH KUMAR on 16/02/21.
//

import UIKit

//MARK:- View Model
struct SingleButtonCellViewModel {
    
    var cellType : String = ""
    var title : String = ""
    var cellObject : [String : Any]?
    var viewIndex : IndexPath?
    //    title
    init(with model:DashbordFormModel, viewIndex:IndexPath?) {
        cellType = model.cellType
        title = model.title
        cellObject = model.cellObject
        self.viewIndex = viewIndex

    }
    
}

//MARK:- Cell
class SingleButtonCell: UITableViewCell {
    
    static let identifier =  "SingleButtonCell"
    
    private var viewModel : SingleButtonCellViewModel?
    private var updtDSFormModel : DashbordFormModel?
    
    var singleBtnDelegate : CellProtocol?
    
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
        button.backgroundColor = AppColor.appThemeColor
        button.setTitleColor(.black, for: .normal)
        
        button.layer.cornerRadius = 6.0
        button.layer.borderWidth = 0.5
        button.layer.borderColor = AppColor.appThemeColor.cgColor
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.addSubview(button)
        self.contentView.addSubview(containerView)
        self.contentView.backgroundColor = AppColor.appBackgroundWhiteColor
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:10).isActive = true
        
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -10).isActive = true
        
        //        containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(40)).isActive = true
        
        button.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor,constant: -5).isActive = true
        containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(50)).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func configureWithViewModel(with viewModel:SingleButtonCellViewModel,formViewModel:DashbordFormModel){
        
        self.viewModel = viewModel
        self.updtDSFormModel = formViewModel
        self.button.setTitle(viewModel.title, for: .normal)
        let tag = viewModel.viewIndex?.row
        self.button.tag =  (tag ?? 0) - 1
       
        self.button.addTarget(self, action: #selector(isSubmitButtonClicked(_ :)), for: .touchUpInside)
       
    }
    
    
    
    @objc func isSubmitButtonClicked(_ sender : UIButton){
        
       
        guard let viewModel = viewModel else {
            return
        }
        
        let newViewModel = viewModel //// this is struct  its not a reference type its a value type
//        newViewModel.isBtnSelected = !(viewModel.isBtnSelected ?? false)
        
//        buttonDelegate?.radioButtomTableViewCell(self, didtapWith: newViewModel)
       // var othoptions : [GenderOptionsModel] = []
       
//        for item in 0..<(self.updtDSFormModel?.options ?? []).count{
//            let model = self.updtDSFormModel?.options[item]
//            let tag = (viewModel.viewIndex?.row ?? 0) - 1
//            if tag == item{
//                model?.isGenderSelected = true
//            }else{
//                model?.isGenderSelected = false
//            }
//            othoptions.append(model!)
//        }
      
        prepareForReuse()
        singleBtnDelegate?.SingleButtonTableViewCell(self, didtapWith: newViewModel, updatedDSFormModel: updtDSFormModel!)
        configureWithViewModel(with: newViewModel,formViewModel: updtDSFormModel!)
       
        
    }
    
    
}
