//
//  ViewController.swift
//  CardGame
//
//  Created by Alan Feng on 1/7/16.
//  Copyright © 2016 Alan Feng. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Card {
    var title:String
    var description:String
    var imageUrl:String
}

class ViewController: UIViewController,UIPageViewControllerDataSource {

    var pageViewController:PageViewController!
    var cardArray = [Card]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SVProgressHUD.show()
        loadDataFromServer()
    }
    
    func loadDataFromServer() {
        
        SVProgressHUD.show()
        
        let url = "http://bossbomb.cc/bossbomb/feed/getCards"
        Alamofire.request(.GET, url).responseJSON { response in
            switch response.result {
            case .Success(let data):
                let json = JSON(data)
                let resultJson = json["result"]
                
                for (index,subJson):(String, JSON) in resultJson {
                    print(index)
                    
                    let title = subJson["title"].stringValue
                    let description = subJson["description"].stringValue
                    let imageUrl = subJson["imageUrl"].stringValue
                    
                    let card = Card(title: title, description: description, imageUrl: imageUrl)
                    
                    self.cardArray.append(card)
                }
                
                self.showPageViewController()

            case .Failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    func showPageViewController() {
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! PageViewController
        
        self.pageViewController.dataSource = self
        
        let initalViewController = self.viewControllerAtIndex(0) as CardViewController
        
        let viewControllers = [initalViewController]
        
        self.pageViewController.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let viewController = viewController as! CardViewController
        var index = viewController.pageIndex as Int
        
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        
        index--
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let viewController = viewController as! CardViewController
        var index = viewController.pageIndex as Int
        
        if (index == NSNotFound) {
            return nil
        }
        
        index++
        
        if (index == cardArray.count) {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return cardArray.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
    
    func viewControllerAtIndex(index:Int) -> CardViewController {
        
        let card = cardArray[index]
        
        let viewController : CardViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CardViewController") as! CardViewController
        
        viewController.card = card
        viewController.pageIndex = index
        viewController.delegate = self
        
        return viewController
    }
    
    func setViewControllerAtIndex(index:Int) {
        
        let contolller = viewControllerAtIndex(index)
        
        let direction : UIPageViewControllerNavigationDirection!
        
        if currentIndex < index {
            direction = UIPageViewControllerNavigationDirection.Forward
        }
        else {
            direction = UIPageViewControllerNavigationDirection.Reverse
        }

        currentIndex = index
        self.pageViewController.setViewControllers([contolller], direction: direction, animated: true, completion: nil)
        
    }
}

extension ViewController : CardViewControllerProtocol {
    
    func pickRandomCard() {
        
        let randomNumber = Int(arc4random_uniform(UInt32(cardArray.count)))
        setViewControllerAtIndex(randomNumber)
    }
}
