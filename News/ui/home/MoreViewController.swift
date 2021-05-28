//
//  MoreViewController.swift
//  News
//
//  Created by Pedro Capela on 26/05/2021.
//

import UIKit

struct Social{
    let link: URL
    let image: UIImage
    let title: String
}

class MoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableViewSocial: UITableView!
    @IBOutlet var labelDescriptionMore: UILabel!
    
    var socialList: [Social] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewSocial.delegate = self
        self.tableViewSocial.dataSource = self
        
        title = "More".localized()
        self.labelDescriptionMore.text = "This app was made to learn IOS and Swift development.\nThe code is public and anyone can use to practice.\nDown in the list, you will have all my available social networks.".localized()
        
        createSocialList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableViewSocial.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.socialList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelForMore", for: indexPath) as! SocialViewCell
        
        let social = self.socialList[indexPath.row]
        
        cell.titleSocial.text = social.title
        cell.socialImage.image = social.image
        
        return cell
    }
    
    private func createSocialList(){
        let uiImageLink: UIImage = UIImage(named: "link")!
        var uiImageMedium: UIImage
        var uiImageGit: UIImage
        if self.traitCollection.userInterfaceStyle == .dark  {
            uiImageGit = UIImage(named:"git_white")!
            uiImageMedium = UIImage(named:"medium_white")!
        }else{
            uiImageGit = UIImage(named:"git_black")!
            uiImageMedium = UIImage(named:"medium_black")!
        }
        
        socialList.append(Social(link: URL(string: "https://github.com/CapelaA10")!, image: uiImageGit, title: "GitHub"))
        socialList.append(Social(link: URL(string: "https://medium.com/@zxufz")!, image: uiImageMedium, title: "Medium"))
        socialList.append(Social(link: URL(string: "https://www.linkedin.com/in/pedro-capela10/")!, image: uiImageLink, title: "Linkedin"))
        
        DispatchQueue.main.async {
            self.tableViewSocial.reloadData()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if let vc = segue.destination as? ArticleWebViewController {
        if let indexPath = self.tableViewSocial.indexPathForSelectedRow{
            vc.url = socialList[indexPath.row].link
        }
     }
    }

}

class SocialViewCell: UITableViewCell {
    @IBOutlet var socialImage: UIImageView!
    @IBOutlet var titleSocial: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

