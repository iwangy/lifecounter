//
//  ViewController.swift
//  LifeCounter
//
//  Created by Ian Wang on 4/21/22.
//

import UIKit

protocol playerDelegate {
    func addHistory(player: String, action: String, num: Int)
    func checkScore(score: Int, player: String)
    func gameStart()
    func present(alertController: UIAlertController)
    func hideMessage()
}

class ViewController: UIViewController, playerDelegate {
    // Vars
    var numPlayers = 4
    var playersAlive = 4
    var history:[String] = []
    var playerList: [PlayerScoreControl] = []
    var players = ["Player 1", "Player 2", "Player 3", "Player 4", "Player 5", "Player 6", "Player 7", "Player 8"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outcomeLabel.isHidden = true
        for i in 0...3 {
            createPlayer(i: i)
        }
    }
    
    //Button Outlets
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var removePlayerButton: UIButton!
    @IBOutlet weak var playerStackView: UIStackView!
    @IBOutlet weak var outcomeLabel: UILabel!
    
    //Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier
        {
        case Optional("fromMainToHistory"):
            print("Going from main to history")
            let historyVC = segue.destination as? ViewControllerHistory
            historyVC?.history = history
            break;
        default:
            print("I have no idea what segue you're using")
        }
    }
    
    func createPlayer(i: Int) {
        let newPlayer = PlayerScoreControl()
        newPlayer.data = (i)
        newPlayer.tag = i
        newPlayer.delegate = self
        playerList.append(newPlayer)
        playerStackView.addArrangedSubview(newPlayer)
    }
    
    func present(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
    
    func gameStart() {
        addPlayerButton.isEnabled = false
        removePlayerButton.isEnabled = false
    }
    
    func hideMessage() {
        outcomeLabel.isHidden = true
    }
    
    func addHistory(player: String, action: String, num: Int) {
        var text = player
        switch action {
        case "+":
            text += " gained " + String(num) + " life."
        case "-":
            text += " lost " + String(num) + " life."
        default:
            text += " Loses!"
        }
        history.append(text)
    }
    
    func checkScore(score: Int, player: String) {
        if score <= 0 {
            outcomeLabel.text = "\(player) LOSES!"
            outcomeLabel.isHidden = false
            addHistory(player: player, action: "lose", num: 0)
            playersAlive -= 1;
        }
        
        perform(#selector(checkGame), with: nil, afterDelay: 0.2)
    }
    
    @objc func checkGame() {
        if playersAlive == 1 {
            outcomeLabel.text = "Game Over!"
            perform(#selector(resetGame), with: nil, afterDelay: 0.2)
        }
    }
    
    @objc func resetGame() {
        for p in playerList {
            p.reset()
        }
        outcomeLabel.isHidden = true
        history = []
        if numPlayers != 8 {
            addPlayerButton.isEnabled = true;
        }
        if numPlayers != 2 {
            removePlayerButton.isEnabled = true;
        }
       playersAlive = numPlayers
    }
    
    @IBAction func addPlayer(_ sender: Any) {
        createPlayer(i: numPlayers)
        numPlayers += 1
        playersAlive += 1
        
        if numPlayers == 8 {
            addPlayerButton.isEnabled = false
        }
        if numPlayers != 2 {
            removePlayerButton.isEnabled = true
        }
        
    }
    
    @IBAction func removePlayer(_ sender: Any) {
        numPlayers -= 1
        playersAlive  -= 1
        for i in 0...(playerList.count - 1) {
            if (playerList[i]).tag == numPlayers {
                playerList[i].removeFromSuperview()
                playerList.remove(at: i)
            }
        }
        
        if numPlayers != 8 {
            addPlayerButton.isEnabled = true;
        }
        if numPlayers == 2 {
            removePlayerButton.isEnabled = false;
        }
    }

}

