//
//  newStarViewController.swift
//  BigStar
//
//  Created by Alan Feng on 1/7/16.
//  Copyright © 2016 Alan Feng. All rights reserved.
//

import UIKit

protocol NewStarDelegate : NSObjectProtocol {
    func addStar(name:String,age:String)
}

class NewStarViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        
        delegate?.addStar(nameTextField.text!, age: ageTextField.text!)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    weak var delegate: NewStarDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
