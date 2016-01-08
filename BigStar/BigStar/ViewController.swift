//
//  ViewController.swift
//  BigStar
//
//  Created by Alan Feng on 1/7/16.
//  Copyright © 2016 Alan Feng. All rights reserved.
//

import UIKit

struct Star {
    var name:String
    var age:String
}

class ViewController: UITableViewController {

    var dataArray = [Star]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let star1 = Star(name: "Alan",age: "32")
        let star2 = Star(name: "Joe",age: "33")
        
        dataArray = [star1, star2]
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
            switch editingStyle {
            case .Delete:
                // remove the deleted item from the model
                self.dataArray.removeAtIndex(indexPath.row)
                
                // remove the deleted item from the `UITableView`
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            default:
                return
            }
    }
    
    override func tableView(tableView: UITableView,
        moveRowAtIndexPath sourceIndexPath: NSIndexPath,
        toIndexPath destinationIndexPath: NSIndexPath) {
            let val = self.dataArray.removeAtIndex(sourceIndexPath.row)
            self.dataArray.insert(val, atIndex: destinationIndexPath.row)
    }
    
    //MARK: TableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let star = dataArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = star.name
        cell.detailTextLabel?.text = star.age
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "addStarSegue" {
            let vc = segue.destinationViewController as! NewStarViewController
            vc.delegate = self
        }
    }
}

extension ViewController : NewStarDelegate {
    
    func addStar(name:String,age:String) {
        let star = Star(name: name, age: age)
        self.dataArray.append(star)
        
        self.tableView.reloadData()
    }
}

