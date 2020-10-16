//
//  QuestionViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by André Papoti de Oliveira on 06/10/20.
//

import Foundation
import UIKit

class QuestionViewImplementation: UIView, QuestionViewProtocol {
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var questionTableView: UITableView!
    @IBOutlet weak var btnProximo: UIButton!
    @IBOutlet weak var btnAnterior: UIButton!
    
    
    // MARK: - Dependencias
    
    var controller: QuestionViewControllerProtocol
    
    
    // MARK: - Atributos privados
    
    private var question: Question
    private var sectionHeaders: [String]
    private var chosenOption: String?
    
    
    // MARK: - Métodos de init
    
    required init(data: Question, controller: QuestionViewControllerProtocol) {
        self.question = data
        self.controller = controller
        self.sectionHeaders = ["", "", "", "", "", ""] // Strings estao vazias para não exibir os headers
        super.init(frame: CGRect.zero)
        initFromNib()
        self.questionTableView.delegate = self
        self.questionTableView.dataSource = self
        let currentQuestion = Int(data.number) ?? -10
        self.btnAnterior.setTitle("Questão " + String(currentQuestion - 1), for: .normal)
        self.btnProximo.setTitle("Questão " + String(currentQuestion + 1), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initFromNib() {
        if let nib = Bundle.main.loadNibNamed("QuestionViewImplementation", owner: self, options: nil),
           let nibView = nib.first as? UIView {
            nibView.frame = bounds
            nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(nibView)
        }
    }
    
    // MARK: - Funções do protocolo
    
    /// Método reponsavél por sobrescrever a view com uma nova questão
    /// - parameter data: Questão que será utilizada para sobrescrever a view
    /// - parameter wasAlreadyAnswered: Diz se a questão já foi respondida
    /// - parameter shouldPresentAnswer: Booleano para indicar se a questão deveria mostrar a resposta
    func overwrite(data: Question, wasAlreadyAnswered: String?) {
        self.question = data
        if let alreadyChosenOption = wasAlreadyAnswered {
            self.chosenOption = alreadyChosenOption
        } else {
            self.chosenOption = nil
        }
        let currentQuestion = Int(data.number) ?? -10
        self.btnAnterior.setTitle("Questão " + String(currentQuestion - 1), for: .normal)
        self.btnProximo.setTitle("Questão " + String(currentQuestion + 1), for: .normal)
        self.questionTableView.reloadData()
    }
    


     /// Método que irá sinalizar a view para atualizar a sua label do cronômetro.
     /// - parameter newTimeText: O novo texto do cronômetro no formato HH:MM (exemplo 01:20)
    func updateTime(_ newTimeText: String) {
        let path = IndexPath(row: 0, section: 0) // A célula que con
        guard let cell = self.questionTableView.cellForRow(at: path) as? QuestionHeaderTableViewCell else {return}
        cell.lblTime.text = newTimeText
    }
    
    
    // MARK: - Funções privadas
    
    @IBAction func submitPrevious(_ sender: Any) {
        controller.previousWasSubmitted()
    }
    @IBAction func submitNext(_ sender: Any) {
        controller.nextWasSubmitted()
    }
    

    /// Função utilizada para registrar o arquivo .xib das celulas para serem utilizadas pela table view
    /// - parameter nibName: Nome que referencia o nome do xib
    func referenceXib(nibName: String) {
        let nib = UINib.init(nibName: nibName, bundle: nil)
        self.questionTableView.register(nib, forCellReuseIdentifier: nibName)
    }
}


// MARK: - Table view data source e delegate

extension QuestionViewImplementation: UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: Enums
    
    enum TextCellType {
        case initialText
        case subtitle
        case text
    }
    
    
    // MARK: TableViewDataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionHeaders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        if section == 0 { // Question header
            numberOfRows = 1
        } else if section == 1 { // Initial text
            numberOfRows = (self.question.initialText == nil ? 0 : 1)
        } else if section == 2 { // images
            numberOfRows = self.question.images?.count ?? 0
        } else if section == 3 { // subtitle
            numberOfRows = (self.question.subtitle == nil ? 0 : 1)
        } else if section == 4 { // text
            numberOfRows = 1
        } else if section == 5 { // options
            numberOfRows = question.options.count
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionHeaders[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch  (indexPath.section) {
        // Question header
        case 0:
            return setupQuestionHeaderCell(tableView: tableView, indexPath: indexPath, subject: question.topic)
        // Initial text
        case 1:
            return setupQuestionTextCell(tableView: tableView, indexPath: indexPath, value: question.initialText ?? "", category: .initialText)
        // Images
        case 2:
            let image = self.question.images?[indexPath.row] ?? UIImage()
            return setupQuestionImageCell(tableView: tableView, indexPath: indexPath, image: image)
        // Subtitle
        case 3:
            return setupQuestionTextCell(tableView: tableView, indexPath: indexPath, value: self.question.subtitle ?? "", category: .subtitle)
        // Text
        case 4:
            return setupQuestionTextCell(tableView: tableView, indexPath: indexPath, value: self.question.text, category: .text)
        // Options
        case 5:
            return setupOptionCell(tableView: tableView, indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    
    // MARK: TableViewDelegate methods
    
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = questionTableView.cellForRow(at: indexPath) as? QuestionOptionTableViewCell {
            let option = String(format: "%c", indexPath.row + 97) // Convert path.row index to a char. 97 is equivalent to 'a' in the ASCII table
            if option == self.chosenOption { // Reselect cell to deselect it
                self.chosenOption = nil
                self.controller.answerWasUnsubmitted(question: self.question)
                setOptionCell(cell: cell, selected: false)
            } else { // Select a previous unselected cell
                self.chosenOption = option
                self.controller.answerWasSubmitted(question: self.question, answer: option)
                setOptionCell(cell: cell, selected: true)
            }
        }
    }
    
    func tableView( _ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = questionTableView.cellForRow(at: indexPath) as? QuestionOptionTableViewCell {
            setOptionCell(cell: cell, selected: false)
        }
    }
    
    
    // MARK: Private methods
    
    /// Método responsavel pelas alterações visuais em uma célula de opção
    /// - parameter cell: A célula que deve ser alterada
    /// - parameter selected: Determina se a célula terá aparencia de selecionada ou não
    private func setOptionCell(cell: QuestionOptionTableViewCell, selected: Bool) {
        if selected {
            UIView.animate(withDuration: 0.3, animations: {
                // 0xCBDAF8
                cell.CardView.backgroundColor = UIColor(red:203/255, green:218/255, blue:248/255, alpha: 1)
                cell.lblAnswer.textColor = .black
                cell.lblIndex.textColor = .black
                cell.btnRadio.image = UIImage(systemName: "largecircle.fill.circle")
                // Deselect other options
                guard let tableView = cell.superview as? UITableView else {return}
                for auxCell in tableView.visibleCells {
                    if let optionCell = auxCell as? QuestionOptionTableViewCell, auxCell != cell {
                        self.setOptionCell(cell: optionCell, selected: false)
                    }
                }
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                cell.CardView.backgroundColor = .white
                cell.lblAnswer.textColor = .black
                cell.lblIndex.textColor = .black
                cell.btnRadio.image = UIImage(systemName: "circle")
            })
        }
    }
    
    /// Método responsável por setar a célula de cabeçalho
    /// - parameter tableView: TableView que contém a célula
    /// - parameter indexPath: Localização da célula
    /// - parameter subject: Matéria da questão
    private func setupQuestionHeaderCell(tableView: UITableView, indexPath: IndexPath, subject: String) -> UITableViewCell {
        let cellIdentifier = "QuestionHeaderTableViewCell"
        referenceXib(nibName: cellIdentifier)
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? QuestionHeaderTableViewCell {
            let myString = subject
            let myAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
            let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
            
            cell.lblTopic.attributedText = myAttrString
            
            return cell
        } else {
            fatalError("setupQuestionHeaderCell failed")
        }
    }
    
    /// Método responsável por setar células de texto
    /// - parameter tableView: TableView que contém a célula
    /// - parameter indexPath: Localização da célula
    /// - parameter value: String que contém o texto
    /// - parameter category: Define a formatação da célula
    private func setupQuestionTextCell(tableView: UITableView, indexPath: IndexPath, value: String, category: TextCellType) -> UITableViewCell {
        let cellIdentifier = "QuestionTextTableViewCell"
        referenceXib(nibName: cellIdentifier)
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? QuestionTextTableViewCell {
            switch category {
            case .initialText:
                let myAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
                let myAttrString = NSAttributedString(string: value, attributes: myAttribute)
                cell.lblText.textAlignment = .left
                cell.lblText.attributedText = myAttrString
                cell.lblText.textColor = .black
            case .subtitle:
                let myAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)]
                let myAttrString = NSAttributedString(string: value, attributes: myAttribute)
                cell.lblText.textAlignment = .center
                cell.lblText.attributedText = myAttrString
                cell.lblText.textColor = .gray
            case .text:
                let myAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
                let myAttrString = NSAttributedString(string: value, attributes: myAttribute)
                cell.lblText.textAlignment = .left
                cell.lblText.attributedText = myAttrString
                cell.lblText.textColor = .black
            }
            
            return cell
        } else {
            fatalError("setupQuestionTextCell failed")
        }
    }
    
    /// Método responsável por setar células de imagem
    /// - parameter tableView: TableView que contém a célula
    /// - parameter indexPath: Localização da célula
    /// - parameter image: Imagem que deve ser exibida
    private func setupQuestionImageCell(tableView: UITableView, indexPath: IndexPath, image: UIImage) -> UITableViewCell {
        let cellIdentifier = "QuestionImageTableViewCell"
        referenceXib(nibName: cellIdentifier)
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? QuestionImageTableViewCell {
            cell.imgQuestionImage.image = image
            return cell
        } else {
            fatalError("setupQuestionImageCell failed")
        }
    }
    
    /// Método responsável por setar células de resposta de questão
    /// - parameter tableView: TableView que contém a célula
    /// - parameter indexPath: Localização da célula
    /// - parameter image: Imagem que deve ser exibida
    private func setupOptionCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "QuestionOptionTableViewCell"
        referenceXib(nibName: cellIdentifier)
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? QuestionOptionTableViewCell {
            let index = String(format: "%c", indexPath.row + 97)
            cell.lblIndex.text = index.uppercased()
            cell.lblAnswer.text = self.question.options[index]
            if (index == self.chosenOption) {
                setOptionCell(cell: cell, selected: true)
            } else {
                setOptionCell(cell: cell, selected: false)
            }
            return cell
        } else {
            fatalError("QuestionOptionTableViewCell failed")
        }
    }
}
