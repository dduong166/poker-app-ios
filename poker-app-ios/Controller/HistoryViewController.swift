//
//  HistoryViewController.swift
//  poker-app-ios
//
//  Created by ズオン ダン on 2023/03/26.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var historyTableView: UITableView!
    var histories = [
        History(card: "C7 C6 C5 C4 C3", hand: "フルハウス", created_at: "03/04/2023 18:16"),
        History(card: "H1 H13 H2 A1 D10", hand: "フォー・オブ・ア・カインド", created_at: "12/03/2023 08:16"),
        History(card: "H1 H13 H12 H11 H10", hand: "ストレートフラッシュ", created_at: "03/02/2023 11:10"),
    ]
   
    override func viewDidLoad() {
        super.viewDidLoad()

        historyTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return histories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "historyCell") as! HistoryTableViewCell
        let history = histories[indexPath.row]
        
        cell.hand.text = history.hand
        cell.card.text = history.card
        cell.created_at.text = history.created_at
        
        return cell
    }
    

}

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var hand: UILabel!
    @IBOutlet weak var card: UILabel!
    @IBOutlet weak var created_at: UILabel!
}
