//
//  ViewController.swift
//  LifeCounter
//
//  Created by Ian Wang on 4/21/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scoreLabel1: UILabel!
    @IBOutlet weak var scoreLabel2: UILabel!
    @IBOutlet weak var minusButton1: UIButton!
    @IBOutlet weak var plusButton1: UIButton!
    @IBOutlet weak var minusButton5: UIButton!
    @IBOutlet weak var plusButton5: UIButton!
    
    var scoreNum1 = 20
    var scoreNum2 = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateScoreNum1()
        updateScoreNum2()

    }

    //Player 1 Buttons
    @IBAction func minusButtonDidTouchUpInside(_ sender: Any) {
        scoreNum1 -= 1
        updateScoreNum1()
        if scoreNum1 <= 0 {
            checkScore(player: "1")
        }
        
    }
    
    @IBAction func plusButtonDidTouchUpInside(_ sender: Any) {
        scoreNum1 += 1
        updateScoreNum1()
        
    }
    
    @IBAction func minus5ButtonDidTouchUpInside(_ sender: Any) {
        scoreNum1 -= 5
        updateScoreNum1()
        if scoreNum1 <= 0 {
            checkScore(player: "1")
        }
    }
    
    @IBAction func plus5ButtonDidTouchUpInside(_ sender: Any) {
        scoreNum1 += 5
        updateScoreNum1()
    }
    
    
    // Player 2 Buttons
    @IBAction func minusButtonDidTouchUpInside2(_ sender: Any) {
        scoreNum2 -= 1
        updateScoreNum2()
        if scoreNum2 <= 0 {
            checkScore(player: "2")
        }
    }
    
    @IBAction func plusButtonDidTouchUpInside2(_ sender: Any) {
        scoreNum2 += 1
        updateScoreNum2()
    }
    
    @IBAction func minus5ButtonDidTouchUpInside2(_ sender: Any) {
        scoreNum2 -= 5
        updateScoreNum2()
        if scoreNum2 <= 0 {
            checkScore(player: "2")
        }
    }
    @IBAction func plus5ButtonDidTouchUpInside2(_ sender: Any) {
        scoreNum2 += 5
        updateScoreNum2()
    }
    
    // Update Scores
    
    func updateScoreNum1 () {
        scoreLabel1.text = "\(scoreNum1)"
    }
    
    func updateScoreNum2 () {
        scoreLabel2.text = "\(scoreNum2)"
    }
    
    // Check Scores
    func checkScore (player: String) {
        let alert = UIAlertController(title: "My Alert", message: "Player \(player) Lost", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
               NSLog("The \"OK\" alert occured.")
               }))
               self.present(alert, animated: true, completion: {
                   NSLog("The alert was presented")
               })

    }
    
    
}

