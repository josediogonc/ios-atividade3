//
//  IssuesTablewViewController.swift
//  issues
//
//  Created by user225450 on 7/27/22.
//

import UIKit
import CoreData

class IssuesTableViewController : UITableViewController {
    
    var fetchedResultsController: NSFetchedResultsController<Issue>!
    
    lazy var issues : [Issue] = []
    
    func loadIssues() {
        let fetchRequest: NSFetchRequest<Issue> = Issue.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadIssues()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsViewController = segue.destination as? DetailsViewController,
            let index = tableView.indexPathsForSelectedRows {
                detailsViewController.issue = fetchedResultsController.object(at: index.first!)
            }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let issue = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = issue.title
        cell.detailTextLabel?.text = issue.date?.brazilianFormatted
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let issue = fetchedResultsController.object(at: indexPath)
            context.delete(issue)
            try? context.save()
        }
    }


}

extension IssuesTableViewController : NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        tableView.reloadData()
    }
}
