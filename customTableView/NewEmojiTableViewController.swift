//
//  NewEmojiTableViewController.swift
//  customTableView
//
//  Created by abdullah on 10.03.2024.
//

import UIKit

class NewEmojiTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let emoji = emoji {
            
             
            
            symbolTextField.text = emoji.symbol
            nameTextField.text = emoji.name
            descriptionTextField.text = emoji.description
            usageTextField.text = emoji.usage
        }
        
       
    }

    var emoji: Emoji?
    
    @IBOutlet var symbolTextField: UITextField!
    
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var descriptionTextField: UITextField!
    
    @IBOutlet var usageTextField: UITextField!
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "saveUnwind" else {
            return
        }
        
        emoji = Emoji(symbol: symbolTextField.text!, name: nameTextField.text!, description: descriptionTextField.text!, usage: usageTextField.text!)
        
    }
    

}
