//
//  Extensions.swift
//  News
//
//  Created by Pedro Capela on 28/05/2021.
//

import Foundation

extension String{
    func localized() -> String{
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
    
    func getEnumDoneItem() -> DoneItemList{
        if self == "done" {
            return DoneItemList.done
        }else if self == "toDo" {
            return DoneItemList.toDo
        }else{
            return DoneItemList.inProgress
        }
    }
    
    func fromPresentationStringToDone() -> DoneItemList{
        if self == "Done".localized(){
            return DoneItemList.done
        }else if self == "To-do".localized(){
            return DoneItemList.toDo
        }else{
            return DoneItemList.inProgress
        }
    }
}
