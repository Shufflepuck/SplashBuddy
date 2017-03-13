//
//  AppDelegate.swift
//  SplashBuddy
//
//  Created by ftiff on 02/08/16.
//  Copyright © 2016 François Levaux-Tiffreau. All rights reserved.
//

import Cocoa



@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    
    var softwareStatusValueTransformer: SoftwareStatusValueTransformer?
    var mainWindowController: MainWindowController!
    var backgroundController: BackgroundWindowController!
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {

        
        
        // Value Transformer for Software Status
        // We use it to map the software status (.pending…) with color images (orange…) in the Software TableView
        
        softwareStatusValueTransformer = SoftwareStatusValueTransformer()
        ValueTransformer.setValueTransformer(softwareStatusValueTransformer,
                                             forName: NSValueTransformerName(rawValue: "SoftwareStatusValueTransformer"))
        
        
        
        // Create Main Controller (the front window)
        
        let storyboard = NSStoryboard(name: "SplashBuddy", bundle: nil)
        mainWindowController = storyboard.instantiateController(withIdentifier: "mainWindow") as! MainWindowController
        mainWindowController.showWindow(self)
        
        
        
        
        // Create Background Controller (the window behind) only displays for Release
        // Change this in Edit Scheme -> Run -> Info
        
        #if !DEBUG
        backgroundController = storyboard.instantiateController(withIdentifier: "backgroundWindow") as! BackgroundWindowController
        backgroundController.showWindow(self)
        #endif


        
        // Get preferences from UserDefaults
        Preferences.sharedInstance.getPreferencesApplications()
        Parser.sharedInstance.readTimer()
        

    }
    

 }

