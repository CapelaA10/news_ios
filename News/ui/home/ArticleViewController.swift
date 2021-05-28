//
//  ArticleViewController.swift
//  News
//
//  Created by Pedro Capela on 27/05/2021.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var openArticleButton: UIButton!
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = article?.title
        self.descriptionLabel.text = article?.description
        // Do any additional setup after loading the view.
    }

    
    private func userLinkInvalid(){
        let alert = UIAlertController(title: "Invalid", message: "This article is invalid.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in print("Dismised error")}))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ArticleWebViewController {
            vc.url = article?.url
        }
    }

}
