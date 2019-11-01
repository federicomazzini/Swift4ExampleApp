//
//  LaptopsViewController.swift
//  MTIExerciseSwift4
//
//  Created by federico mazzini on 01/11/19.
//  Copyright © 2019 federico mazzini. All rights reserved.
//

import UIKit

class LaptopsViewController: BaseViewController, LaptopsViewContractView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var myNavigationItem: UINavigationItem!
    
    internal var presenter: LaptopsViewContractPresenter!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        
        tableView.register(UINib(nibName: Constants.Views.LaptopCell, bundle: nil), forCellReuseIdentifier: Constants.Views.LaptopCell)
        myNavigationItem.title = Constants.Strings.Laptops
        
        self.tableView.rowHeight          = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.delegate   = self
        self.tableView.dataSource = self
    }
    
    override func injectDependencies() {
        super.injectDependencies()
        presenter = Configurator.getLaptopsViewPresenter(viewController: self)
    }
    
    func reloadTable() {
        self.tableView.reloadData()
    }
    
    func showLoadingOverlay() {
        self.showForegroundProgress()
    }
    
    func hideLoadingOverlay() {
        self.hideForegroundProgress()
    }
    
    // MARK: - Navigation
    internal func showDetail(item: Item) {
        let storyboard = UIStoryboard(name: Constants.Storyboards.Main, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllers.LaptopDetailViewController) as? LaptopDetailViewController {
            vc.item = item
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension LaptopsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.laptopList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Views.LaptopCell, for: indexPath) as? LaptopCell
        
        if let myItem = self.presenter.laptopList?[indexPath.row] {
            cell?.configureCell(item: myItem)
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let myItem = self.presenter.laptopList?[indexPath.row] else { return }
        showDetail(item: myItem)
    }
    
}
