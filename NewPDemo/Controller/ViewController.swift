//
//  ViewController.swift
//  NewPDemo
//
//  Created by mehul modhvadiya on 17/08/20.
//  Copyright © 2020 mehul modhvadiya. All rights reserved.
//

import UIKit
import SDWebImage
import SystemConfiguration

class ViewController: UIViewController {
    
    // Mark:  iboutlet connection
    
    @IBOutlet var tblArticle:UITableView!
    
    @IBOutlet var activityIndi:UIActivityIndicatorView!
    
    // init varible and arary to show the list
    var arrArticleList = [articleChildren]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mark: check internet connection
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            self.activityIndi.isHidden = false
            activityIndi.startAnimating()
            getArticleApiCall()
            
        }else{
            print("Internet Connection not Available!")
            activityIndi.isHidden = true
            activityIndi.stopAnimating()
        }
        
        // title
        self.title = "Swift News"
        
        // api call
       
        self.tblArticle.estimatedRowHeight = 168

        self.tblArticle.rowHeight = UITableView.automaticDimension
    }
}
extension ViewController {
    func getArticleApiCall(){
        
        var request = URLRequest(url: URL(string: "https://www.reddit.com/r/swift/.json")!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(ArticleDataModel.self, from: data!)
                print("show result:--\(responseModel.data.children)")
                self.arrArticleList.removeAll()
                self.arrArticleList = responseModel.data.children
                
                DispatchQueue.main.async {
                    self.activityIndi.stopAnimating()
                    self.activityIndi.isHidden = true
                    self.tblArticle.reloadData()
                }
                
            } catch {
                print("JSON Serialization error")
            }
        }).resume()
    }
}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrArticleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleCell
        
        let dict = arrArticleList[indexPath.row].data
        cell.lblTitle.text = dict.title
        
        cell.lblTitle.sizeToFit()

        if dict.thumbnail == "self" {
            cell.imgWidthConstraint.constant = 0
            cell.imgHeightConstraint.constant = 0

            cell.imgArticle.isHidden = true
//            cell.imgArticle.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "download.png"))
            
        }else {
//            cell.imgArticle.layer.cornerRadius = 45
//            cell.imgArticle.layer.masksToBounds = true

            cell.imgWidthConstraint.constant = 90
            cell.imgHeightConstraint.constant = 90

            cell.imgArticle.isHidden = false
            cell.imgArticle.sd_setImage(with: URL(string: dict.thumbnail), placeholderImage: UIImage(named: "placeholder.png"))
        }
        
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.storyboard?.instantiateViewController(identifier: "ArticleDetailVC") as! ArticleDetailVC
        obj.arrArticleList = [arrArticleList[indexPath.row]]
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
}
public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}
