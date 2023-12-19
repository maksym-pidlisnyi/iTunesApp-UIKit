
import UIKit

/*
 Goal: Search the iTunes API for any query term entered by the user into a search field, display results in a list below the search field that are "songs".
 The NetworkAPI file has the URL we are going to hit, it returns a JSON payload. We only need to parse a subset of the response results.
 For the view, create a List and any time the user taps the Search button the API request should kick off.
 Once this works, modify the code to perform the search as the user types, taking into consideration debouncing the API call, error handling, etc.
 
 */

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var infoBackground: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let CellIdentifier = "com.pmaxsym.iTunesApp"
    
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
    }
    
    // TODO move UITableViewDataSource to separate file
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}
