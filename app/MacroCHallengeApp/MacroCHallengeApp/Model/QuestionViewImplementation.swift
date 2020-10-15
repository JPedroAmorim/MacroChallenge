//
//  QuestionViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by André Papoti de Oliveira on 06/10/20.
//

import Foundation
import UIKit

class QuestionViewImplementation: UIView, QuestionViewProtocol {
    func updateTime(_ newTimeText: String) {
        
    }
    
    
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
        self.sectionHeaders = ["", "", "", "", "", ""]
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
    /**
     Método reponsavél por sobrescrever a view com uma nova questão
     - parameter data: Questão que será utilizada para sobrescrever a view
     */
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
    
    /**

         Método que irá sinalizar a view para atualizar a sua label do cronômetro.

         - parameter newTimeText: O novo texto do cronômetro no formato HH:MM (exemplo 01:20)

         */
    func updateTime(_ newTimeText: String) {
        let path = IndexPath(row: 0, section: 0)
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
    
    /**
     
     Função utilizada para registrar o arquivo .xib das celulas para serem utilizadas pela table view
     - parameter nibName: Nome que referencia o nome do xib
     
     */
    func referenceXib(nibName: String) {
        let nib = UINib.init(nibName: nibName, bundle: nil)
        self.questionTableView.register(nib, forCellReuseIdentifier: nibName)
    }
}

// MARK: - Table view data source e delegate
extension QuestionViewImplementation: UITableViewDataSource, UITableViewDelegate {
    
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
//        } else if section == 6 { // buttons
//            numberOfRows = 1
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionHeaders[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch  (indexPath.section) {
        case 0: // Question header
            let cellIdentifier = "QuestionHeaderTableViewCell"
            referenceXib(nibName: cellIdentifier)
            if let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionHeaderTableViewCell", for: indexPath) as? QuestionHeaderTableViewCell {
                
                let myString = "Topico nao foi implementado ainda :("
                let myAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
                let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
                
                cell.lblTopic.attributedText = myAttrString
                
                return cell
            } else {
                fatalError("The dequeued cell is not an instance of NoticeTableViewCell.")
            }
        case 1: // Initial text
            let cellIdentifier = "QuestionTextTableViewCell"
            referenceXib(nibName: cellIdentifier)
            if let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTextTableViewCell", for: indexPath) as? QuestionTextTableViewCell {
                
                let myString = (question.initialText ?? "")
                let myAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
                let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
                
                cell.lblText.attributedText = myAttrString
                cell.lblText.textColor = .black
                
                return cell
            } else {
                fatalError("The dequeued cell is not an instance of NoticeTableViewCell.")
            }
        case 2: // Images
            let cellIdentifier = "QuestionImageTableViewCell"
            referenceXib(nibName: cellIdentifier)
            if let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionImageTableViewCell", for: indexPath) as? QuestionImageTableViewCell {
                cell.imgQuestionImage.image = self.question.images?[indexPath.row]
                return cell
            } else {
                fatalError("The dequeued cell is not an instance of NoticeTableViewCell.")
            }
        case 3: // Subtitle
            let cellIdentifier = "QuestionTextTableViewCell"
            referenceXib(nibName: cellIdentifier)
            if let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTextTableViewCell", for: indexPath) as? QuestionTextTableViewCell {
                
                let myString = self.question.subtitle ?? ""
                let myAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)]
                let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
                
                cell.lblText.textAlignment = .center
                cell.lblText.attributedText = myAttrString
                cell.lblText.textColor = .gray
                
                return cell
            } else {
                fatalError("The dequeued cell is not an instance of NoticeTableViewCell.")
            }
        case 4: // Text
            let cellIdentifier = "QuestionTextTableViewCell"
            referenceXib(nibName: cellIdentifier)
            if let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTextTableViewCell", for: indexPath) as? QuestionTextTableViewCell {
                
                let myString = self.question.text
                let myAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
                let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
                
                cell.lblText.attributedText = myAttrString
                cell.lblText.textColor = .black
                
                return cell
            } else {
                fatalError("The dequeued cell is not an instance of NoticeTableViewCell.")
            }
        case 5: // Options
            let cellIdentifier = "QuestionOptionTableViewCell"
            referenceXib(nibName: cellIdentifier)
            if let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionOptionTableViewCell", for: indexPath) as? QuestionOptionTableViewCell {
                let index = String(format: "%c", indexPath.row + 97)
                cell.lblIndex.text = index.uppercased()
                cell.lblAnswer.text = self.question.options[index]
                if (index == self.chosenOption) {
                    cell.CardView.backgroundColor = .gray
                    cell.lblAnswer.textColor = .white
                    cell.lblIndex.textColor = .white
                } else {
                    cell.CardView.backgroundColor = .white
                    cell.lblAnswer.textColor = .black
                    cell.lblIndex.textColor = .black
                }
                return cell
            } else {
                fatalError("The dequeued cell is not an instance of NoticeTableViewCell.")
            }
//        case 6: // Buttons
//            let cellIdentifier = "QuestionButtonsTableViewCell"
//            referenceXib(nibName: cellIdentifier)
//            if let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionButtonsTableViewCell", for: indexPath) as? QuestionButtonsTableViewCell {
//                cell.controller = self.controller
//                return cell
//            } else {
//                fatalError("The dequeued cell is not an instance of NoticeTableViewCell.")
//            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = questionTableView.cellForRow(at: indexPath) as? QuestionOptionTableViewCell {
            let option = String(format: "%c", indexPath.row + 97) // o que raios é essa conversão?
            if option == self.chosenOption {
                self.chosenOption = nil
                self.controller.answerWasUnsubmitted(question: self.question)
                UIView.animate(withDuration: 0.3, animations: {
                    cell.CardView.backgroundColor = .white
                    cell.lblAnswer.textColor = .black
                    cell.lblIndex.textColor = .black
                })
            } else {
                if self.chosenOption != nil {
                    unselectAlreadyChosenDisplay()
                }
                self.chosenOption = option
                self.controller.answerWasSubmitted(question: self.question, answer: option)
                UIView.animate(withDuration: 0.3, animations: {
                    // 0xCBDAF8
                    cell.CardView.backgroundColor = UIColor(red:203/255, green:218/255, blue:248/255, alpha: 1)
                    cell.lblAnswer.textColor = .black
                    cell.lblIndex.textColor = .black
                })
            }
        }
    }
    
    func tableView( _ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = questionTableView.cellForRow(at: indexPath) as? QuestionOptionTableViewCell {
            UIView.animate(withDuration: 0.3, animations: {
                cell.CardView.backgroundColor = .white
                cell.lblAnswer.textColor = .black
                cell.lblIndex.textColor = .black
            })
        }
    }
    
    
    /**
     
     Função auxiliar que deseleciona uma célula caso ela já tenha sido escolhida previamente.
     
     */
    
    private func unselectAlreadyChosenDisplay() {
        for cell in questionTableView.visibleCells {
            if let optionCell = cell as? QuestionOptionTableViewCell {
                if let indexPath = questionTableView.indexPath(for: optionCell) {
                    let option = String(format: "%c", indexPath.row + 97)
                    if option == self.chosenOption {
                        optionCell.CardView.backgroundColor = .white
                        optionCell.lblAnswer.textColor = .black
                        optionCell.lblIndex.textColor = .black
                    }
                }
            }
        }
    }
}
