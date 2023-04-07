//
//  HistoryViewController.swift
//  poker-app-ios
//
//  Created by ズオン ダン on 2023/03/26.
//

import UIKit
import RealmSwift

class HistoryViewController: UIViewController, UITableViewDataSource {
    var shouldReloadData = false
    
    @IBOutlet weak var historyTableView: UITableView!
    var histories = [History]()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        historyTableView.dataSource = self
        histories = readFromDatabase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1回目はtableviewをリロードしない、2回目からリロードする
        if shouldReloadData {
            histories = readFromDatabase()
            historyTableView.reloadData()
        } else {
            shouldReloadData = true
        }
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

//データベースから履歴のデータを読み出す
//param なし
//return histories_list 表示させる履歴一覧
func readFromDatabase() -> [History] {
    var histories_list = [History]()
    let realm = try! Realm()
    let historyResults = realm.objects(HistoryRealm.self)
    print(historyResults)
        
    for historyResult in historyResults {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "JST")

        histories_list.insert(History(card: historyResult.cards, hand: historyResult.hand, created_at: dateFormatter.string(from: historyResult.created_at)), at: 0)
    }
    
    return histories_list
}

