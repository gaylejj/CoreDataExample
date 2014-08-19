//
//  ViewController.swift
//  CoreDataMusic
//
//  Created by Jeff Gayle on 8/19/14.
//  Copyright (c) 2014 Jeff Gayle. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddLabelDelegate {
    
    var myContext : NSManagedObjectContext!
    
    var labels = [Label]()
    
    @IBOutlet weak var tableView : UITableView!
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.myContext = appDelegate.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Label")
        var error : NSError?
        self.labels = self.myContext.executeFetchRequest(request, error: &error) as [Label]
        
        if error != nil {
            println(error?.localizedDescription)
        } else {
            self.tableView.reloadData()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addLabelPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("addLabel", sender: self)
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("labelCell", forIndexPath: indexPath) as UITableViewCell
        
        var label = self.labels[indexPath.row]
        
        cell.textLabel.text = label.name
        
        return cell
        
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.labels.count
    }
    
    func labelAdded() {
        var request = NSFetchRequest(entityName: "Label")
        var error : NSError?
        self.labels = self.myContext.executeFetchRequest(request, error: &error) as [Label]
        
        if error != nil {
            println(error?.localizedDescription)
        } else {
            self.tableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "addLabel" {
            let addLabelVC = segue.destinationViewController as AddLabelViewController
            addLabelVC.delegate = self
        } else if segue.identifier == "showArtists" {
            let artistsVC = segue.destinationViewController as ArtistsViewController
            artistsVC.selectedLabel = self.labels[self.tableView.indexPathForSelectedRow().row]
        }
    }

}

