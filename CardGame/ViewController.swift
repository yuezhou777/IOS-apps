//
//  ViewController.swift
//  CardGame
//
//  Created by yue zhou on 2020/10/3.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var p1_card1: UIImageView!
    @IBOutlet weak var p1_card2: UIImageView!
    @IBOutlet weak var p1_card3: UIImageView!
    
    @IBOutlet weak var p2_card1: UIImageView!
    @IBOutlet weak var p2_card2: UIImageView!
    @IBOutlet weak var p2_card3: UIImageView!
    
    @IBOutlet weak var displayWinner: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    let suits = ["H","S","D","C"]
    var player1Win = false
    var player2Win = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func deal1() -> String {
        var card = ""
        let suit = Int.random(in: 0..<4)
        let num = Int.random(in: 1..<14)
        
        if num == 1 {
            card = "A"
        } else if num == 11 {
            card = "J"
        } else if num == 12 {
            card = "Q"
        } else if num == 13 {
            card = "K"
        } else {
            card = String(num)
        }
        
        card += suits[suit]
        if card == "AS" {
            player1Win = true
        }

        return card
    }
    
    func deal2() -> String {
        var card = ""
        let suit = Int.random(in: 0..<4)
        let num = Int.random(in: 1..<14)
        
        if num == 1 {
            card = "A"
        } else if num == 11 {
            card = "J"
        } else if num == 12 {
            card = "Q"
        } else if num == 13 {
            card = "K"
        } else {
            card = String(num)
        }
        
        card += suits[suit]
        if card == "AS" {
            player2Win = true
        }

        return card
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
        p1_card1.image = UIImage(named: deal1())
        p1_card2.image = UIImage(named: deal1())
        p1_card3.image = UIImage(named: deal1())
        
        p2_card1.image = UIImage(named: deal2())
        p2_card2.image = UIImage(named: deal2())
        p2_card3.image = UIImage(named: deal2())
        
        showWinner()
    }

    func showWinner() {
        if player1Win && player2Win {
            displayWinner.text = "No Winner"
        } else if player1Win {
            displayWinner.text = "Player1 Win!"
            showAlert()
        } else if player2Win {
            displayWinner.text = "Player2 Win!"
            showAlert()
        } else {
            displayWinner.text = "No Winner"
        }
        displayWinner.textColor = .purple
    }
    
    func showAlert() {
        let controller = UIAlertController(title: "Play Again", message: "Do you wanna play again?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            self.shuffle()
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "No", style: .destructive) { (_) in
            self.closeGame()
        }
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    
    func shuffle() {
        p1_card1.image = UIImage(named: "purple_back")
        p1_card2.image = UIImage(named: "purple_back")
        p1_card3.image = UIImage(named: "purple_back")
        
        p2_card1.image = UIImage(named: "purple_back")
        p2_card2.image = UIImage(named: "purple_back")
        p2_card3.image = UIImage(named: "purple_back")
        
        player1Win = false
        player2Win = false
        
        displayWinner.textColor = .white
    }
    
    func closeGame() {
        playButton.isEnabled = false
        playButton.alpha = 0.2
    }
    
}

