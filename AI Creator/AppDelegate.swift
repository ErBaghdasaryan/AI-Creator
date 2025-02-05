//
//  AppDelegate.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 16.01.25.
//

import UIKit
import ApphudSDK
import AICreatorViewModel

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appStorageService = AppStorageService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Apphud.start(apiKey: "app_LU4DsfPj9sGxEb9VoW6Boe2QR37c52")
        Apphud.setDeviceIdentifiers(idfa: nil, idfv: UIDevice.current.identifierForVendor?.uuidString)

        let appHudUserId = Apphud.userID()
        self.appStorageService.saveData(key: .apphudUserID, value: appHudUserId)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

