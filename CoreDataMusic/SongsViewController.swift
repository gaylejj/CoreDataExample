//
//  SongsViewController.swift
//  CoreDataMusic
//
//  Created by Jeff Gayle on 8/19/14.
//  Copyright (c) 2014 Jeff Gayle. All rights reserved.
//

import UIKit

class SongsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView : UITableView!
    
    var songs = [Song]()
    var selectedArtist : Artist?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.songs = self.selectedArtist!.songs.allObjects as [Song]


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("songCell", forIndexPath: indexPath) as UITableViewCell
        
        var song = self.songs[indexPath.row]
        
        cell.textLabel!.text = song.name
        println(song.year)
//        var nf = NSNumberFormatter()
//        var songYear = nf.stringFromNumber(song.year)
        cell.detailTextLabel!.text = "\(song.year)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songs.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "addSong" {
            let addSongVC = segue.destinationViewController as AddSongsViewController
            addSongVC.selectedArtist = self.selectedArtist
        }
    }
    
    @IBAction func addSongPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("addSong", sender: self)
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
