
import UIKit

/*
 Goal: Search the iTunes API for any query term entered by the user into a search field, display results in a list below the search field that are "songs".
 The NetworkAPI file has the URL we are going to hit, it returns a JSON payload. We only need to parse a subset of the response results.
 For the view, create a List and any time the user taps the Search button the API request should kick off.
 Once this works, modify the code to perform the search as the user types, taking into consideration debouncing the API call, error handling, etc.
 
 */

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var infoBackground: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let CellIdentifier = "com.pmaxsym.iTunesApp.song"
    private let networkApi = NetworkAPI()
    private var songs: [Song] = []
    
    private var searchTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
    }
    
    // TODO: move UITableViewDataSource to separate file
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        cell.textLabel?.text = songs[indexPath.row].trackName
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTimer?.invalidate()
        
        if searchText == "" {
            // show message to start searching
            // TODO: change infoBackground and tableView visibility
            print("Empty")
        } else {
            print(searchText)
            searchTimer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { [weak self] _ in
                self?.handleSearch(searchText: searchText)
            }
        }
    }
    
    func handleSearch(searchText: String) {
        networkApi.searchForSongs(searchTerm: searchText) { results in
            switch results {
                case .success(let songs):
                    DispatchQueue.main.async {
                        self.songs = songs
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                print(error)
            }
        }
    }
}

