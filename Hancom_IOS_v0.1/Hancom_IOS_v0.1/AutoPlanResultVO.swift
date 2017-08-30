//
//  AutoPlanResultVO.swift
//  Hancom_IOS_v0.1
//
//  Created by jwh on 2017. 8. 31..
//  Copyright © 2017년 jwh. All rights reserved.
//

import Foundation
class AutoPlanResultVO{
    var Registrant : String?
    var empower : String?
    var Pass_number : Int?
    var Fail_number : Int?
    var NA_number : Int?
    var Ni_number : Int?
    var All_number : Int?
    var Status : String?
    var Action_date : String?
    var start_date : String?
    var end_date : String?
    
    init(Registrant : String?,
    empower : String?,
    Pass_number : Int?,
    Fail_number : Int?,
    NA_number : Int?,
    Ni_number : Int?,
    All_number : Int?,
    Status : String?,
    Action_date : String?,
    start_date : String?,
    end_date : String?) {
        self.Registrant = Registrant
        self.empower = empower
        self.Pass_number = Pass_number
        self.Fail_number = Fail_number
        self.NA_number = NA_number
        self.Ni_number = Ni_number
        self.All_number = All_number
        self.Status = Status
        self.Action_date = Action_date
        self.Status = start_date
        self.end_date = end_date
        self.start_date = start_date
    }
    
}
