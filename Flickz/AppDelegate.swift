//
//  AppDelegate.swift
//  Flickz
//
//  Created by Vinu Charanya on 2/5/16.
//  Copyright © 2016 vnu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        addMoviesTabBar()
        return true
    }
    
    func addMoviesTabBar(){
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let nowPlayingNavigationController = storyboard.instantiateViewControllerWithIdentifier("FlickzNavigationController") as! UINavigationController
        let nowPlayingViewController = nowPlayingNavigationController.topViewController as! MoviesViewController
        nowPlayingViewController.moviesType = "now_playing"
        nowPlayingNavigationController.tabBarItem.title = "Now Playing"
        nowPlayingNavigationController.tabBarItem.image = UIImage(named: "now_playing2")
        
        let topRatedNavigationController = storyboard.instantiateViewControllerWithIdentifier("FlickzNavigationController") as! UINavigationController
        let topRatedViewController = topRatedNavigationController.topViewController as! MoviesViewController
        topRatedViewController.moviesType = "top_rated"
        topRatedNavigationController.tabBarItem.title = "Top Rated"
        topRatedNavigationController.tabBarItem.image = UIImage(named: "RatingStarSimple")
        
        let popularNavigationController = storyboard.instantiateViewControllerWithIdentifier("FlickzNavigationController") as! UINavigationController
        let popularViewController = popularNavigationController.topViewController as! MoviesViewController
        popularViewController.moviesType = "popular"
        popularNavigationController.tabBarItem.title = "Popular"
        popularNavigationController.tabBarItem.image = UIImage(named: "popular2")
        
        let upcomingNavigationController = storyboard.instantiateViewControllerWithIdentifier("FlickzNavigationController") as! UINavigationController
        let upcomingViewController = upcomingNavigationController.topViewController as! MoviesViewController
        upcomingViewController.moviesType = "upcoming"
        upcomingNavigationController.tabBarItem.title = "Upcoming"
        upcomingNavigationController.tabBarItem.image = UIImage(named: "upcoming")

        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nowPlayingNavigationController, topRatedNavigationController, popularNavigationController, upcomingNavigationController]
        
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().barTintColor = UIColor.blackColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.cyanColor()]
        UINavigationBar.appearance().tintColor = UIColor.cyanColor()
        UITabBar.appearance().tintColor = UIColor.cyanColor()
        UITabBar.appearance().barTintColor = UIColor.blackColor()
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

