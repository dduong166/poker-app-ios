//
//  ViewController.swift
//  poker-app-ios
//
//  Created by ズオン ダン on 2023/03/06.
//

import UIKit
import RealmSwift

//Poker画面でのグローバル変数
struct TableViewData {
    static var hands = [Hand]()
    static var cellPosition = 0
    static var isErrorPresent = true
}

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var inputTableView: UITableView!
    @IBOutlet weak var checkBtn: UIButton!
    
    var shouldReloadData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inputTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        TableViewData.hands = [Hand(inputCard1: "", inputCard2: "", inputCard3: "", inputCard4: "", inputCard5: "")]
        //1回目はtableviewをリロードしない、2回目からリロードする
        shouldReloadData ? inputTableView.reloadData() : (shouldReloadData = true)
    }
    
    //入力されているText FieldがどのCellにあるかを確認する
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // get UITableViewCell that contain UITextField
        guard let cell = textField.superview?.superview as? HandTableViewCell else {
            return
        }
        // get indexPath of UITableViewCell
        guard let indexPath = inputTableView.indexPath(for: cell) else {
            return
        }
        TableViewData.cellPosition = indexPath.row
    }

   //Submitボランが押される場合の対応
    @IBAction func pressCheckBtn(_ sender: Any) {
        // Loading...
        let loadingVC = LoadingViewController()
        loadingVC.modalPresentationStyle = .overCurrentContext
        loadingVC.modalTransitionStyle = .crossDissolve
        
        if TableViewData.isErrorPresent == true || isEmptyPresent() {
            Toast.show(Strings.ErrorMessages.errorPresent, self.view)
        } else {
            present(loadingVC, animated: true, completion: nil)
            getResult { (result, error) in
                DispatchQueue.main.async {
                    //disable loading
                    loadingVC.dismiss(animated: true) {
                        if let error = error {
                            print("Error: \(error)")
                            Toast.show(error.localizedDescription, self.view)
                        } else if let result = result {
                            print("Result: \(result)")
                            writeToDatabase(results: result.results)
                            let resultScreen = self.storyboard?.instantiateViewController(withIdentifier: "result_screen") as! ResultViewController
                            resultScreen.results = result.results
                            self.navigationController?.pushViewController(resultScreen, animated: true)
                        }
                    }
                }

            }
        }
    }
    
    //カードセットを追加するためのボタンが押される場合の対応
    @IBAction func addInput(_ sender: Any) {
        TableViewData.hands.append(Hand(inputCard1: "", inputCard2: "", inputCard3: "", inputCard4: "", inputCard5: ""))
        inputTableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableViewData.hands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = inputTableView.dequeueReusableCell(withIdentifier: "inputCell") as! HandTableViewCell
        let hand = TableViewData.hands[indexPath.row]
        
        cell.inputCard1.text = hand.inputCard1
        cell.inputCard1.delegate = self
        cell.inputCard2.text = hand.inputCard2
        cell.inputCard2.delegate = self
        cell.inputCard3.text = hand.inputCard3
        cell.inputCard3.delegate = self
        cell.inputCard4.text = hand.inputCard4
        cell.inputCard4.delegate = self
        cell.inputCard5.text = hand.inputCard5
        cell.inputCard5.delegate = self

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

    //Text Fieldが入力される場合の対応
    @IBAction func edittingInputCard1(_ sender: Any) {
        TableViewData.hands[TableViewData.cellPosition].inputCard1 = inputCard1.text ?? ""
        checkInputError()
    }
    @IBAction func edittingInputCard2(_ sender: Any) {
        TableViewData.hands[TableViewData.cellPosition].inputCard2 = inputCard2.text ?? ""
        checkInputError()
    }
    @IBAction func edittingInputCard3(_ sender: Any) {
        TableViewData.hands[TableViewData.cellPosition].inputCard3 = inputCard3.text ?? ""
        checkInputError()
    }
    @IBAction func edittingInputCard4(_ sender: Any) {
        TableViewData.hands[TableViewData.cellPosition].inputCard4 = inputCard4.text ?? ""
        checkInputError()
    }
    @IBAction func edittingInputCard5(_ sender: Any) {
        TableViewData.hands[TableViewData.cellPosition].inputCard5 = inputCard5.text ?? ""
        checkInputError()
    }

    //カードセットにエラーがあるかどうか確認する
    //param なし
    //return なし
    func checkInputError() {
        TableViewData.isErrorPresent = false
        
        //カードセットにある各カードの値の配列
        let inputArray = [TableViewData.hands[TableViewData.cellPosition].inputCard1, TableViewData.hands[TableViewData.cellPosition].inputCard2, TableViewData.hands[TableViewData.cellPosition].inputCard3, TableViewData.hands[TableViewData.cellPosition].inputCard4, TableViewData.hands[TableViewData.cellPosition].inputCard5]
        // inputArray内の各要素の出現回数
        let countDictionary = countInputValue(inputArray: inputArray)

        //各カードを検証する
        for (index, value) in inputArray.enumerated() {
            switch index {
            case 0:
                showErrorIfPresent(inputCard: inputCard1, countValue: countDictionary[value] ?? 0, errorMessage: errorMessage1, errorIcon: errorIcon1)
            case 1:
                showErrorIfPresent(inputCard: inputCard2, countValue: countDictionary[value] ?? 0, errorMessage: errorMessage2, errorIcon: errorIcon2)
            case 2:
                showErrorIfPresent(inputCard: inputCard3, countValue: countDictionary[value] ?? 0, errorMessage: errorMessage3, errorIcon: errorIcon3)
            case 3:
                showErrorIfPresent(inputCard: inputCard4, countValue: countDictionary[value] ?? 0, errorMessage: errorMessage4, errorIcon: errorIcon4)
            case 4:
                showErrorIfPresent(inputCard: inputCard5, countValue: countDictionary[value] ?? 0, errorMessage: errorMessage5, errorIcon: errorIcon5)
            default:
                break
            }
        }
    }
}

