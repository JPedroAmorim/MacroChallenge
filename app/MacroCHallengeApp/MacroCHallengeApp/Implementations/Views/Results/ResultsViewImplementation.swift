//
//  ResultsViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 13/10/20.
//

import UIKit

class ResultsViewImplementation: UIView, ResultsViewProtocol {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Dependencies
    var viewController: ResultsViewControllerProtocol
    
    // MARK: - Private attributes
    private var data: ResultsData
    
    private let sectionHeaderTitleArray = ["Nota final", "Nota por matéria", "Questões"]
    
    // MARK: - Init methods
    required init(data: ResultsData, viewController: ResultsViewControllerProtocol) {
        self.data = data
        self.viewController = viewController
        super.init(frame: CGRect.zero)
        initFromNib()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initFromNib() {
        if let nib = Bundle.main.loadNibNamed("ResultsViewImplementation", owner: self, options: nil),
           let nibView = nib.first as? UIView {
            nibView.frame = bounds
            nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(nibView)
        }
    }
    
    // MARK: - Private methods
    
    /**
     
     Método responsável por configurar a TableView das provas.
     
     */
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /**
     
     Método responsável por referenciar a XIB de uma determinada célula.
     
     - parameters nibName: nome do arquivo XIB da célula
     
     */
    
    private func referenceXib(nibName: String) {
        let nib = UINib.init(nibName: nibName, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: nibName)
    }
}

// MARK: - Extension Table View Data Source Methods

extension ResultsViewImplementation: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaderTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var numberOfRows = 0
        
//        if section == 0 { // tests section
//            numberOfRows = data.tests.count
//        } else if section == 1 { // notice section
//            numberOfRows = 1
//        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaderTitleArray[section] as String
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.init(red: 242/255,
                                                                                          green: 242/255,
                                                                                          blue: 247/255,
                                                                                          alpha: 1.0)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.init(red: 123/255,
                                                                                   green: 123/255,
                                                                                   blue: 123/255,
                                                                                   alpha: 1.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellIdentifier = String()
        var finalCell = UITableViewCell()
        
        if indexPath.section == 0 { // tests
            cellIdentifier = "TestTableViewCell"
            referenceXib(nibName: cellIdentifier)
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TestTableViewCell  else {
                fatalError("The dequeued cell is not an instance of TestTableViewCell.")
            }
            
            finalCell = cell
            
//            let test = data.tests[indexPath.row]
            
//            cell.testLabel.text = "Prova \(test.year)"
            
        } else if indexPath.section == 1 { // notice
            cellIdentifier = "NoticeTableViewCell"
            referenceXib(nibName: cellIdentifier)
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NoticeTableViewCell  else {
                fatalError("The dequeued cell is not an instance of NoticeTableViewCell.")
            }
            
            finalCell = cell
            
            cell.noticeLabel.text = "Edital 2021"
            cell.logoImageView.image = UIImage(named: "logoCTI")
        }
        
        return finalCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath) {
//
//            switch cell {
//            case is NoticeTableViewCell:
//                viewController.noticeWasSubmitted(data.notice)
//            case is TestTableViewCell:
//                viewController.testWasSubmitted(data.tests[indexPath.row])
//            default:
//                fatalError("Unexpected: the cell is not a custom cell.")
//            }
//
//        }
    }
}

