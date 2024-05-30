//
//  DetailsViewController.swift
//  PaginationDemoApp
//
//  Created by Watch Your Health on 29/05/24.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var detailsDatalbl: UILabel!
    
    var post: Post?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let post = post {
            
            titlelbl.text = post.title
            detailsDatalbl.text = post.body

        }
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
