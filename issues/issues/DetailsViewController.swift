//
//  ViewController.swift
//  issues
//
//  Created by user225450 on 7/27/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var registerDate: UILabel!
    @IBOutlet weak var location: UILabel!
    
    var issue : Issue?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editNewViewController = segue.destination as? EditNewViewController {
            editNewViewController.issue = issue
        }
    }
    
    func initView() {
        if let issue = issue {
            title = issue.title
            summary.text = issue.summary
            location.text = "Localização: \(issue.location ?? "Não localizado")"
            registerDate.text = "Data de registro: \(issue.date!.brazilianFormatted)"
            
            if let img = issue.image {
                image.image = UIImage(data: img)
            }
        }
    }


}

