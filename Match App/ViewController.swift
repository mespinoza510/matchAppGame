//
//  ViewController.swift
//  Match App
//
//  Created by Marco Espinoza on 10/19/19.
//  Copyright © 2019 Marco Espinoza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var stackView: UIView?
    var model = CardModel()
    var cardArray = [Card]()
    var firstFlippedCardIndex: IndexPath?
    var timer: Timer?
    var milliseconds: Float = 20 * 1000 // 20 seconds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call the getCards method
        cardArray = model.getCards()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Create timer object
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timeElapsed), userInfo: nil, repeats: true)
        
        // Set style and size of timerLabel
        timerLabel.font = .boldSystemFont(ofSize: 15)
        
        // Timer continues during scrolling
        RunLoop.main.add(timer!, forMode: .common)
        SoundManager.playSound(.shuffle)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can recreated
    }
    
    // MARK: - Timer Methods
    @objc func timeElapsed() {
        
        milliseconds -= 1
        
        // convert to seconds
        let seconds = String(format: "%.2f", milliseconds / 1000)
        
        // Set timer label
        timerLabel.text = "Time Remaining: \(seconds)s"
        
        // Changing color to orange when user reaches 5 sec
        if  milliseconds <= 5000 && milliseconds >= 1000 {
            timerLabel.textColor = .systemOrange
        }
        
        // Stop timer at 0
        if milliseconds <= 0 {
            timer?.invalidate()
            timerLabel.textColor = .red
            
            // Check if any cards are unmatched
            checkGameEnded()
        }
    }
    
    // MARK: - UICollectionView Protocol Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Get a Card Collection View Object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        // Get the card that the card collection view is trying to display
        let card = cardArray[indexPath.row]
        
        // Set that card for the cell
        cell.setCard(card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Check if any time remaining
        if milliseconds <= 0 {
            return
        }
        
        // Get the cell that the user selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        // Get the card that the user selected
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
            cell.flip()
            
            SoundManager.playSound(.flip)
            // set the status of the card
            card.isFlipped = true
            
            // Determine if the first card or second card is flipped
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
            } else {
                
                // This is the second card flipped
                
                
                // Perform matching logic
                checkForMatches(indexPath)
            }
        }
    }
    
    // MARK: - Game Logic Method
    
    func checkForMatches(_ secondFlippedCardIndex: IndexPath) {
        
        // Get the cells for the two cards were revealed
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        // Get the cards for the two cards that were revealed
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        // Compare the two cards
        if cardOne.imageName == cardTwo.imageName {
            
            // It's a match
            SoundManager.playSound(.match)
            
            // Set the statuses of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            // Remove the cards from the grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            // Check if any cards are left unmatched
            checkGameEnded()
        }
        else {
            
            // It's not a match
            SoundManager.playSound(.nomatch)
            
            // Set the statuses of the cards
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // Flip both cards back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        
        // Tell the collectionView to reload cell of first card if nil
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        
        // Reset the property that tracks first flipped card
        firstFlippedCardIndex = nil
    }
    
    func checkGameEnded() {
        
        // Determine if there are any cards unmatched
        var isWon = true
        var title = ""
        var message = ""
        
        for card in cardArray {
            
            if card.isMatched == false {
                isWon = false
                break
            }
        }
         
        // If not then user has won and stop timer
        if isWon {
            
            if milliseconds > 0 {
                
                timer?.invalidate()
                timerLabel.textColor = .red
            }
            
            title = "Congratulations!"
            message = "You've won"
            
        } else {
            
            // If cards remaining, then check if any time left
            if milliseconds > 0 {
                return
            }
            
            title = "Game Over"
            message = "You've lost"
        }
        
        // Show won/lost messaging
        showAlert(title, message)
    }
    
    func showAlert(_ title: String, _ message: String) {
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let alertCTA = UIAlertAction.init(title: "Dismiss", style: .default, handler: nil)
        
        alert.addAction(alertCTA)
        present(alert, animated: true, completion: nil)
    }
    
} // End ViewController Class

