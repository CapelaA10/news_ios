//
//  MostViewController.swift
//  News
//
//  Created by Pedro Capela on 26/05/2021.
//

import UIKit

class MostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableViewNews: UITableView!

    var articles: [Article] = []
    
    var countryCode: String = "us"
    let apiKey: String = "API-KEY"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Most Viewed".localized()
        self.tableViewNews.delegate = self
        self.tableViewNews.dataSource = self
        if let countryCodeRequested = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            countryCode = countryCodeRequested.lowercased()
        }
        requestArticles()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableViewNews.reloadData()
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! ArticleViewCell
        
        let article = articles[indexPath.row]
        
        cell.titleLabel.text = article.title
        cell.descriptionLabel.text = article.description
        
        return cell
    }
    
    private func requestArticles(){
        let session = URLSession.shared
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=" + countryCode + "&apiKey=" + apiKey)!
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            if error != nil{
                DispatchQueue.main.async {
                    alertUserError(vc: self,error: "Network error.")
                }
                return
            }
            
            do {
                let json = try JSONDecoder().decode(Response.self, from: data!)
                for article in json.articles{
                    if article.url != nil && article.title != nil && article.description != nil{
                        self.articles.append(article)
                    }
                }
                DispatchQueue.main.async {
                    self.tableViewNews.reloadData()
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    alertUserError(vc: self, error: "Data error.")
                }
                return
            }
        })
        task.resume()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ArticleViewController {
            if let indexPath = self.tableViewNews.indexPathForSelectedRow{
                vc.article = articles[indexPath.row]
            }
        }
    }
    

}


class ArticleViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

struct Response: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let title: String?
    let description: String?
    let url: URL?
}
