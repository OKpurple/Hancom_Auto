//
//  AutoToolVO.swift
//  Hancom_IOS_v0.1
//
//  Created by jwh on 2017. 8. 8..
//  Copyright © 2017년 jwh. All rights reserved.
//

import Foundation
class AutoToolVO{
    var s_no : Int?
    var tool_name : String?
    var tool_filename : String?
    var tool_folder : String?
    var reg_date : String?
    var update_date : String?
    var Ver : Int?
    var ver_middle : Int?
    var tool_uuid : String?
    var registrant_name : String?
    var tool_status : String?
    var memo : String?
    
    init(s_no : Int?, tool_name : String?, tool_filename : String?, tool_folder : String?, reg_date : String?, update_date : String?, Ver : Int?, ver_middle : Int?, tool_uuid : String?, registrant_name : String?, tool_status : String?, memo : String?){
        self.s_no=s_no
        self.tool_name=tool_name
        self.tool_filename=tool_filename
        self.tool_folder=tool_folder
        self.reg_date=reg_date
        self.update_date=update_date
        self.Ver=Ver
        self.ver_middle=ver_middle
        self.tool_uuid=tool_uuid
        self.registrant_name=registrant_name
        self.tool_status=tool_status
        self.memo=memo
    }
}
