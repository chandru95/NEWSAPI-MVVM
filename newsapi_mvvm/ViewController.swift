//
//  ViewController.swift
//  newsapi_mvvm
//
//  Created by Karthiga on 10/13/23.
//

import UIKit
import SDWebImage

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var jsonValue : ArticleS? //ArticleS: Codable create struct
    let apiResponse = ApiIntegration() //getdata code class name
    var html : String?  // Pass the html value to secViewController
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonValue?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let valueDate = dateFromISOString(jsonValue?.articles?[indexPath.row].publishedAt ?? "")
//        print("before converted : \(String(describing: valueDate))")publish date
        let valeDate1 = formatDate(valueDate!)
//        print("conerted date \(valueDate1)")currentdate
        cell.label1.text = valeDate1 //date object name
        cell.label2.text = jsonValue?.articles?[indexPath.row].title
        cell.label3.text = jsonValue?.articles?[indexPath.row].description
        if let imageURLString = jsonValue?.articles?[indexPath.row].urlToImage,
        let imageURL = URL(string: imageURLString) {
            cell.image1.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder.png")) { (image, error, cacheType, imageUrl) in
            if let error = error {
                            print("Error loading image: \(error.localizedDescription)")
                }
            }
        }
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        html = jsonValue?.articles?[indexPath.row].url
            self.performSegue(withIdentifier: "one", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destinationVC = segue.destination as? secondViewController {
                // Pass the html value to secViewController
                destinationVC.getmethode = html
            }
        }
    override func viewDidAppear(_ animated: Bool) {
        let loader = self.loader()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            
            self.stoploader(loader: loader)
        }
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        apiCall()
       
    }
    func apiCall() {
       
        apiResponse.getdate(urlString: url, oncompletion: { (result) in
            self.jsonValue = result
            DispatchQueue.main.async {
            self.tableview.reloadData()
            }
        }, onerror: {
            (error) in
            self.apiCall()
        })
    }

}
// Helper function to convert ISO8601 date string to Date
   func dateFromISOString(_ dateString: String) -> Date? {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Adjust the format as needed
       return dateFormatter.date(from: dateString)
   }

  // Helper function to format Date to a desired output date format with day of the week
   func formatDate(_ date: Date) -> String {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "E, MMM d, yyyy h:mm a" //
       return dateFormatter.string(from: date)
   }
    
    
extension UIViewController {
    
    func loader() -> UIAlertController{
        
        let alert = UIAlertController.init(title: nil, message: "Processing...", preferredStyle: UIAlertController.Style.alert)
        let LoadingIndicater = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        LoadingIndicater.hidesWhenStopped = true
        LoadingIndicater.style = .large
        LoadingIndicater.startAnimating()
        alert.view.addSubview(LoadingIndicater)
        present(alert, animated: true,completion: nil)
        return alert
    }
   
    func stoploader(loader:UIAlertController){
        
        DispatchQueue.main.async {
            loader.dismiss(animated: true,completion: nil)
        }
      
    }
    
    
}
       
