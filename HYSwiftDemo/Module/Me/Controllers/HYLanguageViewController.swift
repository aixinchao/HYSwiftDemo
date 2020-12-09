//
//  HYLanguageViewController.swift
//  HYSwiftDemo
//
//  Created by axc on 2020/11/26.
//  Copyright © 2020 axc. All rights reserved.
//

import UIKit

class HYLanguageViewController: HYBaseViewController, UITableViewDelegate, UITableViewDataSource {

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: self.view.bounds, style: UITableView.Style.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    let titleArrays = ["跟随系统", "简体中文", "English"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = HYLocalizationTool.getLocalizedString(key: "语言设置")
        
        setupUI()
    }
    
    func setupUI() {
        self.view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        
        let currentLanguage = HYLocalizationTool.getCurrentLanguage()
        if currentLanguage == HYLocalizationTool.Language.auto && indexPath.row == 0 {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        if currentLanguage == HYLocalizationTool.Language.chinese && indexPath.row == 1 {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        if currentLanguage == HYLocalizationTool.Language.english && indexPath.row == 2 {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        
        cell.textLabel?.text = titleArrays[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var language = HYLocalizationTool.Language.auto
        if indexPath.row == 0 {
            language = HYLocalizationTool.Language.auto
        }
        if indexPath.row == 1 {
            language = HYLocalizationTool.Language.chinese
        }
        if indexPath.row == 2 {
            language = HYLocalizationTool.Language.english
        }
        let ok = HYLocalizationTool.setLanguage(language: language)
        if ok {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            UIApplication.shared.keyWindow?.rootViewController = appDelegate.createRootViewController()
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
