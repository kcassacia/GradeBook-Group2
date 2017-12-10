//
//  CategoryViewController.swift
//  GradeBook-Group2
//
//  Created by Yilin Zhao on 11/26/17.
//  Copyright © 2017 Yilin Zhao. All rights reserved.
//

import UIKit
import Firebase

class CategoryViewController: UIViewController {

    @IBOutlet weak var WeightOfCategoryTextField: UITextField!
    @IBOutlet weak var NameOfCategoryTextField: UITextField!
    @IBAction func backdidtapped(_ sender: Any) {
        performSegue(withIdentifier: "categoryBackToMain", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addCategorydidtapped(_ sender: Any) {
        print("add category did tapped")
        let userid = Firebase.Auth.auth().currentUser?.uid
        var name = NameOfCategoryTextField.text
        guard let weight: Int? = Int(WeightOfCategoryTextField.text!) else{return}
        let ref = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/")
        let value = ["weight":weight]
        ref.child("users").child(userid!).child("Category").child(name!).setValue(value)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
