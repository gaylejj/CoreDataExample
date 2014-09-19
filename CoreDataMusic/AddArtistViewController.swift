//
//  AddArtistViewController.swift
//  CoreDataMusic
//
//  Created by Jeff Gayle on 8/19/14.
//  Copyright (c) 2014 Jeff Gayle. All rights reserved.
//

import UIKit
import CoreData

protocol AddArtistViewControllerDelegate {
    func artistAdded()
}

class AddArtistViewController: UIViewController {
    
    var myContext : NSManagedObjectContext!
    var selectedLabel : Label?
    
    var delegate : AddArtistViewControllerDelegate?

    @IBOutlet weak var firstNameField: UITextField!
    
    @IBOutlet weak var lastNameField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        var labelContext = self.selectedLabel?.managedObjectContext
        var newArtist = NSEntityDescription.insertNewObjectForEntityForName("Artist", inManagedObjectContext: labelContext!) as Artist
        newArtist.firstName = self.firstNameField.text
        newArtist.lastName = self.lastNameField.text
        newArtist.label = self.selectedLabel!
        
        var error : NSError?
        labelContext?.save(&error)
        if error != nil {
            println(error?.localizedDescription)
        } else {
            self.delegate?.artistAdded()
            self.navigationController!.popToRootViewControllerAnimated(true)
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
