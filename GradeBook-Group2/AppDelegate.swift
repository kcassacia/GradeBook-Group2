//
//  AppDelegate.swift
//  GradeBook-Group2
//
//  Created by Yilin Zhao on 11/18/17.
//  Copyright © 2017 Yilin Zhao. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    var userID: String?
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate=self
    
        
        return true
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error{
            print("unable to log into Google",err)
            return
        }
        else{
            print("Logged into Google", user)
            guard let idtoken =  user.authentication.idToken else{return}
            guard  let accesstoken = user.authentication.accessToken else{return}
            
            let credential = GoogleAuthProvider.credential(withIDToken: idtoken, accessToken: accesstoken)
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let err = error{
                    print("fail to create firebase user with google account", err)
                    return
                }
                guard let uid = user?.uid else{return}
                print("successfully logged into firebase with google",uid)
                //write user in database
                let ref = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/")
                let userReference = ref.child("users").child(uid)
                userReference.updateChildValues(["email" : user?.email])

              //  let studentRef = userReference.child("studentID")
//                let value = ["id":010703030]
//                studentRef.updateChildValues(value)
            //    let assignmentListRef = studentRef.child("AssignmentList")
            
                
                

           
//                arrayOfStudents.append(astudent)
//                userReference.child(uid).setValue(arrayOfAssignments)
//                userReference.child(uid).setValue(arrayOfStudents)
                
            })
        }
    }

    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//        return GIDSignIn.sharedInstance().handle(url,
//                                                 sourceApplication: sourceApplication,
//                                                 annotation: annotation)
//        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//            // ...
//            if let error = error {
//                // ...
//                return
//            }
//
//            guard let authentication = user.authentication else { return }
//            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                           accessToken: authentication.accessToken)
//            // ...
//        }
//
//        func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
//            // Perform any operations when the user disconnects from app here.
//            // ...
//        }
//}
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {

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

