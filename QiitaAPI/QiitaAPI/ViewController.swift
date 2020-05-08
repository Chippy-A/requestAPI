//
//  ViewController.swift
//  QiitaAPI
//
//  Created by 青木 大地 on 2020/05/03.
//  Copyright © 2020 Daichi Aoki. All rights reserved.
//

import UIKit
import Alamofire

struct Article: Codable {
    let title: String
}

class ViewController: UIViewController {

    private var tableView = UITableView()
    
    fileprivate var articles: [Article] = []{
        didSet{
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView: do {
            tableView.frame = view.frame
            tableView.dataSource = self
            view.addSubview(tableView)
        }
        
        AF.request("https://qiita.com/api/v2/tags/swift/items").responseJSON { response in
            guard let json = response.data else {
                return
            }
            self.articles = try! JSONDecoder().decode([Article].self, from: json)
        }
        
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let article = self.articles[indexPath.row]
        cell.textLabel?.text = article.title
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
}

