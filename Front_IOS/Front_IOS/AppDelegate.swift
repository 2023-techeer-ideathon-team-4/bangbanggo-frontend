//
//  AppDelegate.swift
//  Front_IOS
//
//  Created by 박다미 on 2023/05/26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Launch Screen을 보여줄 윈도우 생성 및 설정
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()

        // 1초 후에 실제 ViewController로 전환
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.showMainViewController()
        }

        return true
    }

    func showMainViewController() {
        let viewController = ViewController() // 적절히 ViewController의 초기화를 수행해야 함

        // 전환 애니메이션 등 설정 가능

        // ViewController로 전환
        window?.rootViewController = viewController
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

