//
//  ResultViewController.swift
//  poker-app-ios
//
//  Created by ズオン ダン on 2023/03/26.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var resultTableView: UITableView!
    var param = [Hand(inputCard1: "", inputCard2: "", inputCard3: "", inputCard4: "", inputCard5: "")]
    var results = [
        Result(card: "C7 C6 C5 C4 C3", hand: "フルハウス"),
        Result(card: "H1 H13 H2 A1 D10", hand: "フォー・オブ・ア・カインド"),
        Result(card: "H1 H13 H12 H11 H10", hand: "ストレートフラッシュ"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTableView.dataSource = self
        
        print(param)

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultTableView.dequeueReusableCell(withIdentifier: "resultCell") as! ResultTableViewCell
        let result = results[indexPath.row]
        
        cell.hand.text = result.hand
        cell.card.text = result.card
        
        return cell
    }
}

class ResultTableViewCell: UITableViewCell {
    @IBOutlet weak var hand: UILabel!
    @IBOutlet weak var card: UILabel!
}
