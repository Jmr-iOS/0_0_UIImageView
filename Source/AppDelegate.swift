//
//  AppDelegate.swift
//  0_0 - Empty Template (Swift)
//
//  URL: http://stackoverflow.com/questions/24046898/how-do-i-create-a-new-swift-project-without-using-storyboards
//  URL: http://stackoverflow.com/questions/24030348/how-to-create-a-button-programmatically
//  URL: http://stackoverflow.com/questions/24102191/make-a-uibutton-programatically-in-swift
//
// ?: http://stackoverflow.com/questions/26569371/how-do-you-create-a-uiimage-view-programmatically-swift
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds);
        
        self.window?.backgroundColor = UIColor.whiteColor();
        
        let viewController:ViewController = ViewController();
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false;
        
        self.window?.rootViewController = viewController;
        
        self.window?.makeKeyAndVisible();
        
        print("AppDelegate.application():          Application launch complete");
        
        return true;
    }

    func applicationWillResignActive(application: UIApplication)    { return; }
    func applicationDidEnterBackground(application: UIApplication)  { return; }
    func applicationWillEnterForeground(application: UIApplication) { return; }
    func applicationDidBecomeActive(application: UIApplication)     { return; }
    func applicationWillTerminate(application: UIApplication)       { return; }
}

