//
//  ProtocolClass.swift
//  SmartForm
//
//  Created by SUBHASH KUMAR on 17/02/21.
//

import Foundation

protocol CellProtocol {
    func GetTextFieldData(indexPath:IndexPath,object:Any)->Void
    func GetTextViewData(indexPath:IndexPath,object:Any)->Void
    func GetButtonAction(indexPath:IndexPath,object:Any)->Void
    func radioButtomTableViewCell(_ cell : RadioButtomCell,didtapWith viewModel:RadioButtomCellViewModel,updatedDSFormModel: DashbordFormModel)
    func radioButtomOtherTableViewCell(_ cell : OtherButtonCell,didtapWith viewModel:OtherButtonCellViewModel,updatedDSFormModel: DashbordFormModel)
    func CheckButtomOtherTableViewCell(_ cell : OtherButtonCell,didtapWith viewModel:CheckOtherButtonCellViewModel,updatedDSFormModel: DashbordFormModel)
    func CheckButtomTableViewCell(_ cell : CheckButtomCell,didtapWith viewModel:CheckButtomCellViewModel,updatedDSFormModel: DashbordFormModel)
    func SingleButtonTableViewCell(_ cell : SingleButtonCell,didtapWith viewModel:SingleButtonCellViewModel,updatedDSFormModel: DashbordFormModel)
    
}

extension CellProtocol{
    func GetTextFieldData(indexPath:IndexPath,object:Any)->Void{ }
    func GetTextViewData(indexPath:IndexPath,object:Any)->Void{ }
    func GetButtonAction(indexPath:IndexPath,object:Any)->Void{ }
    func radioButtomTableViewCell(_ cell : RadioButtomCell,didtapWith viewModel:RadioButtomCellViewModel)->Void { }
    func radioButtomOtherTableViewCell(_ cell : OtherButtonCell,didtapWith viewModel:OtherButtonCellViewModel)->Void { }
    func CheckButtomOtherTableViewCell(_ cell : OtherButtonCell,didtapWith viewModel:CheckOtherButtonCellViewModel,updatedDSFormModel: DashbordFormModel)->Void { }
    func CheckButtomTableViewCell(_ cell : CheckButtomCell,didtapWith viewModel:CheckButtomCellViewModel,updatedDSFormModel: DashbordFormModel)->Void { }
    func SingleButtonTableViewCell(_ cell : SingleButtonCell,didtapWith viewModel:SingleButtonCellViewModel,updatedDSFormModel: DashbordFormModel) -> Void { }
    
}
