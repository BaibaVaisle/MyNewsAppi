//
//  GetNewsViewController.swift
//  MyNewsAppi
//
//  Created by baiba.vaisle on 26/08/2021.
//

import UIKit
import Gloss

class GetNewsViewController: UIViewController {
    
    //var items: [Item] = []
   // var searchResult = "/(enterIndustryCategory)"
    var searchResult = "apple"
    
  
   /* @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           self.title = "Get News"
           activityIndicatorView.isHidden = true
          // handleGetData()
       }
       
       func activityIndicator(animated: Bool){
           DispatchQueue.main.async {
               if animated{
                   self.activityIndicatorView.isHidden = false
                   self.activityIndicatorView.startAnimating()
               }else{
                   self.activityIndicatorView.isHidden = true
                   self.activityIndicatorView.stopAnimating()
               }
           }
       
   
       }*/

    @IBOutlet weak var getButtonTapped: UIButton!
    
    @IBAction func getDataTapped(_ sender: Any) {
            handleGetData()
        }
    
 
    func handleGetData(){
        //self.activityIndicator(animated: true)
        let jsonUrl = "http://newsapi.org/v2/everything?q=\(searchResult)&from=2021-07-15&to=2021-08-05&sortBy=popularity&apiKey=1920b7f830414a5bb662b581372ff993"
        
        guard let url = URL(string: jsonUrl) else {return}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { data, response, err in
            
//            print("response: ", response as Any)
            if let err = err {
                self.basicAlert(title: "Error!", message: "\(err.localizedDescription)")
            }
            
            guard let data = data else {
                self.basicAlert(title: "Error!", message: "Something went wrong, no data")
                return
            }
            
            do{
                if let dictData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                    print("dictData:", dictData)
                  //#Warning - cannot populateData / why?  self.populateData(dictData)
                }
            }catch{
                
            }

        }
        task.resume()
 
    }
}
    
    /*func populateData(_ dict: [String: Any]){
        guard let responseDict = dict["articles"] as? [Gloss.JSON] else {
            return
        }
        
        items = [Item].from(jsonArray: responseDict) ?? []
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator(animated: false)
        }
        
    }
    
    
    
}*/

//MARK: -UITableViewDelegate, UITableViewDataSource
/*extension GetNewsViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsFeed", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        let item = items[indexPath.row]
        cell.newsTitleLabel.text = item.title
        cell.newsTitleLabel.numberOfLines = 0
        
        if let image = item.image{
            cell.newsImageView.image = image
        }
        let date = String(item.publishedAt.prefix(10))
        self.title = "My News \(date)"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storybord = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storybord.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
            return
        }
        
        let item = items[indexPath.row]
        vc.contentString = item.description
        vc.titleString = item.title
        vc.webURLString = item.url
        vc.newsImage = item.image
        
//        present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
       }
 }*/

