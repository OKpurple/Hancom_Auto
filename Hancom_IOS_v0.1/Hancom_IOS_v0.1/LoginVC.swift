//
//  LoginVC.swift
//  Hancom_IOS_v0.1
//
//  Created by jwh on 2017. 8. 8..
//  Copyright © 2017년 jwh. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var login_id_tf: UITextField!
    @IBOutlet weak var login_pw_tf: UITextField!
    
    let apim = ApiManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    @IBAction func login(_ sender: Any) {
        apim.setApi(path: "/staff/signin", method: .post, parameters: ["memberid":login_id_tf.text!,"pw":login_pw_tf.text!]);
        
        apim.reqLogin{(success) in
            
            if(success == 0){
                UserDefaults.standard.set(self.login_id_tf.text!, forKey: "memberid")
                self.performSegue(withIdentifier: "loginSegue", sender: self)
                
            }else{
            
                var alert = UIAlertController(title: "알림", message: "ID/PW 확인해주세요", preferredStyle: UIAlertControllerStyle.alert)
                var ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                var cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
                alert.addAction(ok);
                alert.addAction(cancel);
                self.present(alert, animated: true);
            }
        }
    }
   

}
