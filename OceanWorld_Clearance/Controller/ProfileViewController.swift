//
//  ProfileViewController.swift
//  OceanWorld_Clearance
//
//  Created by Sanjay Mali on 06/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit

struct UserDetails:Decodable{
    let EmailID:String
    let LastName:String
    let firstName:String
    let CountryCode:String
    let MobileNumber:String
    let Password:String
    
}
class ProfileViewController: UIViewController,ShowAlertView{
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var updateBtn: UIButton!
    
    let loader = AppLoader()
    let app = AppColor()
    var userDefaultDetails = UserDefaultDetails()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = app.hexStringToUIColor(hex: "0D91CE")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        userinfoUpdate()
    }
    
    func userinfoUpdate(){
        loader.show();
        let data =  userDefaultDetails.getUserDetails()
        let jsonData = try? JSONSerialization.data(withJSONObject: data, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)!
        print(jsonString)
        let decoder = JSONDecoder()
        do {
            
            let data = jsonString.data(using: .utf8)!
            let json = try decoder.decode(UserDetails.self, from: data)
            nameLbl.text = json.firstName
            emailLbl.text = json.EmailID
            passwordLbl.text = json.Password
            mobileLbl.text = json.MobileNumber
            loader.dismiss()
        }catch{
            print(error.localizedDescription)
            loader.dismiss()
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateButton(_ sender: Any) {
        self.showSuccessAlert(title: "Success", message: "UserInfo Updated")
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        self.showlogoutAlert(title: "Logout", message: "Are you sure?")
    }
}
