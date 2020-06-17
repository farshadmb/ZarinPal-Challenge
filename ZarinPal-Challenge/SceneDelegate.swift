//
//  SceneDelegate.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    let authentication = AuthenticationService()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        
        print(#function,connectionOptions)
        
        var items = [RepositoryData]()
        let fakeBranche = RepositoryData.BranchData(title: "Branch", createdDate: Date(timeIntervalSinceNow: -100), updateDate: Date())
        let fakeIssue = RepositoryData.IssueData(number: "1", title: "Issue", date: Date(timeIntervalSinceNow: -50), description: "Issue Description")
        let fakePR = RepositoryData.PullRequestData(number: "#2", title: "Issue", date: Date(timeIntervalSinceNow: -40), description: "PR Description")
        
        for i in 0...20 {
            
            var respository = RepositoryData(title: "Repo Name \(i)", description: i % 2 == 0 ? nil : "Repo Desc")
            respository.branches = i % 3 == 0 ? Array(repeating:fakeBranche , count: 5) : []
            respository.pullRequests = i % 4 == 0 ? Array(repeating: fakePR, count: 5) : []
            respository.issues = i % 5 == 0 ? Array(repeating: fakeIssue, count: 5) : []
            
            items.append(respository)
        }
        
        let contentView = UserRepositoryListView(items: items)

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            _ = self.authentication.requestClientAuthorize(credential: AppConfig.clientCredetianl)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print(#function,URLContexts)
        guard let url = URLContexts.first?.url else { return }
        
        let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
        if queryItems?.contains(where: { $0.name == "error" }) == true  {
            
            let alert = UIAlertController(title: queryItems?.first(where: { $0.name == "error" })?.value,
                              message: queryItems?.first(where: { $0.name == "error_description" })?.value,
                              preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            UIApplication.shared.windows.first(where: { $0.isKeyWindow })?
                .rootViewController?.present(alert, animated: true, completion: nil)
            
        }else if let code = queryItems?.first(where: { $0.name == "code"}), let codeValue = code.value  {
            _ = authentication.requestAccessToken(with: codeValue, client: AppConfig.clientCredetianl).subscribe()
        }
    }


}

