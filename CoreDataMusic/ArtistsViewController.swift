//
//  ArtistsViewController.swift
//  CoreDataMusic
//
//  Created by Jeff Gayle on 8/19/14.
//  Copyright (c) 2014 Jeff Gayle. All rights reserved.
//

import UIKit
import CoreData

class ArtistsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddArtistViewControllerDelegate {
    
    @IBOutlet weak var tableView : UITableView!
    
    var selectedLabel : Label?
    var artists = [Artist]()
    
    var myContext : NSManagedObjectContext!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.artists = self.selectedLabel!.artists.allObjects as [Artist]
        
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.myContext = appDelegate.managedObjectContext

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.artists.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("artistsCell", forIndexPath: indexPath) as UITableViewCell
        
        var artist = self.artists[indexPath.row]
        
        cell.textLabel.text = artist.firstName
        return cell
    }
    
    @IBAction func addArtistPressed(sender: AnyObject) {
        
        self.performSegueWithIdentifier("addArtist", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "addArtist" {
            let addArtistVC = segue.destinationViewController as AddArtistViewController
            addArtistVC.selectedLabel = self.selectedLabel
        } else if segue.identifier == "showSongs" {
            let songsVC = segue.destinationViewController as SongsViewController
            songsVC.selectedArtist = self.artists[self.tableView.indexPathForSelectedRow().row]
        }
    }
    
    func artistAdded() {
        var request = NSFetchRequest(entityName: "Artist")
        var error : NSError?
        self.artists = self.myContext.executeFetchRequest(request, error: &error) as [Artist]
        
        if error != nil {
            println(error?.localizedDescription)
        } else {
            self.tableView.reloadData()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
