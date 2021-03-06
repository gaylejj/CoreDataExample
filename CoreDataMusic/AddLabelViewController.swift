//
//  AddLabelViewController.swift
//  CoreDataMusic
//
//  Created by Jeff Gayle on 8/19/14.
//  Copyright (c) 2014 Jeff Gayle. All rights reserved.
//

import UIKit
import CoreData

class AddLabelViewController: UIViewController {

    @IBOutlet weak var labelNameField: UITextField!
    
    var myContext : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.myContext = appDelegate.managedObjectContext

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveLabelPressed(sender: AnyObject) {
        
        var newLabel = NSEntityDescription.insertNewObjectForEntityForName("Label", inManagedObjectContext: self.myContext) as Label
        newLabel.name = self.labelNameField.text
        var error : NSError?
        self.myContext.save(&error)
        if error != nil {
            println(error?.localizedDescription)
        }
        self.navigationController!.popToRootViewControllerAnimated(true)
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
