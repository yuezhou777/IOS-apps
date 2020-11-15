//
//  ViewController.swift
//  LoginApp
//
//  Created by Ashisish on 11/6/20.
//

import UIKit
import Firebase
import SwiftSpinner
class ViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        
        let email = txtEmail.text
        let password = txtPassword.text
        
        if email == "" || password!.count < 6 {
            lblStatus.text = "Please enter email and correct password"
            return
        }
        if email?.isEmail == false {
            lblStatus.text = "Please enter valid e mail"
            return
        }
        
        SwiftSpinner.show("Logging in...")
        Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] authResult, error in
            SwiftSpinner.hide()
            guard let strongSelf = self else { return }
            
            if error != nil {
                strongSelf.lblStatus.text = error?.localizedDescription
                return
            }
            
            self?.txtPassword.text = ""
            
            // I have successfully logged in  go to Dashboard
            self!.performSegue(withIdentifier: "loginSegue", sender: strongSelf)
            
        }
        
        // Add User
        @IBAction func createUserAccount(_ sender: Any) {
            showTextInputPrompt(withMessage: "Email:") {  [weak self] userPressedOK, email in
              guard let strongSelf = self else { return }
              guard let email = email else {
                strongSelf.showMessagePrompt("email can't be empty")
                return
              }
              strongSelf.showTextInputPrompt(withMessage: "Password:") { userPressedOK, password in
                guard let password = password else {
                  strongSelf.showMessagePrompt("password can't be empty")
                  return
                }
                strongSelf.showSpinner {
                    
                  // create user account
                  Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    strongSelf.hideSpinner {
                      guard let user = authResult?.user, error == nil else {
                        strongSelf.showMessagePrompt(error!.localizedDescription)
                        return
                      }
                      print("\(user.email!) created")
                      strongSelf.navigationController?.popViewController(animated: true)
                    }
                  }
                    
                }
              }
            }
        }
        
        // Reset Email
        @IBAction func resetPassword(_ sender: Any) {
          showTextInputPrompt(withMessage: "Email:") { [weak self] userPressedOK, email in
            guard let strongSelf = self, let email = email else {
              return
            }
            strongSelf.showSpinner {
                
              // Send a email reset link
              Auth.auth().sendPasswordReset(withEmail: email) { error in
                strongSelf.hideSpinner {
                  if let error = error {
                    strongSelf.showMessagePrompt(error.localizedDescription)
                    return
                  }
                  strongSelf.showMessagePrompt("Sent")
                }
              }
                
            }
          }
        }
        
    }

}

