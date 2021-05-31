//
//  Alerts.swift
//  News
//
//  Created by Pedro Capela on 31/05/2021.
//

import UIKit

func alertUserError(vc: UIViewController,error: String){
    let alert = UIAlertController(title: "Error".localized(), message: error, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in print("Dismised error")}))
    vc.present(alert, animated: true, completion: nil)
}
