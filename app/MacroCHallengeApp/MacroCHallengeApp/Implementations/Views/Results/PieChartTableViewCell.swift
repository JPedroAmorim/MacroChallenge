//
//  PieChartTableViewCell.swift
//  MacroCHallengeApp
//
//  Created by Felipe Semissatto on 13/10/20.
//

import UIKit
import Charts
import TinyConstraints

class PieChartTableViewCell: UITableViewCell {
    // MARK: -IBOutlets
    @IBOutlet weak var view: UIView!
    
    // MARK: - Private attributes
    lazy var pieChartView: PieChartView = {
        let pieChartView = PieChartView()
        pieChartView.backgroundColor = UIColor.init(red: 242/255,
                                                    green: 242/255,
                                                    blue: 247/255,
                                                    alpha: 1.0)
        return pieChartView
    }()
    
    private var numberOfRightAnswers: Int = 0
    private var numberOfWrongAnswers: Int = 0
    
    // MARK: -Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addingPieChartToView(pieChart: pieChartView)
        setupPieChart(pieChart: pieChartView,
                      numberOfRightAnswers: self.numberOfRightAnswers,
                      numberOfWrongAnswers: self.numberOfWrongAnswers)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    init(numberOfRightAnswers: Int, numberOfWrongAnswers: Int) {
        super.init(style: .default, reuseIdentifier: "PieChartTableViewCell")
        self.numberOfRightAnswers = numberOfRightAnswers
        self.numberOfWrongAnswers = numberOfWrongAnswers
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private Methods
    
    /**
     
     Método responsável por adicionar o gráfico em uma view.
     
     - parameter pieChart: PieChartView que será adicionado a view.
     */
    
    private func addingPieChartToView(pieChart: PieChartView) {
        self.view.addSubview(pieChart)
        pieChart.centerInSuperview()
        pieChart.width(to: self.view)
        pieChart.height(to: self.view)
    }
    
    /**
     
     Método responsável por popular o gráfico de pizza de acertos e erros.
     
     - parameter pieChart: PieChartView no qual será customizado e populado.
     - parameter numberOfRightAnswers: número de acertos de questões para o cálculo do gráfico de pizza.
     - parameter numberOfWrongAnswers: número de erros de questões para o cálculo do gráfico de pizza.
     */
    
    func setupPieChart(pieChart: PieChartView, numberOfRightAnswers: Int, numberOfWrongAnswers: Int) {

        let entry1 = PieChartDataEntry(value: Double(numberOfRightAnswers), label: "Acertos")
        let entry2 = PieChartDataEntry(value: Double(numberOfWrongAnswers), label: "Erros")

        let dataSet = PieChartDataSet(entries: [entry1, entry2 ] , label: "" )
        let data = PieChartData(dataSet: dataSet)
        pieChart.data = data

        let colors = [ UIColor.init(red: 0/255,
                                    green: 122/255,
                                    blue: 255/255,
                                    alpha: 1.0),
                       UIColor.init(red: 158/255,
                                    green: 185/255,
                                    blue: 255/255,
                                    alpha: 1.0)]
        
        dataSet.colors =  colors
        dataSet.sliceSpace = 0

        pieChart.drawHoleEnabled = true
        pieChart.transparentCircleColor = .white
        pieChart.holeRadiusPercent = 0.70
        pieChart.rotationEnabled = false

        let myString = "\(numberOfRightAnswers)/\(numberOfRightAnswers + numberOfWrongAnswers)"
        let myAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        pieChart.centerAttributedText = myAttrString
        
        let l = pieChart.legend
        l.enabled = true
        l.orientation = .vertical
        l.form = .circle

        pieChart.notifyDataSetChanged()
    }
}
