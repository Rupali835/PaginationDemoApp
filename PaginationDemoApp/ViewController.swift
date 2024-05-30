//
//  ViewController.swift
//  PaginationDemoApp
//
//  Created by Watch Your Health on 29/05/24.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var posts: [Post] = []
    let dataService = DataService()
    var currentPage = 0
    let pageSize = 10
    var isLoading = false
    var hasMoreData = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        loadPosts(page: currentPage)
    }
    
    func loadPosts(page: Int) {
        guard !isLoading else { return }
        
        isLoading = true
        dataService.fetchPosts(page: page, pageSize: pageSize) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let newPosts):
                    if newPosts.isEmpty {
                        self.hasMoreData = false
                    } else {
                        self.posts.append(contentsOf: newPosts)
                        self.tableView.reloadData()
                        self.currentPage += 1
                    }
                case .failure(let error):
                    print("Error fetching posts: \(error)")
                }
                self.isLoading = false
            }
        }
    }
    
     
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")

        
        let post = posts[indexPath.row]
        cell.textLabel?.text = "\(post.id)"
        cell.detailTextLabel?.text = post.title
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsVC" {
            if let detailsVC = segue.destination as? DetailsViewController {
                if let indexPath = sender as? IndexPath {
                    let post = posts[indexPath.row]
                    detailsVC.post = post
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailsVC", sender: indexPath)
       
    }
}

extension ViewController {
    
    // Pagination logic
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height - 100 {
            if hasMoreData && !isLoading {
                loadPosts(page: currentPage)
            }
        }
    }

}
