//
//  CreateTestDetailVCViewController.swift
//  Hancom_IOS_v0.1
//
//  Created by jwh on 2017. 8. 29..
//  Copyright © 2017년 jwh. All rights reserved.
//

import UIKit

class CreateTestDetailVCViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
   
    @IBOutlet weak var Product: UITextField!
    
    @IBOutlet weak var Test_Plan_Step1: UITextField!
    
    @IBOutlet weak var Test_Plan_Step2: UITextField!
   
    @IBOutlet weak var Test_Plan_Step3: UITextField!

    @IBOutlet weak var Classfication: UITextField!
    
    @IBOutlet weak var start_date: UITextField!
    @IBOutlet weak var end_date: UITextField!
    
    let apim = ApiManager()
    var _product : String?
    var step1 : String?
    var step2 : String?
    var step3 : String?
    var _startDate : String?
    var _endDate : String?
    var _classfication : String?{
        willSet(val){
            if(val! == "HC Office"){
                ProductOption = ProductOption1
                step2Option = step2Option1
                step3Option = step3Option1
            }else if (val! == "Web Office"){
                ProductOption = ProductOption2
                step2Option = step2Option2
                step3Option = step3Option2
            }else if( val! == "ETC"){
                ProductOption = ProductOption2
                step2Option = step2Option3
                step3Option = step3Option2
            }
            tfDefault()
        }
    }
   
    
    var ClassficationOption = ["미선택","HC Office", "Web Office", "ETC"]
    var ProductOption : [String] = []
    var ProductOption1 = ["미선택","HShow","Hwp","Hword","HCell"]
    var ProductOption2 = ["미선택","show","write","calc","hwp"]
    
    var step1Option = ["미선택","auto"]
    
    var step2Option : [String] = []
    var step2Option1 = ["미선택","NEO","NEO2","2014VP","2010"]
    var step2Option2 = ["미선택","Netfice24","wqoa","Sparwd"]
    var step2Option3 = ["미선택","IOS","Android"]
    
    var step3Option : [String] = []
    var step3Option1 = ["미선택","BVT","Performance","1Hour"]
    var step3Option2 = ["미선택","BVT","Performance"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 화면 탭하면 키보드 꺼짐
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        let CpickerView = UIPickerView()
        CpickerView.tag = 1
        CpickerView.delegate = self
        
        let PpickerView = UIPickerView()
        PpickerView.tag = 2
        PpickerView.delegate = self
        
        let T1pickerView = UIPickerView()
        T1pickerView.tag = 3
        T1pickerView.delegate = self
        
        let T2pickerView = UIPickerView()
        T2pickerView.tag = 4
        T2pickerView.delegate = self
        
        let T3pickerView = UIPickerView()
        T3pickerView.tag = 5
        T3pickerView.delegate = self
        
        let toolBar = addDoneBtn()
        
        
        //DatePicker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.addTarget(self, action: #selector(CreateTestDetailVCViewController.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        let endDatePicker = UIDatePicker()
        endDatePicker.datePickerMode = UIDatePickerMode.date
        endDatePicker.addTarget(self, action: #selector(CreateTestDetailVCViewController.endDatePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        start_date.inputView = datePicker
        start_date.inputAccessoryView = toolBar
        
        end_date.inputView = endDatePicker
        end_date.inputAccessoryView = toolBar
        
        //PickerView - Options
        Classfication.inputView = CpickerView
        Product.inputView = PpickerView
        Test_Plan_Step1.inputView = T1pickerView
        Test_Plan_Step2.inputView = T2pickerView
        Test_Plan_Step3.inputView = T3pickerView
        
        
        
        Classfication.inputAccessoryView = toolBar
        Product.inputAccessoryView = toolBar
        Test_Plan_Step1.inputAccessoryView = toolBar
        Test_Plan_Step2.inputAccessoryView = toolBar
        Test_Plan_Step3.inputAccessoryView = toolBar
        
    }
    
    @IBAction func createTest(_ sender: Any) {
        
        apim.setApi(path: "/autoplanresult", method: .post, parameters: ["classfication":_classfication!, "product": _product!, "step1":step1!, "step2":step2!, "step3":step3!, "memberid":UserDefaults.standard.string(forKey: "memberid")!, "startDate":_startDate!, "endDate":_endDate!])
        apim.createTest{(success) in
            print("createTest")
            
            var _message:String?=""
            
            if(success == 0){
                _message="테스트가 등록되었습니다."
                
            }else{
               _message="테스트가 등록에 실패하였습니다."
            }
            var alert = UIAlertController(title: "알림", message: _message, preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
            alert.addAction(ok);
            alert.addAction(cancel);
            self.present(alert, animated: true);
            
        }
        
        
        
    }
    func datePickerValueChanged(sender: UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let _date = dateFormatter.string(from: sender.date)
        
        var datearr = _date.components(separatedBy: "/")
       
        var str = ("20\(datearr[2])-\(datearr[0])-\(datearr[1])")
        start_date.text = str
        _startDate = str
       
    }

    func endDatePickerValueChanged(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let _date = dateFormatter.string(from: sender.date)
        
        var datearr = _date.components(separatedBy: "/")
        
        var str = ("20\(datearr[2])-\(datearr[0])-\(datearr[1])")
        end_date.text = str
        _endDate = str
    }
    
    func tfDefault(){
        Product.placeholder = "Product"
        Test_Plan_Step1.placeholder = "Test_Plan_Step1"
        Test_Plan_Step2.placeholder = "Test_Plan_Step2"
        Test_Plan_Step3.placeholder = "Test_Plan_Step3"
    }
    
    func addDoneBtn() -> UIToolbar{
        
        let toolBar = UIToolbar();
        toolBar.sizeToFit()
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let flexBarButton1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                             target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: view, action: Selector("endEditing:"))
        
        toolBar.items = [flexBarButton1 ,flexBarButton, doneBarButton]
        return toolBar
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //Picker Delegate
    @available(iOS 2.0, *)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        print("picker view count")
        
        switch pickerView.tag {
        case 1:
            return ClassficationOption.count
        case 2:
            return ProductOption.count
        case 3:
            return step1Option.count
        case 4:
            return step2Option.count
        case 5:
            return step3Option.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) ->
        
        String? {
        print("picker view row")
            
        switch pickerView.tag {
        case 1:
            return ClassficationOption[row]
        case 2:
            return ProductOption[row]
        case 3:
            return step1Option[row]
        case 4:
            return step2Option[row]
        case 5:
            return step3Option[row]
        default:
            return nil
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print("picker view select")
        
        switch pickerView.tag {
        case 1:
            Classfication.text = ClassficationOption[row]
            _classfication = ClassficationOption[row]
        case 2:
            Product.text =  ProductOption[row]
            _product = ProductOption[row]
        case 3:
            Test_Plan_Step1.text = step1Option[row]
            step1 = step1Option[row]
        case 4:
            Test_Plan_Step2.text = step2Option[row]
            step2 = step2Option[row]
        case 5:
            Test_Plan_Step3.text = step3Option[row]
            step3 = step3Option[row]
        default:
            return
        }
    }
   
    
  

  
}
