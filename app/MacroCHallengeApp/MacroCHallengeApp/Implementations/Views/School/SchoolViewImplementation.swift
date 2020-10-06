//
//  SchoolViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by João Pedro de Amorim on 05/10/20.
//

import UIKit

class SchoolViewImplementation: UIView, SchoolViewProtocol {
    // MARK: - IBOutlets
    
    // Notice
    @IBOutlet weak var noticeViewCard: UIView!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var noticeImage: UIImageView!
    
    // Tests
    @IBOutlet weak var testTableView: UITableView!
    
    // MARK: - Dependencies
    var viewController: SchoolViewControllerProtocol
    
    // MARK: - Private attributes
    private var data: School
    
    // MARK: - Init methods
    required init(data: School, controller: SchoolViewControllerProtocol) {
        self.data = data
        self.viewController = controller
        super.init(frame: CGRect.zero)
        initFromNib()
        addingShadowOnElement(view: self.noticeViewCard)
        setVisualElements()
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
     
     Método responsável, a partir da propriedade self.data, popular os elementos visuais da view.
     
     */
    private func setVisualElements() {
        
    }
    
    /**
     
     Método responsável por adicionar sombras nos elementos UIView.
     
     - parameter view :  view no qual a sombra vai ser adicionada.
     
     */
    private func addingShadowOnElement(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 1
        view.layer.masksToBounds = false
    }
    
    /**
     
     Método responsável por configurar a TableView das provas.
     
     */
    
    private func setupTableView() {
        self.testTableView.delegate = self
        self.testTableView.dataSource = self
    }
}

// MARK: - Extension Table View Data Source Methods

extension SchoolViewImplementation:UITableViewDataSource, UITableViewDelegate {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.tests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "TestTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TestTableViewCell  else {
            fatalError("The dequeued cell is not an instance of TestTableViewCell.")
        }
        
        let test = self.data.tests[indexPath.row]
        
        cell.testLabel.text = "Prova \(test.year)"
        
        return cell
    }
}