//カードセットの各カードの出現回数を数える
//param inputArray カードセットにある各カードの値の配列
//return countDictionary そのカードセット内の各カードの出現回数
func countInputValue(inputArray: [String]) -> [String: Int] {
    var countDictionary = [String: Int]()

    for value in inputArray {
        if let count = countDictionary[value] {
            countDictionary[value] = count + 1
        } else {
            countDictionary[value] = 1
        }
    }
    
    return countDictionary
}
 
//カードが不正かどうか確認する
//param inputCard カードのTextField
//param countValue カードセットにの出現回数
//param errorMessage そのカードのエラーメッセージTextField
//param errorIcon そのカードのエラーアイコンTextField
//return なし
func showErrorIfPresent(inputCard: UITextField, countValue: Int, errorMessage: UILabel, errorIcon: UIImageView) {
    //重複されるかどうかを検証する
    if inputCard.text != "" && countValue > 1 {
        showInputError(errorMessage: errorMessage, errorIcon: errorIcon, errorMessageText: Strings.ErrorMessages.duplicatedInput)
    } else {
        //カードのフォーマットが不正かどうかを検証する
        checkFormatError(inputCard: inputCard, errorMessage: errorMessage, errorIcon: errorIcon)
    }
}

//カードのフォーマットが不正かどうかを検証する
//param inputCard カードのTextField
//param errorMessage そのカードのエラーメッセージTextField
//param errorIcon そのカードのエラーアイコンTextField
//return なし
func checkFormatError(inputCard: UITextField, errorMessage: UILabel, errorIcon: UIImageView) {
    let REGEX = "^([SHDC])([1-9]|1[0-3])$"

    if inputCard.text == "" || inputCard.text?.range(of: REGEX, options: .regularExpression) != nil {
        showInputError(errorMessage: errorMessage, errorIcon: errorIcon, errorMessageText: "")
    } else {
        showInputError(errorMessage: errorMessage, errorIcon: errorIcon, errorMessageText: Strings.ErrorMessages.errorInput)
    }
}

//エラーメッセージを表示させる
//param errorMessage そのカードのエラーメッセージTextField
//param errorIcon そのカードのエラーアイコンTextField
//param errorMessageText エラーメッセージの内容
//return なし
func showInputError(errorMessage: UILabel, errorIcon: UIImageView, errorMessageText: String) {
    if errorMessageText == "" {
        errorMessage.isHidden = true
        errorIcon.isHidden = true
    } else {
        errorMessage.text = errorMessageText
        errorMessage.isHidden = false
        errorIcon.isHidden = false
        TableViewData.isErrorPresent = true
    }
}

//全体のカードセットに空いているカードの存在を確認する
//param なし
//return Bool true:存在、 false:不在
func isEmptyPresent() -> Bool{
    return TableViewData.hands.contains { hand in
        hand.inputCard1.isEmpty || hand.inputCard2.isEmpty || hand.inputCard3.isEmpty || hand.inputCard4.isEmpty || hand.inputCard5.isEmpty
    }
}

//結果を確認するAPIを呼び出す
//param なし
//return Bool true:存在、 false:不在
func getResult(completion: @escaping (ResultsContainer?, Error?) -> Void) {
    // Prepare URL
    let url = URL(string: "https://atoneios.onrender.com/api/v1/poker")
    guard let requestUrl = url else { fatalError() }
    // Prepare URL Request Object
    var request = URLRequest(url: requestUrl)
    request.httpMethod = "POST"

    // HTTP Request Parameters which will be sent in HTTP Request Body
    let postString = handsArrayToJson(hands: TableViewData.hands);
    // Set HTTP Request Body
    request.httpBody = postString?.data(using: String.Encoding.utf8);
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    // Perform HTTP Request
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

        // Check for errors
        guard error == nil else {
            completion(nil, error)
            return
        }

        // Check if there is data
        guard let data = data else {
            completion(nil, NSError(domain: "noData", code: 1, userInfo: nil))
            return
        }

        do {
            // Decode the JSON data into a Result object
            let decoder = JSONDecoder()
            let returnResult = try decoder.decode(ResultsContainer.self, from: data)

            // Return the Result object through the completion handler
            completion(returnResult, nil)

        } catch {
            print("Error decoding JSON: \(error)")

            // Return the error through the completion handler
            completion(nil, error)
        }
    }
    task.resume()
}

func writeToDatabase(results: [Result]) {
    let realm = try! Realm()
    
    for resultItem in results {

        let historyItem = HistoryRealm()
        historyItem.cards = resultItem.cards
        historyItem.hand = resultItem.hand
        historyItem.created_at = Date()

        try! realm.write {
            realm.add(historyItem)
        }
    }
}
