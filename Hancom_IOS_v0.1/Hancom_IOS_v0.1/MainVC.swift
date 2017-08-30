//
//  MainVC.swift
//  Hancom_IOS_v0.1
//
//  Created by jwh on 2017. 8. 8..
//  Copyright © 2017년 jwh. All rights reserved.
//

import UIKit

class MainVC: UITableViewController{
    let apim = ApiManager()
   
    
    @IBOutlet var TV: UITableView!
    
    
  
    var autoPlanResult : [AutoPlanResultVO]?=[]{
        willSet(val){
            
            
            print("setting autotool")
            
        }didSet(val){
            print("reload")
            self.TV.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }

    @IBAction func refresh(_ sender: Any) {
        loadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadData(){
        apim.setApi(path: "/autoplanresult/\(UserDefaults.standard.string(forKey: "memberid")!)", method: .get, parameters: [:])
        apim.readAutoPlanResult{(testList) in
            if(testList.count != 0){
            print("here")
            self.autoPlanResult = testList
            }
        }
        sleep(1);
    }

    
   

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("gigi")
        let cell = tableView.dequeueReusableCell(withIdentifier: "AutoPlanResultCell", for: indexPath) as! AutoPlanResultCell
        print("gigi")
        cell.Registrant.text = self.autoPlanResult![indexPath.row].Registrant
        cell.start_date.text = self.autoPlanResult![indexPath.row].start_date
        cell.end_date.text = self.autoPlanResult![indexPath.row].end_date
        cell.Success.text = "\(self.autoPlanResult![indexPath.row].Pass_number!)"
        cell.Fail.text = "\(self.autoPlanResult![indexPath.row].Fail_number!)"
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return autoPlanResult!.count
    }
    
    
    
}
