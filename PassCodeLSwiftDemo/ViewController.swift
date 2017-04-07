//
//  ViewController.swift
//  PassCodeLSwiftDemo
//
// Created by s-sakurai on 2017/04/07.
//  Copyright © 2017年 s-sakurai. All rights reserved.
//

import UIKit
import PassCodeL

enum Section:Int{
    case index1
    case index2
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let kSectionIndex1 = 0
    let kSectionIndex2 = 1
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var sectionArray:[(title:String,rowCount:Int)] = [("PassCode",3),("TouchID",1)]
    //パスコード
    var config: PassCodeLConfig
    
    required init?(coder aDecoder: NSCoder) {
        let passCodeHelper = DemoModelHelper()
        self.config = DemoConfig(model: passCodeHelper)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = defaultColor
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Event
    func setPassCode(_ sender: UISwitch) {
        
        let passcodeVC: PassCodeLViewController
        
        if sender.isOn == true{
            passcodeVC = PassCodeLViewController(mode:.setPassCode , config: config)
            let value:Bool = sender.isOn
            passcodeVC.dismissCompletionCallback = { [weak self] in
                if self!.config.passCodeL.hasPassCode != sender.isOn {
                    sender.isOn = !(value)
                }
                self!.tableView.reloadData()
            }
            tableView.reloadData()
        } else {
            passcodeVC = PassCodeLViewController(mode:.removePassCode, config: config)
            let value:Bool = sender.isOn
            
            passcodeVC.successCallback = { lock in
                
                lock.model.deletePassCode()
                lock.model.deleteTouchID()
                sender.isOn = false
                self.tableView.reloadData()
                return
            }
            
            passcodeVC.dismissCompletionCallback = { [weak self] in
                if self!.config.passCodeL.hasPassCode != sender.isOn {
                    sender.isOn = !(value)
                }
                self!.tableView.reloadData()
            }
        }
        
        present(passcodeVC, animated: true, completion: nil)
        
    }
    
    func changePassCode() {
        
        guard self.config.passCodeL.hasPassCode else {
            return
        }
        
        let passcodeVC: PassCodeLViewController
        passcodeVC = PassCodeLViewController(mode:.changePassCode , config: config)
        tableView.reloadData()
        
        present(passcodeVC, animated: true, completion: nil)
        
    }
    
    func touchIDValueChanged(_ sender: UISwitch) {
        
        if sender.isOn {
            self.config.passCodeL.saveTouchID("ON")
        }else{
            self.config.passCodeL.deleteTouchID()
        }
        self.config.isTouchIDAllowed = sender.isOn
        self.tableView.reloadData()
        
        
    }
    
    var defaultColor:UIColor {
        get {
            return UIColor(red: 190 / 255.0, green: 221 / 255.0, blue: 205 / 255.0, alpha: 0.8)
        }
    }
    
}

//MARK: - extension UITableViewDataSource Delegate
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label : UILabel = UILabel()
        label.backgroundColor = defaultColor
        label.text = sectionArray[section].title
        return label
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case kSectionIndex1:
            return sectionArray[section].rowCount
        case kSectionIndex2:
            return sectionArray[section].rowCount
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath as NSIndexPath).section {
        case Section.index1.rawValue:
            
            let hasPassCode = self.config.passCodeL.hasPassCode
            
            switch indexPath.row {
                
            case 0:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "Lock") {
                    cell.textLabel?.text = NSLocalizedString("SetPasscodeLabel", comment: "")
                    cell.detailTextLabel?.text = ""
                    let swich: UISwitch = UISwitch(frame: CGRect.zero)
                    cell.accessoryView = swich
                    swich.addTarget(self, action: #selector(self.setPassCode(_:)), for: .valueChanged)
                    swich.isOn = hasPassCode
                    
                    return cell
                }
            case 1:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "Lock") {
                    cell.textLabel?.text = NSLocalizedString("ChangePasscodeLabel", comment: "")
                    cell.detailTextLabel?.text = ""
                    cell.accessoryType = .disclosureIndicator
                    
                    return cell
                }
            case 2:
                if let cell:LabelCell = tableView.dequeueReusableCell(withIdentifier: "Label") as? LabelCell {
                    cell.titleValue = ""
                    return cell
                }
            default:
                fatalError("Unknown row")
            }
            
        case Section.index2.rawValue:
            
            switch indexPath.row {
            case 0:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "Lock") {
                    let isTouchID = self.config.passCodeL.isTouchID
                    
                    cell.textLabel?.text = NSLocalizedString("SetTouchIDLabel", comment: "")
                    cell.detailTextLabel?.text = ""
                    let swich: UISwitch = UISwitch(frame: CGRect.zero)
                    cell.accessoryView = swich
                    swich.addTarget(self, action: #selector(self.touchIDValueChanged(_:)), for: .valueChanged)
                    swich.isOn = isTouchID
                    return cell
                }
            default:
                fatalError("Unknown row")
            }
        default:
            fatalError("Unknown section in UITableView")
        }
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath){
        switch (indexPath as NSIndexPath).section {
        case Section.index1.rawValue:
            switch indexPath.row {
            case 1:
                self.changePassCode()
            default:
                return
            }
            
        default:
            return
        }
    }
    
}

//MARK: - extension UITableViewDelegate Delegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
