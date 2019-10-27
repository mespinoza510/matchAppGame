import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        
        // Declare an array to store numbers already generated
        var generatedNumbersArray = [Int]()
        
        // Declare an array to store generated cards
        var generatedArrayOfCards = [Card]()
        
        // Randomly generate pairs of cards
        while generatedNumbersArray.count < 8 {
            
            // Create random number
            let randomNumber = arc4random_uniform(13) + 1
            
            // Ensure random number isn't the same in array
            if generatedNumbersArray.contains(Int(randomNumber)) == false {
                
                // Log the number
                print(randomNumber)
                
                // Store number into generatedNumbersArray
                generatedNumbersArray.append(Int(randomNumber))
                
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
            }
            
            // Make it so we only have unique pairs of cards
            
        }
        
        // Return the array of cards shuffled
        return generatedArrayOfCards.shuffled()
    }
    
}
