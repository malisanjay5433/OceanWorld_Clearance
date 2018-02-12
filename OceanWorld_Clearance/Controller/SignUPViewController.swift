//
//  SignInViewController.swift
//  OceanWorld_Clearance
//
//  Created by Sanjay Mali on 07/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//
import UIKit
struct Signup:Decodable{
    var db_status:Bool
    var db_msg:String
}

class SignUPViewController: UIViewController,ShowAlertView,UITextFieldDelegate{
    @IBOutlet weak var fnameTxt: UITextField!
    @IBOutlet weak var lnameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var mobileTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var countryNumberTxt: UITextField!
    var userDefaultDetails = UserDefaultDetails()
    var navigationControllers = NavigationControllers()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fnameTxt.delegate = self
        self.lnameTxt.delegate = self
        self.emailTxt.delegate = self
        self.passwordTxt.delegate = self
        self.countryNumberTxt.delegate = self
        self.mobileTxt.delegate = self
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    @IBAction func signUPButton(_ sender: Any) {
        if fnameTxt.text == ""{
            self.showAlert(message: "Enter First Name")
            
        }else if lnameTxt.text == ""{
            //            print("Enter Last Name")
            self.showAlert(message: "Enter Last Name")
        }else if emailTxt.text == "" {
            print("Enter Email")
            self.showAlert(message: "Enter Email ID")
        }
        if !(isValidEmail(testStr: emailTxt.text!)){
            self.showAlert(message: "Enter Enter Valid Emaild ID ")
        }
        else if countryNumberTxt.text == "" || mobileTxt.text == ""{
            self.showAlert(message: "Enter Country Code/Mobile Number Missing ")
        }
        else if passwordTxt.text == ""{
            print("Enter Password")
            self.showAlert(message: "Enter Password")
        }
        else{
            //            let app = AppColor()
            
            //            Userinfo Save here
            let dic = ["firstName":"\(self.fnameTxt.text!)",
                "LastName":"\(self.lnameTxt.text!)",
                "MobileNumber":"\(self.mobileTxt.text!)",
                "CountryCode":"\(self.countryNumberTxt.text!)",
                "Password":"\(self.passwordTxt.text!)",
                "EmailID":"\(self.emailTxt.text!)"]
            self.userDefaultDetails.saveUserDetails(dic:dic)
            let loader = AppLoader()
            loader.show();
            let url = "http://apiocean20180207065702.azurewebsites.net/api/ocean/usr_signup"
            let paramString = "usrr_fnm=\(fnameTxt.text!)" + "&usrr_lnm=\(lnameTxt.text!)" + "&usrr_mb_pfx=\(countryNumberTxt.text!)" + "&usrr_mb_no=\(mobileTxt.text!)" + "&usrr_pfl=-" + "&usrr_psw=\(passwordTxt.text!)" + "&usrr_eml=\(emailTxt.text!)"
            DataManager.getJSONFromURL(url, param:paramString, completion: { (data, error) in
                
                
                let decoder = JSONDecoder()
                do {
                    let json = try decoder.decode(Signup.self, from: data!)
                    print(json)
                    if json.db_status == true{
                        self.userDefaultDetails.loggedIN()
                        DispatchQueue.main.async {
                            self.navigationControllers.navigateLoginTabbar()
                        }
                    }else{
                        self.showAlert(message:json.db_msg)
                        loader.dismiss()
                    }
                }catch{
                    print(error.localizedDescription)
                    loader.dismiss()
                }
            })
            
        }
        
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
}
