//
//  SceneDelegate.swift
//  Project7
//
//  Created by Joe Pham on 2021-01-17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // Insert a second tab bar using AppDelegate -> SceneDelegate from iOS 13
        // This let's us use the same class w/o duplicating the screen in Storyboard
        
        if let tabBarController = window?.rootViewController as? UITabBarController {
            // 2. Create a new ViewController programmatically, using current app bundle
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // 3. Create the new similar nav controller using the storyboard ID same as the one in Main.storyboard
            let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
            // 4. Add a tab bar item to this nav controller
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
            // 5. Add the new view controller to this tab bar controller's current visible tabs via the viewControllers array
            tabBarController.viewControllers?.append(vc)
            
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

