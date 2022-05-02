//
//  PlayerScoreControl.swift
//  LifeCounter
//
//  Created by Ian Wang on 4/25/22.
//

import UIKit

class PlayerScoreControl: UIView {
    
    var delegate: playerDelegate?
    var lifeCount = 20
    var addValue = 5
    var subValue = 5
    let nibName = "PlayerScoreControl"
    var players = ["Player 1", "Player 2", "Player 3", "Player 4", "Player 5", "Player 6", "Player 7", "Player 8"]
    var contentView: UIView?
    
    @IBOutlet weak var playerName: UIButton!
    @IBOutlet var scoreDisplay: UILabel!
    
    var data : (Int) = (-1) {
        didSet {
            playerName.setTitle(players[data], for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScoreView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupScoreView()
    }
    
    private func setupScoreView() {
        
        let nib = UINib(nibName: nibName, bundle: nil)
        let nibInstance = nib.instantiate(withOwner: self, options: nil)
        let nibView = (nibInstance.first) as! UIView
 
        addSubview(nibView)
    }
    
    func reset() {
        lifeCount = 20
        scoreDisplay.text = "20"
    }
    
    // Button Functions
    @IBOutlet weak var minusButton: UIButton!
    
    @IBAction func changeMinusX(_ sender: Any) {
        let alertController = UIAlertController(title: "Enter new value", message: "Lives to add and subtract by", preferredStyle: .alert)
        alertController.addTextField {(textField) -> Void in
            textField.keyboardType = UIKeyboardType.numberPad
            textField.placeholder = self.minusButton.currentTitle
            textField.placeholder = self.addButton.currentTitle
        }
        
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            let name = alertController.textFields?[0].text
            if (Int(name!) != nil) {
                self.minusButton.setTitle("-" + name!, for: .normal)
                self.addButton.setTitle("+" + name!, for: .normal)
                self.subValue = Int(name!)!
                self.addValue = Int(name!)!
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        delegate!.present(alertController: alertController)
    }
    
    @IBOutlet weak var playerNameButton: UIButton!
    @IBAction func changePlayerName(_ sender: Any) {
        let alertController = UIAlertController(title: "Enter new name", message: "Enter name", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            let name = alertController.textFields?[0].text
            (sender as AnyObject).setTitle(name, for: .normal)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField{ (textField) in
            textField.keyboardType = UIKeyboardType.default
            textField.placeholder = (sender as AnyObject).currentTitle
        }

        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction )
        
        delegate!.present(alertController: alertController)
    }
    
    @IBAction func minusXButton(_ sender: Any) {
        delegate!.hideMessage()
        lifeCount -= subValue
        scoreDisplay.text = String(lifeCount)
        delegate!.addHistory(player: playerName.currentTitle!, action: "-", num: subValue)
        delegate!.checkScore(score: lifeCount, player: self.playerName.currentTitle!)
        delegate!.gameStart()
    }
    
    @IBAction func minus1Life(_ sender: Any) {
        delegate!.hideMessage()
        lifeCount -= 1
        scoreDisplay.text = String(lifeCount)
        delegate!.addHistory(player: playerName.currentTitle!, action: "-", num: 1)
        delegate!.checkScore(score: lifeCount, player: self.playerName.currentTitle!)
        delegate!.gameStart()
    }
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func addXButton(_ sender: Any) {
        delegate!.hideMessage()
        lifeCount -= subValue
        scoreDisplay.text = String(lifeCount)
        delegate!.addHistory(player: playerName.currentTitle!, action: "+", num: subValue)
        delegate!.checkScore(score: lifeCount, player: self.playerName.currentTitle!)
        delegate!.gameStart()
    }
    
    @IBAction func add1Life(_ sender: Any) {
        delegate!.hideMessage()
        lifeCount += 1
        scoreDisplay.text = String(lifeCount)
        delegate!.addHistory(player: playerName.currentTitle!, action: "+", num: 1)
        delegate!.gameStart()
    }
    
}
    
