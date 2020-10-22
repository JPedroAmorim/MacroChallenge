//
//  NoticeViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 22/10/20.
//

import UIKit

class NoticeViewImplementation: UIView, NoticeViewProtocol {
    
    // MARK: - IBOutlets
    @IBOutlet weak var testTableView: UITableView!
    
    // MARK: - Dependencies
    var viewController: NoticeViewControllerProtocol
    
    // MARK: - Private attributes
    private var data: [String : String]
    
    private let sectionHeaderTitleArray = ["Tópicos por matéria",
                                           "Redação",
                                           "Mais informações",
                                           "Duração da prova"]
    
    // MARK: - Init methods
    required init(data: [String : String], controller: NoticeViewControllerProtocol) {
        self.data = data
        self.viewController = controller
        super.init(frame: CGRect.zero)
        initFromNib()
        setupTableView()
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
extension NoticeViewImplementation: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaderTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        
        switch section{
        case 0: // tópicos por matéria
            numberOfRows = 4 // <<<< mudar
        case 1: // redação
            numberOfRows = 1
        case 2: // mais informações
            numberOfRows = 1
        case 3: // duração da prova
            numberOfRows = 1
        default:
            numberOfRows = 0
        }
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaderTitleArray[section] as String
    }
    
    //    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    //        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.init(red: 242/255,
    //                                                                                          green: 242/255,
    //                                                                                          blue: 247/255,
    //                                                                                          alpha: 1.0)
    //        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.init(red: 123/255,
    //                                                                                   green: 123/255,
    //                                                                                   blue: 123/255,
    //                                                                                   alpha: 1.0)
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "NoticeTopicTableViewCell"
        referenceXib(nibName: cellIdentifier)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NoticeTopicTableViewCell  else {
            fatalError("The dequeued cell is not an instance of NoticeTopicTableViewCell.")
        }
        
        if indexPath.section == 0 { // topicos por matéria
            
            
            
        } else if indexPath.section == 1 { // redação
            cell.titleLabel.text = "Informações sobre a redação"
        } else if indexPath.section == 2 { // mais informações
            cell.titleLabel.text = "Edital completo"
        } else if indexPath.section == 3 { // duração da prova
            cell.accessoryType = .none
            cell.durationLabel.isHidden = false
            cell.titleLabel.text = "Duração da prova"
            cell.durationLabel.text = "4:30 horas" // <<<< mudar
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        
        switch section {
        case 0: // topicos
            viewController.topicWasSubmitted(["":""])
        case 1: // redação
            viewController.essayWasSubmitted(["":""])
        case 2: // mais informações
            viewController.moreInformationWasSubmitted("")
        default:
            print("Other cell was selected")
        }
    }
}
