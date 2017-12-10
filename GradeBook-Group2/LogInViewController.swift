//
//  LogInViewController.swift
//  GradeBook-Group2
//
//  Created by Yilin Zhao on 11/18/17.
//  Copyright © 2017 Yilin Zhao. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
class LogInViewController: UIViewController,GIDSignInUIDelegate {
@IBOutlet weak var signInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("here")
        
        // Do any additional setup after loading the view.
        // add google sign button
        setupGoogleButton()
    }
    fileprivate func setupGoogleButton(){
    let googleButton = GIDSignInButton()
    googleButton.frame=CGRect(x:16,y:600,width:view.frame.width-32,height: 50)
    view.addSubview(googleButton)
    GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signOut()
    }
//    @IBAction func nextdidtapped(_ sender: UIButton) {
//        performSegue(withIdentifier: "toMain", sender: self)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    */


