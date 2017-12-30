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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds);
        
        self.window?.backgroundColor = UIColor.white;
        
        let viewController:ViewController = ViewController();
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false;
        
        self.window?.rootViewController = viewController;
        
        self.window?.makeKeyAndVisible();
        
        print("AppDelegate.application():          Application launch complete");
        
        return true;
    }

    func applicationWillResignActive(_ application: UIApplication)    { return; }
    func applicationDidEnterBackground(_ application: UIApplication)  { return; }
    func applicationWillEnterForeground(_ application: UIApplication) { return; }
    func applicationDidBecomeActive(_ application: UIApplication)     { return; }
    func applicationWillTerminate(_ application: UIApplication)       { return; }
}

