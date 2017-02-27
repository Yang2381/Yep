//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating, UIScrollViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var businesses: [Business]!
    var searchResult: [Business]!
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
       
        searchResult = businesses
        
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        //Change the text in search bar
        searchController.searchBar.placeholder = "Type here"
        
        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense. Should probably only set
        // this to yes if using another controller to display the search results.
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
      
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
        Business.searchWithTerm(term: "Asia", offset: 0, limit: 20, completion: { (businesses: [Business]?, error: Error?) -> Void in
        
            self.businesses = businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                  //  print(business.name!)
                 //   print(business.address!)
                    
                }
            }
            
            }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    /*****************************************************************************
                                Infinite scroll
     Set the buttom limit 
     test if it reaches the limit and if user is still dragging
     then 
     set flag to true
     load more data and reload tableView
    *******************************************************************************/
    
    var isMoreDataLoading = false
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                loadMoreData()
                self.tableView.reloadData()
            }
        }
    }
    
            /*****************************************************************************
                                    Goes with infinite scroll
                Load the data from the end of result as offset and load until the limit.
                Append the data to businesses
                Set the flag to false agina to reload next time
                Reload the tableView
            *******************************************************************************/
    func loadMoreData() {
        
        Business.searchWithTerm(term: "Thai", offset: self.businesses.count, limit: 20, completion: { (businesses: [Business]?, error: Error?) -> Void in
            if let businesses = businesses{
                self.businesses.append(contentsOf: businesses)
            }
            self.isMoreDataLoading = false
            self.tableView.reloadData()
        }
      )
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    func updateSearchResults(for searchController: UISearchController) {
        
        businesses.removeAll(keepingCapacity: false)
        if let searchString = searchController.searchBar.text{
            if !searchString.isEmpty {
                print("Don't know what to do now")
                
            }
        }
      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil{
            return businesses.count
        }else{return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCellTableViewCell
        cell.business = businesses[indexPath.row]
    
    
        return cell
        
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let busie = businesses[indexPath!.row]
        
        let mapViewController = segue.destination as! MapViewController
        mapViewController.business = busie
        
    }
    
    
    
   }
