//
//  ViewController.swift
//  Apple Pie
//
//  Created by Joseph Barbati on 10/21/17.
//  Copyright © 2017 Joseph Barbati. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var treeImage: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    let incorrectMovesAllowed: Int = 7
    
    var listOfWords = ListOfWords()
    
    var totalWins: Int = 0
    {
        didSet
        {
            self.startNewRound()
        }
    }
    
    var totalLosses: Int = 0
    {
        didSet
        {
            self.startNewRound()
        }
    }
    
    var game: Game!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.startNewRound()
    }
    
    func startNewRound()
    {
        if listOfWords.words.isEmpty
        {
            self.enableLetterButtons(false)
            return
        }
        
        let nextWord: String = listOfWords.words.removeFirst()
        self.game = Game(word: nextWord,
                         incorrectMovesRemaining: self.incorrectMovesAllowed,
                         guessedLetters: [])
        self.updateUI()
        self.enableLetterButtons(true)
    }
    
    func enableLetterButtons(_ enable: Bool)
    {
        for button in self.letterButtons
        {
            button.isEnabled = enable
        }
    }
    
    func updateUI()
    {
        self.correctWordLabel.text = self.createStringArrayFromChars(self.game.formattedWord.characters)
        self.scoreLabel.text = "Wins: \(self.totalWins)    Losses: \(self.totalLosses)"
        treeImage.image = UIImage(named: "Tree \(self.game.incorrectMovesRemaining)")
    }
    
    func createStringArrayFromChars(_ chars: String.CharacterView) -> String
    {
        var letters = [String]()
        for letter in chars
        {
            letters.append(String(letter))
        }
        return letters.joined(separator: " ")
    }
    
    func updateGameState()
    {
        if self.game.incorrectMovesRemaining == 0
        {
            self.totalLosses += 1
        }
        else if self.game.word == self.game.formattedWord
        {
            self.totalWins += 1
        }
        else
        {
            self.updateUI()
        }
    }
    
    @IBAction func letterPressed(_ sender: UIButton)
    {
        sender.isEnabled = false
        let guess = Character((sender.title(for: .normal)!).lowercased())
        self.game.playerGuesed(letter: guess)
        self.updateUI()
        self.updateGameState()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
