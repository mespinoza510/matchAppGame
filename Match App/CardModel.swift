import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        
        // Declare an array to store numbers already generated
        var generatedNumbersArray = [Int]()
        
        // Declare an array to store generated cards
        var generatedCardsArray = [Card]()
        
        // Randomly generate pairs of cards
        while generatedNumbersArray.count < 8 {
            
            // Create random number
            let randomNumber = Int.random(in: 1...13)
            
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
                generatedCardsArray.append(cardOne)
                
                // Create Second card object
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
                
                // Add second card in array
                generatedCardsArray.append(cardTwo)
            }
        }
        
        // Randomize the array
        for i in 0...generatedCardsArray.count-1 {
            let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
            let tempStorage = generatedCardsArray[i]
            
            // Swap two cards
            generatedCardsArray[i] = generatedCardsArray[randomNumber]
            generatedCardsArray[randomNumber] = tempStorage
        }
        // Return the array
        return generatedCardsArray
    }
}
