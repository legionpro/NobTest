//
//  SceneDelegate.swift
//  OlehNobelTest
//
//  Created by OLEH POREMSKYY on 30.12.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        self.setUp()
        self.window?.makeKeyAndVisible()
        
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

    /// create controllers with dependency injection
    private func setUp() {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let model = ONTContactListModel()
        let viewController = storyboard.instantiateViewController(withIdentifier: "ONTContactsListTVC") as! ONTContactsListTVC
        let presenter = ONTContactListPresenter(viewController, model, ONTPeopleGroupManager())
        viewController.setPresenter(presenter)
        viewController.setModel(model)
        
        let emptyvc = storyboard.instantiateViewController(withIdentifier: "emptyvc")
        let tbvc = storyboard.instantiateViewController(withIdentifier: "UITabBArController") as! UITabBarController
        let navigationController = UINavigationController.init(rootViewController: viewController)
        tbvc.viewControllers = [emptyvc,navigationController]
        tbvc.selectedIndex = 1
        
        tbvc.tabBar.items![0].title = "EMPTY"
        tbvc.tabBar.items![0].image = UIImage(named:"empty")
        tbvc.tabBar.items![1].title = "CONTACTS"
        tbvc.tabBar.items![1].image = UIImage(named:"contacts")
        
        self.window?.rootViewController = tbvc

    }
    
}

