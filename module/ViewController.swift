//
//  ViewController.swift
//  module
//
//  Created by Truck on 2017/2/22.
//  Copyright © 2017年 Truck. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    let table = UITableView()
    let stringList = ["http://news.cts.com.tw/photo/nownews/201407/201407031454988_o.jpg", "https://static.juksy.com/files/articles/51350/56b1797f25be5.jpg", "http://imgs.niusnews.com/upload/imgs/default/16SepW/HH_FOREST/2.png", "http://imgs.niusnews.com/upload/imgs/default/16SepW/HH_FOREST/2.png", "http://i.epochtimes.com/assets/uploads/2016/05/1605110659272384-600x400.jpg", "http://img.vogue.com.tw/userfiles/thumbnail/sm1280_images_A0/28241/2016071913584022.JPG", "http://img.vogue.com.tw/userfiles/thumbnail/sm1280_images_A0/28241/2016071913575582.JPG", "http://img.ltn.com.tw/Upload/ent/page/800/2015/07/01/64.jpg", "http://pic.baike.soso.com/ugc/baikepic2/10599/cut-20151113103314-1228124500.jpg", "http://rs3.sinahk.net/cap/11/2016/02/02/b/bba80c3b4a721e1a0e6a7df104139d3e.jpg", "https://static.juksy.com/files/articles/51350/56b1797f25be5.jpg", "http://imgs.niusnews.com/upload/imgs/default/16SepW/HH_FOREST/2.png", "http://imgs.niusnews.com/upload/imgs/default/16SepW/HH_FOREST/2.png", "http://news.cts.com.tw/photo/nownews/201407/201407031454988_o.jpg", "http://img.vogue.com.tw/userfiles/thumbnail/sm1280_images_A0/28241/2016071913584022.JPG", "http://img.vogue.com.tw/userfiles/thumbnail/sm1280_images_A0/28241/2016071913575582.JPG", "http://img.ltn.com.tw/Upload/ent/page/800/2015/07/01/64.jpg", "http://pic.baike.soso.com/ugc/baikepic2/10599/cut-20151113103314-1228124500.jpg"]//["aa", "bb", "cc", "uu", "vv", "oo", "gg", "mm", "kk", "nn","aa", "bb", "cc", "uu", "vv", "oo", "gg", "mm", "kk", "nn","aa", "bb", "cc", "uu", "vv", "oo", "gg", "mm", "kk", "nn"]
    
    var editButton:UIBarButtonItem!
    var confirmBtn:UIBarButtonItem!
    let btnNormalColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    let btnHighLightColor = UIColor(red: 47/255, green: 131/255, blue: 120/255, alpha: 1)
    let navColor = UIColor(red: 0, green: 164/255, blue: 192/255, alpha: 1)
    let btnSize = CGSize(width: 30, height: 30)
    
    let cellKey = "CELL_KEY"
    override func viewDidLoad() {
        super.viewDidLoad()
        let navSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
        self.navigationController?.navigationBar.setBackgroundImage(GeneralHelper.getImageWithColor(navColor, size:navSize), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = GeneralHelper.getImageWithColor(navColor, size:navSize)
        self.title = "appName"
        
        let cusConfirmBtn = UIButton(frame: CGRect(x: 0, y: 0, width: btnSize.width, height: btnSize.height))
        cusConfirmBtn.setImage(UIImage(named: "login_id"), for: UIControlState())
        cusConfirmBtn.setBackgroundImage(GeneralHelper.getImageWithColor(btnNormalColor, size:btnSize), for: UIControlState())
        cusConfirmBtn.setBackgroundImage(GeneralHelper.getImageWithColor(btnHighLightColor, size:btnSize), for: UIControlState.highlighted)
        cusConfirmBtn.addTarget(self, action: #selector(ViewController.confirmBtnPressed(_:)), for: UIControlEvents.touchUpInside)
        cusConfirmBtn.layer.cornerRadius = cusConfirmBtn.bounds.size.width / 2
        cusConfirmBtn.clipsToBounds = true
        confirmBtn = UIBarButtonItem(customView: cusConfirmBtn)
        self.navigationItem.leftBarButtonItem = confirmBtn
        
        table.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        table.delegate = self
        table.dataSource = self
        table.separatorColor = UIColor.clear
        self.view.addSubview(table)
        /*
        _ = ModuleAPI.sharedInstance.signIn("g0118", Password: "ss556677") { (signInResponse, error) in
            if error != nil {
                //server error
                self.showAlertMessage("伺服器無回應", message: "請稍後再試")
                return
            }
            
            let data: SignInResponse = signInResponse
            switch data.statusCode {
            case StatusCode.correct.returnCode():
                //帳號密碼正確，跳到驗證頁面
                print("\(data)")
                return
                
            case StatusCode.serverError.returnCode():
                //伺服器錯誤
                self.showAlertMessage("錯誤", message: data.statusMsg)
                return
                
            default :
                //帳號密碼錯誤，清空資料跳警告視窗
                self.showAlertMessage("錯誤", message: data.statusMsg)
                return
            }
        }
        */
    }
    
    func confirmBtnPressed(_ sender:UIButton!) {
        self.table.reloadData()
    }
    
    func showAlertMessage(_ title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stringList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row % 2 == 0 ? 50 : 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: self.cellKey)
        if (cell == nil) {
            cell = UITableViewCell()
            cell?.clipsToBounds = true
            
            let text = UILabel()
            text.textColor = UIColor.white
            text.font = UIFont.systemFont(ofSize: 20)
            text.textAlignment = NSTextAlignment.right
            text.frame = CGRect(x: 70, y: 10, width: UIScreen.main.bounds.width - 80, height: 30)
            text.lineBreakMode = NSLineBreakMode.byWordWrapping
            text.numberOfLines = 2
            text.adjustsFontSizeToFitWidth = true
            text.clipsToBounds = true
            text.tag = 1
            cell!.addSubview(text)
            
            let btnLine = UIView()
            btnLine.frame = CGRect(x: 0, y: cell!.bounds.height - 1, width: UIScreen.main.bounds.width, height: 1)
            btnLine.backgroundColor = UIColor.white
            btnLine.tag = 2
            cell!.addSubview(btnLine)
            
            let image = UIImageView()
            image.tag = 3
            cell!.addSubview(image)
        }
        cell!.backgroundColor = UIColor(red:  3 / 255 * CGFloat(indexPath.row), green: 3 / 255 * CGFloat(indexPath.row), blue: 3 / 255 * CGFloat(indexPath.row), alpha: 1)
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        if let textView = cell!.viewWithTag(1) as? UILabel {
            textView.frame = CGRect(x: 70, y: 10, width: UIScreen.main.bounds.width - 80, height: 30)
            textView.text = stringList[indexPath.row]
            textView.sizeToFit()
        }
        if let btnLine = cell!.viewWithTag(2) {
            btnLine.frame = CGRect(x: 0, y: indexPath.row % 2 == 0 ? 49 : 69, width: UIScreen.main.bounds.width, height: 1)
        }
        if let image = cell!.viewWithTag(3) as? UIImageView {
            let edge:CGFloat = indexPath.row % 2 == 0 ? 30 : 50
            image.frame = CGRect(x: 10, y: 10, width: edge, height: edge)
            image.contentMode = UIViewContentMode.scaleAspectFill
            image.layer.cornerRadius = edge / 2
            image.clipsToBounds = true
            image.sd_setImage(with: URL(string: stringList[indexPath.row]), placeholderImage: UIImage(named:"login_id"), options: SDWebImageOptions.retryFailed)
//            image.sd_setImage(with: URL(string: stringList[indexPath.row]), placeholderImage: UIImage(named:"login_id"))
        }
        return cell!
    }
}
