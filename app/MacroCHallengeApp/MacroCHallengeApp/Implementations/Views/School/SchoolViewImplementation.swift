//
//  SchoolViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 05/10/20.
//

import UIKit

class SchoolViewImplementation: UIView, SchoolViewProtocol {
    // MARK: - IBOutlets
    @IBOutlet weak var testTableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Dependencies
    var viewController: SchoolViewControllerProtocol
    
    // MARK: - Private attributes
    private var data: School
    
    private let sectionHeaderTitleArray = ["Provas", "Todas as questões", "Saiba mais sobre o edital"]
    
    private var topics: [String]
    
    // MARK: - Init methods
    required init(data: School, controller: SchoolViewControllerProtocol) {
        self.data = data
        self.topics = {
                switch data.name {
                case "Cotuca":
                    return ["Português", "Matemática", "Ciências Naturais"]
                case "Cotil":
                    return ["Português", "Matemática", "Física", "Biologia", "Geografia", "Química"]
                case "Cti":
                    return ["Português", "Matemática", "Biologia", "História", "Geografia"]
                case "Etec":
                    return ["Português", "Matemática", "Física", "Químicia","Biologia", "História", "Geografia"]
                default:
                    return []
                }
            }()
        self.viewController = controller
        super.init(frame: CGRect.zero)
        initFromNib()
        setupTableView()
        self.activityIndicator.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initFromNib() {
        if let nib = Bundle.main.loadNibNamed("SchoolViewImplementation", owner: self, options: nil),
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
        testTableView.delegate = self
        testTableView.dataSource = self
    }
    
    /**
     
     Método responsável por referenciar a XIB de uma determinada célula.
     
     - parameters nibName: nome do arquivo XIB da célula
     
     */
    
    private func referenceXib(nibName: String) {
        let nib = UINib.init(nibName: nibName, bundle: nil)
        self.testTableView.register(nib, forCellReuseIdentifier: nibName)
    }
}

// MARK: - Extension Table View Data Source Methods
extension SchoolViewImplementation:UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaderTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        
        if section == 0 { // tests section
            numberOfRows = data.tests.count
        } else if section == 1 { // question section
            numberOfRows = topics.count
        } else if section == 2 { // notice section
            numberOfRows = 1
        }
        return numberOfRows
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
            
            let test = data.tests[indexPath.row]
            
            cell.testLabel.text = "Prova \(test.year)"
            
        } else if indexPath.section == 1 { // Questoes
            cellIdentifier = "QuestionsTableViewCell"
            referenceXib(nibName: cellIdentifier)
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? QuestionsTableViewCell  else {
                fatalError("The dequeued cell is not an instance of TestTableViewCell.")
            }
            
            cell.lblTopic.text = self.topics[indexPath.row]
            finalCell = cell
            
        } else if indexPath.section == 2 { // notice
            cellIdentifier = "NoticeTableViewCell"
            referenceXib(nibName: cellIdentifier)
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NoticeTableViewCell  else {
                fatalError("The dequeued cell is not an instance of NoticeTableViewCell.")
            }
            
            finalCell = cell
            
            cell.noticeLabel.text = "Edital 2021"
            cell.logoImageView.image = UIImage(named: "logoCOTUCA")
        }
        
        return finalCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            switch cell {
            case is NoticeTableViewCell:
                viewController.noticeWasSubmitted(data.notice)
            case is QuestionsTableViewCell:
                viewController.questionWasSubmitted(topic: self.topics[indexPath.row])
            case is TestTableViewCell: 
                viewController.testWasSubmitted(data.tests[indexPath.row])
            default:
                print("Unexpected: the cell is not a custom cell.")
            }
            
        }
    }
}
