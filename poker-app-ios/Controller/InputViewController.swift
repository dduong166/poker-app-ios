//
//  ViewController.swift
//  poker-app-ios
//
//  Created by ズオン ダン on 2023/03/06.
//

import UIKit

class ViewController: UIViewController {
    var hands = [Hand(inputCard1: Card(name: "", error: ""), inputCard2: Card(name: "", error: ""), inputCard3: Card(name: "", error: ""), inputCard4: Card(name: "", error: ""), inputCard5: Card(name: "", error: ""))]
    @IBOutlet weak var inputTableView: UITableView!
    @IBOutlet weak var checkBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inputTableView.dataSource = self
        checkBtn.isEnabled = false
        
        print(SingletonClass.shared.getIsErrorInputPresent())
    }

   
    @IBAction func pressCheckBtn(_ sender: Any) {
        print("aaaaa")
    }
    @IBAction func addInput(_ sender: Any) {
        hands.append(Hand(inputCard1: Card(name: "", error: ""), inputCard2: Card(name: "", error: ""), inputCard3: Card(name: "", error: ""), inputCard4: Card(name: "", error: ""), inputCard5: Card(name: "", error: "")))
        inputTableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = inputTableView.dequeueReusableCell(withIdentifier: "inputCell") as! HandTableViewCell
        let hand = hands[indexPath.row]
        
        cell.inputCard1.text = hand.inputCard1.name
        cell.inputCard2.text = hand.inputCard2.name
        cell.inputCard3.text = hand.inputCard3.name
        cell.inputCard4.text = hand.inputCard4.name
        cell.inputCard5.text = hand.inputCard5.name
        
        return cell
    }
}

class HandTableViewCell: UITableViewCell {
        
    @IBOutlet weak var inputCard1: UITextField!
    @IBOutlet weak var errorMessage1: UILabel!
    @IBOutlet weak var errorIcon1: UIImageView!
    
    @IBOutlet weak var inputCard2: UITextField!
    @IBOutlet weak var errorMessage2: UILabel!
    @IBOutlet weak var errorIcon2: UIImageView!

    @IBOutlet weak var inputCard3: UITextField!
    @IBOutlet weak var errorMessage3: UILabel!
    @IBOutlet weak var errorIcon3: UIImageView!
    
    @IBOutlet weak var inputCard4: UITextField!
    @IBOutlet weak var errorMessage4: UILabel!
    @IBOutlet weak var errorIcon4: UIImageView!

    @IBOutlet weak var inputCard5: UITextField!
    @IBOutlet weak var errorMessage5: UILabel!
    @IBOutlet weak var errorIcon5: UIImageView!
       
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func edittingInputCard1(_ sender: Any) {
        checkInputError(inputCard: inputCard1, errorMessage: errorMessage1, errorIcon: errorIcon1)
    }
    @IBAction func edittingInputCard2(_ sender: Any) {
        checkInputError(inputCard: inputCard2, errorMessage: errorMessage2, errorIcon: errorIcon2)
    }
    @IBAction func edittingInputCard3(_ sender: Any) {
        checkInputError(inputCard: inputCard3, errorMessage: errorMessage3, errorIcon: errorIcon3)
    }
    @IBAction func edittingInputCard4(_ sender: Any) {
        checkInputError(inputCard: inputCard4, errorMessage: errorMessage4, errorIcon: errorIcon4)
    }
    @IBAction func edittingInputCard5(_ sender: Any) {
        checkInputError(inputCard: inputCard5, errorMessage: errorMessage5, errorIcon: errorIcon5)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//check if there is any error input, show error if present
func checkAllInputError(inputCard1: UITextField, inputCard2: UITextField, inputCard3: UITextField, inputCard4: UITextField, inputCard5: UITextField){
    
}

func checkInputError(inputCard: UITextField, errorMessage: UILabel, errorIcon: UIImageView) {
    let REGEX = "^([SHDC])([1-9]|1[0-3])$"

    if inputCard.text == "" || inputCard.text?.range(of: REGEX, options: .regularExpression) != nil {
        showInputError(errorMessage: errorMessage, errorIcon: errorIcon, isHidden: true)
    } else {
        showInputError(errorMessage: errorMessage, errorIcon: errorIcon, isHidden: false)
    }
}

func showInputError(errorMessage: UILabel, errorIcon: UIImageView, isHidden: Bool) {
    errorMessage.isHidden = isHidden
    errorIcon.isHidden = isHidden
}

