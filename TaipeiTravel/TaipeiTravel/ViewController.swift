//
//  ViewController.swift
//  TaipeiTravel
//
//  Created by Alan Feng on 1/7/16.
//  Copyright © 2016 Alan Feng. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Hotel {
    var title:String
    var address:String
}

class ViewController: UITableViewController {
    
    var currentPage = 1;
    var per_page = 25;
    var dataArray = [Hotel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
    }
    
    func loadData() {
    
        let offset = (currentPage-1)*per_page
        
        let url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=6f4e0b9b-8cb1-4b1d-a5c4-febd90f62469&limit=\(per_page)&offset=\(offset)"
        
        Alamofire.request(.GET, url).responseJSON { response in
            switch response.result {
            case .Success(let data):
                let json = JSON(data)
                let resultJson = json["result"]["results"]
                
                for (index,subJson):(String, JSON) in resultJson {
                    print(index)
                    
                    let title = subJson["stitle"].stringValue
                    let address = subJson["address"].stringValue
                    
                    let hotel = Hotel(title: title, address: address)
                    
                    self.dataArray.append(hotel)
                }
                
                self.tableView.reloadData()
                self.currentPage++
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: TableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let hotel = dataArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = hotel.title
        cell.detailTextLabel?.text = hotel.address
        
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row == (dataArray.count-1)) {
            self.loadData()
        }
    }
}

