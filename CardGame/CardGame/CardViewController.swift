//
//  CardViewController.swift
//  CardGame
//
//  Created by Alan Feng on 1/7/16.
//  Copyright © 2016 Alan Feng. All rights reserved.
//

import UIKit

protocol CardViewControllerProtocol: NSObjectProtocol {
    func pickRandomCard()
}

class CardViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func pickARandomCard(sender: AnyObject) {
        
        if delegate != nil {
            delegate?.pickRandomCard()
        } else {
            let alert = UIAlertController(title: "Alert", message: "Delegate not set.", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    var card:Card?
    var pageIndex: Int!
    
    weak var delegate: CardViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let myCard:Card = self.card! {
            titleLabel.text = myCard.title
            descriptionLabel.text = myCard.description
            imageView.yy_setImageWithURL(NSURL(string: myCard.imageUrl), placeholder: UIImage(named: "imagePlaceHolder"))
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
