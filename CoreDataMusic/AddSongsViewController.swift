//
//  AddSongsViewController.swift
//  CoreDataMusic
//
//  Created by Jeff Gayle on 8/19/14.
//  Copyright (c) 2014 Jeff Gayle. All rights reserved.
//

import UIKit
import CoreData

class AddSongsViewController: UIViewController {
    
    var selectedArtist : Artist?
    var myContext : NSManagedObjectContext!

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    var nf = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addSongPressed(sender: AnyObject) {
        
        var labelContext = self.selectedArtist?.managedObjectContext
        var newSong = NSEntityDescription.insertNewObjectForEntityForName("Song", inManagedObjectContext: labelContext) as Song
        newSong.name = self.nameField.text
        var yearNumber = nf.numberFromString(self.yearField.text)
        newSong.year = yearNumber!
        newSong.artist = self.selectedArtist!
        
        var error : NSError?
        labelContext?.save(&error)
        if error != nil {
            println(error?.localizedDescription)
        } else {
            self.navigationController.popToRootViewControllerAnimated(true)
            println(newSong.year)
            println(newSong.name)
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
