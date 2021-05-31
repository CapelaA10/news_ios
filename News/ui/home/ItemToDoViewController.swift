//
//  ItemToDoViewController.swift
//  News
//
//  Created by Pedro Capela on 31/05/2021.
//

import CoreData
import UIKit

class ItemToDoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var pickerState: UIPickerView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var buttonPickerHide: UIButton!
    
    var isAdd: Bool = true
    
    var id: String?
    var itemList: ItemList?
    var pickerStateSelected: String?
    var callBackUpdate: (() -> ())?
    
    private var managedObjectContext: NSManagedObjectContext?
    private var appDelegate : AppDelegate?
    private var pickerIsShowing: Bool = false
    
    private var pickerData = [DoneItemList.toDo.getPresentationString(), DoneItemList.done.getPresentationString(), DoneItemList.inProgress.getPresentationString()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.managedObjectContext = appDelegate?.persistentContainer.viewContext
        
        self.pickerState.delegate = self
        self.pickerState.dataSource = self
        
        if isAdd {
            title = "Add Item"
            pickerStateSelected = DoneItemList.toDo.getPresentationString()
            self.pickerState.isHidden = true
            self.stateLabel.isHidden = true
            self.deleteButton.isHidden = true
            self.buttonPickerHide.isHidden = true
            pickerIsShowing = false
        }else{
            title = "Update Item"
            if let fromDbItemList = ItemList.getItem(id: id!, inManagedObjectContext: self.managedObjectContext!){
                itemList = fromDbItemList
                nameLabel.text = itemList?.name
                descriptionLabel.text = itemList?.desc
                self.buttonPickerHide.setTitle(itemList?.done?.getEnumDoneItem().getPresentationString(), for: .normal)
                self.pickerState.isHidden = true
                pickerIsShowing = false
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showPicker(_ sender: Any) {
        if pickerIsShowing {
            self.buttonPickerHide.isHidden = false
            self.pickerState.isHidden = true
            pickerIsShowing = false
        }else{
            self.buttonPickerHide.isHidden = true
            self.pickerState.isHidden = false
            pickerIsShowing = true
        }
    }
    
    @IBAction func doneClick(_ sender: Any) {
        if isAdd {
            let name = nameLabel.text ?? ""
            let description = descriptionLabel.text ?? ""
            
            if name.isEmpty || description.isEmpty {
                //Alert error
                return
            }
            
            let itemAdded = ItemList.addItem(id: UUID().uuidString, name: name, desc: description, inManagedObjectContext: self.managedObjectContext!)
            
            if itemAdded == nil {
                //Alert error
                return
            }else{
                backToList()
            }

        }else{
            let name = nameLabel.text ?? ""
            let description = descriptionLabel.text ?? ""
            
            if name.isEmpty || description.isEmpty {
                //Alert error
                return
            }
            
            itemList?.name = name
            itemList?.desc = description
            itemList?.done = pickerStateSelected?.fromPresentationStringToDone().toString()
            
            let itemList = ItemList.updateItem(id: itemList?.id! ?? "", name: itemList?.name! ?? "", desc: itemList?.desc! ?? "", state: itemList?.done?.getEnumDoneItem() ?? DoneItemList.toDo, inManagedObjectContext: self.managedObjectContext!)
            
            if itemList != nil {
                backToList()
            }else{
                //Alert error
                return
            }
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        if let idSafe = self.id {
            let done = ItemList.removeItem(id: idSafe, inManagedObjectContext: self.managedObjectContext!)
            
            if done {
                backToList()
            }else{
                //Alert error
                return
            }
        }else{
            //Alert error
            return
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent  component: Int) {
        self.pickerStateSelected = pickerData[row] as String
    }
    
    func backToList(){
        appDelegate?.saveContext()
        callBackUpdate?()
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
