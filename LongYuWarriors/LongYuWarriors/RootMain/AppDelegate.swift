//
//  AppDelegate.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/5/17.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private(set) var safeSize: CGSize = .zero
    var currentVC: UIViewController?
    
    lazy var backBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 35, y: 10, width: 40, height: 40))
        btn.backgroundColor = UIColor.white
        btn.setImage(UIImage(named: "back_black"), for: .normal)
        btn.circularBead(size: nil, corner: nil)
        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return btn
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LYWarriorsHomeServiceVC(clousre: { [weak self] size in
            self?.safeSize = size
        })
        window?.makeKeyAndVisible()
        NotificationCenter.default.addObserver(self, selector: #selector(sceneUpdateRootNotification), name:NSNotification.Name(rawValue: LYWarriorsUpdateRootNotif), object: nil)
        setBackUI()
        return true
    }
    
    @objc func sceneUpdateRootNotification(noti: Notification) {
        backBtn.removeFromSuperview()
        if let VC = noti.object as? LYWarriorsHomeSceneVC{
            window?.rootViewController = VC
        }else if let VC = noti.object as? LYWarriorsChoosegRoleVC{
            window?.rootViewController = VC
        }else if let VC = noti.object as? LYWarriorsDuelDetailVC{
            window?.rootViewController = VC
        }
        setBackUI()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate{
    func setBackUI() {
        window?.addSubview(backBtn)
    }
    
    @objc func backAction() {
        if let _ = currentVC?.dismiss(animated: true, completion: nil) {
            currentVC?.dismiss(animated: true, completion: nil)
            currentVC = nil
        }
    }
}

