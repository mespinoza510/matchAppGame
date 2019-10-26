import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        
        // Declare an array to store generated cards
        var generatedArrayOfCards = [Card]()
        
        // Randomly generate pairs of cards
        for _ in 1...8 {
            
            // Create random number
            let randomNumber = String(arc4random_uniform(13) + 1)
            
            // Log the number
            print(randomNumber)
            
            // Create first card object
            let cardOne = Card()
            cardOne.imageName = "card\(randomNumber)"
            
            // Add created card in array
            generatedArrayOfCards.append(cardOne)
            
            // Create Second card object
            let cardTwo = Card()
            cardTwo.imageName = "card\(randomNumber)"
            
            // Add second card in array
            generatedArrayOfCards.append(cardTwo)
            
            // TODO: Make it so we only have unique pairs of cards
            
        }
        // TODO: Randomize the array
        
        // Return the array
        return generatedArrayOfCards
    }
    
}
