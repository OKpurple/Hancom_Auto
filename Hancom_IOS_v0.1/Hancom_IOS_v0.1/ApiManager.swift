//
//  ApiManager.swift
//  Hancom_IOS_v0.1
//
//  Created by jwh on 2017. 8. 8..
//  Copyright © 2017년 jwh. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

//private let server = "http://211.253.8.229"
let server = "http://127.0.0.1:3000/api"
class ApiManager {
    
    private var url: String!
    private var method: HTTPMethod!
    private var parameters: Parameters!
    //private var header: HTTPHeaders!
    private let encode = URLEncoding.default
    
    
    public func setApi(path: String, method: HTTPMethod, parameters: Parameters){
        self.url = server + path
        self.method = method
        self.parameters = parameters
        
        print("url=\(url), method=\(method), parameters=\(parameters)")
    }
    
    public func createTest(meta: @escaping(Int)->Void){
        Alamofire.request(url,method: method, parameters: parameters, encoding: encode).responseJSON { (response) in
            print(response)
            switch(response.result){
                
            case .success(_):
                if let json = response.result.value{
                    let resp = JSON(json)
                    print(resp)
                    meta(resp["meta"]["code"].intValue)
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    public func reqLogin(meta: @escaping(Int)->Void){
        Alamofire.request(url,method: method, parameters: parameters, encoding: encode).responseJSON { (response) in
            switch(response.result){
            case .success(_):
                if let json = response.result.value{
                    let resp = JSON(json)
                    print(resp)
                    meta(resp["meta"]["code"].intValue)        
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    public func readAutoPlanResult(completion: @escaping([AutoPlanResultVO])->Void){
        Alamofire.request(url,method: method, parameters: parameters, encoding: encode).responseJSON { (response) in
            switch(response.result){
                
            case .success(_):
                if let json = response.result.value{
                    let resp = JSON(json)
                    print(resp)
                    let _data = resp["data"]
                    
                    var testList = [AutoPlanResultVO]()
                    for idx in 0..<_data.count{
                        let data = _data[idx]
                        let item = AutoPlanResultVO(Registrant: data["Registrant"].stringValue, empower: data["empower"].stringValue, Pass_number: data["Pass_number"].intValue, Fail_number: data["Fail_number"].intValue, NA_number: data["NA_number"].intValue, Ni_number: data["Ni_number"].intValue, All_number: data["All_number"].intValue, Status: data["Status"].stringValue, Action_date: data["Action_date"].stringValue, start_date: data["start_date"].stringValue, end_date: data["end_date"].stringValue)
                        testList += [item]
                    }
                    
                    completion(testList)
                    
                    
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    
    public func readAutoTool(completion: @escaping([AutoToolVO])->Void){
        Alamofire.request(url,method: method, parameters: parameters, encoding: encode).responseJSON { (response) in
            switch(response.result){
                
            case .success(_):
                if let json = response.result.value{
                    let resp = JSON(json)
                    print(resp)
                    let contents = resp["contents"]
                    
                    var autotool_list = [AutoToolVO]()
                    for idx in 0..<contents.count{
                        let content = contents[idx]
                        let autotool = AutoToolVO(s_no: content["s_no"].intValue, tool_name: content["tool_name"].stringValue, tool_filename: content["tool_filename"].stringValue, tool_folder: content["tool_folder"].stringValue, reg_date: content["reg_date"].stringValue, update_date: content["update_date"].stringValue, Ver: content["Ver"].intValue, ver_middle: content["ver_middle"].intValue, tool_uuid: content["tooluuid"].stringValue, registrant_name: content["registrant_name"].stringValue, tool_status: content["tool_status"].stringValue, memo: content["memo"].stringValue)
                        autotool_list += [autotool]
                    }
                    
                    completion(autotool_list)
                    
                    
                }
                break
            case .failure(_):
                break
            }
        }
    }
 
    
    
}
