//
//  Game.swift
//  Apple Pie
//
//  Created by Joseph Barbati on 10/21/17.
//  Copyright © 2017 Joseph Barbati. All rights reserved.
//

import Foundation

struct Game
{
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    mutating func playerGuesed(letter: Character)
    {
        self.guessedLetters.append(letter)
        if !word.characters.contains(letter)
        {
            self.incorrectMovesRemaining -= 1
        }
    }
    
    var formattedWord: String
    {
        var guessedWord = ""
        for letter in self.word.characters
        {
            if guessedLetters.contains(letter)
            {
                guessedWord += "\(letter)"
            }
            else
            {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
}
