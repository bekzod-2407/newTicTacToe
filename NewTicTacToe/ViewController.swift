//
//  ViewController.swift
//  NewTicTacToe
//
//  Created by user on 20/06/22.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - variables
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    enum Turn {
        case NoughtO
        case CrossX
    }
    
    var firstTurn = Turn.CrossX
    var currentTurn = Turn.NoughtO
    
    var noughtO = "O"
    var crossX = "X"
    
    var noughtScore = 0
    var crosScore = 0
    
    var boardBtns = [UIButton]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initBoard()  //just add all button into boardBtns variable
    }
    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        if (fullBoard()) {
            addAlert(title:"draw")
        }
        if checkVictory(noughtO) {
            noughtScore += 1
            addAlert(title: "O is win")
        }
        if checkVictory(crossX) {
            crosScore += 1
            addAlert(title: "X is win")
        }
    }
//MARK: - main functions
    
    func addToBoard(_ sender: UIButton) {
        //change turn and set button titles
        if sender.title(for: .normal) == nil {
            if currentTurn == Turn.NoughtO {
                sender.setTitle(noughtO, for: .normal)
                currentTurn = Turn.CrossX
                turnLabel.text = crossX
            } else if currentTurn == Turn.CrossX {
                sender.setTitle(crossX, for: .normal)
                currentTurn = Turn.NoughtO
                turnLabel.text = noughtO
            }
            sender.isEnabled = false
        }
    }
    func initBoard() {
        //just add btns into array
        boardBtns.append(a1)
        boardBtns.append(a2)
        boardBtns.append(a3)
        boardBtns.append(b1)
        boardBtns.append(b2)
        boardBtns.append(b3)
        boardBtns.append(c1)
        boardBtns.append(c2)
        boardBtns.append(c3)
    }
    
    func fullBoard() -> Bool {
         // check board is empty or not
        for btn in boardBtns {
            if btn.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    func addAlert(title: String) {
        //show alert  and reset titles after game
        let msg = "\nNoughts \(noughtScore) \n\nCrosses\(crosScore )"
        
        let alert = UIAlertController(title: title, message: msg , preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Reset", style: .default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
        self.resetBoard()
    }
    func resetBoard() {
        // remove all after game
        for btn in boardBtns {
            btn.setTitle(nil, for: .normal)
            btn.isEnabled = true
        }
        if firstTurn == Turn.NoughtO {
            firstTurn = Turn.CrossX
            turnLabel.text = crossX
        } else if firstTurn == Turn.CrossX {
            firstTurn = Turn.NoughtO
            turnLabel.text = noughtO
        }
    }
    
    
//MARK: - victory
    
    func checkVictory(_ s: String) -> Bool {
        //horizontal
        if thisSymbol(a1, s) &&  thisSymbol(a2, s) && thisSymbol(a3, s) {
            return true
        }
        if thisSymbol(b1, s) &&  thisSymbol(b2, s) && thisSymbol(b3, s) {
            return true
        }
        if thisSymbol(c1, s) &&  thisSymbol(c2, s) && thisSymbol(c3, s) {
            return true
        }
        // vaertical
        if thisSymbol(a1, s) &&  thisSymbol(b1, s) && thisSymbol(c1, s) {
            return true
        }
        if thisSymbol(a2, s) &&  thisSymbol(c2, s) && thisSymbol(c3, s) {
            return true
        }
        if thisSymbol(a3, s) &&  thisSymbol(b3, s) && thisSymbol(c3, s) {
            return true
        }
        // diagonal
        if thisSymbol(a1, s) &&  thisSymbol(b2, s) && thisSymbol(c3, s) {
            return true
        }
        if thisSymbol(a3, s) &&  thisSymbol(b2, s) && thisSymbol(c1, s) {
            return true
        }
        
        return false
    }
    func thisSymbol(_ button: UIButton, _ symbol: String)-> Bool {
        return button.title(for: .normal) == symbol
    }
    
}

