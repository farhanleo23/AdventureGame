//
//  ViewController.swift
//  InteractiveStory
//
//  Created by Farhan Hussain on 9/24/16.
//  Copyright © 2016 maypalo. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    
     enum error: Error {
        case NoName
    }

    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var textFieldBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // setting up observer for NSNotficationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(notificaiton:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil) // UIKeyboardWillShowNotification has been remaned in swift
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillReturn(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil) // makes the textField go back to its position
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startAdventure" {
            
            }
            
            do
            {
                if let name = nameTextField.text  {
                    if name == "" {
                        throw error.NoName
                    }
                    if let PageController = segue.destination as? PageController {
                        PageController.page = Adventure.story(name: name)
                }
                
            }
            } catch error.NoName { // creating Alert below
                let alertController = UIAlertController(title: "Name not Provided", message: "Provide a name", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                present(alertController, animated: true, completion: nil)
            } catch let error {
                fatalError("\(error)")
                
        }
    }
    
    func keyboardWillShow(notificaiton: NSNotification) {
        
        // makes the textField go up (changes the constraints
        if let userInfoDict = notificaiton.userInfo, let keyboardframeValue = userInfoDict[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardframeValue.cgRectValue
            
           // makes the textField animate by going up
            UIView.animate(withDuration: 0.8) {
                self.textFieldBottomConstraint.constant = keyboardFrame.size.height + 10
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // UIKeyboardWillReturn reverse the above for bringing the keyboard done
    
    func keyboardWillReturn(notification: NSNotification) {
        if let userInfoDict = notification.userInfo, let keyboardFrameValue = userInfoDict[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardFrameValue.cgRectValue
            
            UIView.animate(withDuration: 0.8) {
                self.textFieldBottomConstraint.constant = keyboardFrame.size.height - 150
                self.view.layoutIfNeeded()
            }
        }
        
    }

   /* this method is required for previous versions not iOS 9 and above
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    } */
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder() // gets rid of the keyboard
        
        return true
    }
}


















