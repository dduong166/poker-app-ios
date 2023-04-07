//
//  ResultViewController.swift
//  poker-app-ios
//
//  Created by ズオン ダン on 2023/03/26.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var resultTableView: UITableView!
    var results = [Result(cards: "", hand: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTableView.dataSource = self
        print(results)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultTableView.dequeueReusableCell(withIdentifier: "resultCell") as! ResultTableViewCell
        let result = results[indexPath.row]
        
        cell.hand.text = result.hand
        cell.cards.text = result.cards
        
        return cell
    }
}

class ResultTableViewCell: UITableViewCell {
    @IBOutlet weak var hand: UILabel!
    @IBOutlet weak var cards: UILabel!
}
