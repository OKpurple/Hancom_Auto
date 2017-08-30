//
//  ViewController.swift
//  Hancom_IOS_v0.1
//
//  Created by jwh on 2017. 7. 25..
//  Copyright © 2017년 jwh. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class ViewController: UIViewController {

    private let server = "http://211.253.8.229:8080"
    
    
    
    @IBOutlet weak var testLB2: UILabel!
    @IBOutlet weak var testLB1: UILabel!
    @IBOutlet weak var testLB: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func testBtnAction(_ sender: Any) {
        let url = server+"/list"
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default).responseJSON{
            (response) in
            switch(response.result){
            case .success(_):
                if let json = response.result.value{
                    let resp = JSON(json)
                    print(resp)
                    self.testLB.text = resp[0]["name"].stringValue
                    self.testLB1.text = resp[1]["name"].stringValue
                    self.testLB2.text = resp[2]["name"].stringValue
                    //meta(resp["success"].intValue)
                    
                }
                break
            case .failure(_):
                print("fail")
                break
            
            }
        }
        
    }

}

