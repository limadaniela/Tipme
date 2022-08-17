//
//  ViewController.swift
//  Tipme
//
//  Created by Daniela Lima on 2022-07-04.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        //dismiss the keyboard when the user chooses one of the tip values
        billTextField.endEditing(true)
        
        //deselect all tip buttons via IBOutlets
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        //make the button that triggered the IBAction selected
        sender.isSelected = true
        
        //get the current title of the button that was pressed
        let buttonTitle = sender.currentTitle!
        
        //remove the last character (%) from the title then turn it back into a String
        let buttonTitleMinusPctSign = String(buttonTitle.dropLast())
        
        //turn the String into a Double
        let buttonTitleAsANumber = Double(buttonTitleMinusPctSign)!
        
        //divide the percent expressed out of 100 into a decimal e.g. 10 becomes 0.1
        tip = buttonTitleAsANumber / 100
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        //To make the stepper update the splitNumberLabel
        //Get the stepper value using sender.value, round it down to a whole number then set it as text
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        //set the numberOfPeople property as the value of the stepper as a whole number
        numberOfPeople = Int(sender.value)
        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
       
        //Get the text the user typed in the billTextField
        let bill = billTextField.text!
        //if the text is not and empty String ""
        if bill != "" {
            //turn the bill from a String e.g. "125.50" to an actual String with decimal places e.g. 125.50
            billTotal = Double(bill)!
            //multiply the bill by the tip % and divide by the number of people to split the bill
            let result = billTotal * (1 + tip) / Double(numberOfPeople)
            //round the result to 2 decimal places and turn it into a String
            finalResult = String(format: "%.2f", result)
        }
        
        //In Main.storyboard there is a segue between CalculatorVC and ResultsVC with the identifier "goToResults"
        //this line triggers the segue to happen (screen transition into ResultsVC)
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    //this method gets triggered just before the segue starts
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            //get hold of the instance of the destinationVC and type cast it to a ResultVC
            //as refers to Downcasting, and the exclamation mark refers to a forced Downcasting.
            //we have our UIViewController which is the superclass of the ResultViewController, so we can cast it down to our ResultViewController by writing the keyword as
            //when the segue destination is "goToResult", then the destination viewController that gets created is definitely going to be a ResultViewController.
            let destinationVC = segue.destination as! ResultsViewController
            
            //set the destination ResultsViewController's properties
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
        }
    }
}

