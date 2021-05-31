//
//  FeaturedViewController.swift
//  News
//
//  Created by Pedro Capela on 31/05/2021.
//

import UIKit
import CoreData

class FeaturedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewToDo: UITableView!
    
    var items: [ItemList]? = []
    
    private var managedObjectContext: NSManagedObjectContext?{
        didSet{
            if let context = managedObjectContext{
                let itemsLoaded = ItemList.getAllItems(inManagedObjectContext: context)
                items = itemsLoaded
                
                DispatchQueue.main.async {
                    self.tableViewToDo.reloadData()
                }
            }
            
        }
    }
    private var appDelegate : AppDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Featured".localized()
        self.tableViewToDo.delegate = self
        self.tableViewToDo.dataSource = self
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.managedObjectContext = appDelegate?.persistentContainer.viewContext
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelForTodo", for: indexPath) as! ToDoListCell
        
        let item = self.items?[indexPath.row]
        
        cell.itemNameLabel.text = item?.name ?? ""
        cell.itemStateLabel.text = item?.done?.getEnumDoneItem().getPresentationString()
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ItemToDoViewController {
           if let indexPath = self.tableViewToDo.indexPathForSelectedRow{
                vc.isAdd = false
                vc.id = self.items?[indexPath.row].id ?? ""
                vc.callBackUpdate = {
                    let itemsLoaded = ItemList.getAllItems(inManagedObjectContext: self.managedObjectContext!)
                    self.items = itemsLoaded
                    
                    DispatchQueue.main.async {
                        self.tableViewToDo.reloadData()
                    }
                }
           }
        }
    }
    

}


class ToDoListCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemStateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
