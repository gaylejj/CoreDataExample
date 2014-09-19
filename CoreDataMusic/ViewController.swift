//
//  ViewController.swift
//  CoreDataMusic
//
//  Created by Jeff Gayle on 8/19/14.
//  Copyright (c) 2014 Jeff Gayle. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    var myContext : NSManagedObjectContext!
    
    var fetchResultsController : NSFetchedResultsController!
    
    @IBOutlet weak var tableView : UITableView!
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get the Managed Object Context from app delegate
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.myContext = appDelegate.managedObjectContext
        
        //Setup Fetched Results Controller
        var request = NSFetchRequest(entityName: "Label")
        let sort = NSSortDescriptor(key: "name", ascending: true)
        
        //Add sort to the request
        request.sortDescriptors = [sort]
        request.fetchBatchSize = 20
        
        //Initialize Fetched Results Controller
        self.fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.myContext, sectionNameKeyPath: nil, cacheName: nil)
        
        self.fetchResultsController.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Perform fetch on appearance
        var error : NSError?
        self.fetchResultsController.performFetch(&error)
        if error != nil {
            println(error?.localizedDescription)
        }
    }

    @IBAction func addLabelPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("addLabel", sender: self)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("labelCell", forIndexPath: indexPath) as UITableViewCell
        
        //Move configure code to another method
        self.configureCell(cell, forIndexPath: indexPath)
        
        return cell
        
    }
    
    func configureCell(cell: UITableViewCell, forIndexPath indexPath: NSIndexPath) {
        var label = self.fetchResultsController.fetchedObjects![indexPath.row] as Label
        
        cell.textLabel!.text = label.name
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchResultsController.sections![section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showArtists" {
            let artistsVC = segue.destinationViewController as ArtistsViewController
            var label = self.fetchResultsController.fetchedObjects![self.tableView.indexPathForSelectedRow()!.row] as Label

            artistsVC.selectedLabel = label
        }
    }
    
    //MARK: Tableview Delete Rows
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        //Don't need to implement anything here, just need it for the respondsToSelector: test
    }
    
    func tableView(tableView: UITableView!, editActionsForRowAtIndexPath indexPath: NSIndexPath!) -> [AnyObject]! {
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete") { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            //Implement delete changes
            if let labelForRow = self.fetchResultsController.fetchedObjects![indexPath.row] as? Label {
                self.myContext.deleteObject(labelForRow)
                self.myContext.save(nil)
            }
        }
        
        let moreAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "More") { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            println("More Action Tapped")
        }
        moreAction.backgroundColor = UIColor.grayColor()
        
        //Set action background color
        deleteAction.backgroundColor = UIColor.redColor()
        
        //Return array of UITableViewRowActions
        return [deleteAction, moreAction]
    }
    
    //MARK: Fetched Results Controller Delegate Methods
    
    //Called when object is about to change
    func controllerWillChangeContent(controller: NSFetchedResultsController!) {
        self.tableView.beginUpdates()
    }
    
    //Called after a change is committed
    func controllerDidChangeContent(controller: NSFetchedResultsController!) {
        self.tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController!, didChangeObject anObject: AnyObject!, atIndexPath indexPath: NSIndexPath!, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath!) {
        
        switch type {
        case .Insert:
            self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        case .Delete:
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        case .Update:
            self.configureCell(self.tableView.cellForRowAtIndexPath(indexPath)!, forIndexPath: indexPath)
        case .Move:
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
//            self.tableView.moveRowAtIndexPath(indexPath, toIndexPath: newIndexPath)
            
        }
    }
    
    
    
    

}

