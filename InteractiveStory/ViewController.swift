//
//  ViewController.swift
//  InteractiveStory
//
//  Created by Farhan Hussain on 9/24/16.
//  Copyright © 2016 maypalo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startAdventure" {
            if let PageController = segue.destination as? PageController {
                PageController.page = Adventure.story
            }
        }
    }

}

