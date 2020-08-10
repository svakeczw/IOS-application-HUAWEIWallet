//
//  AnalysisViewController.swift
//  HUAWEI Wallet
//
//  Created by Zhangwei Chen on 27/5/20.
//  Copyright © 2020 hayden. All rights reserved.
//

import UIKit
import Charts
import TinyConstraints

class AnalysisViewController: UIViewController, ChartViewDelegate {
    
    let pieChartView = PieChartView()
    let lineChartView = LineChartView()
    var screenWidth:UInt32 {
        return UInt32(UIScreen.main.bounds.width)
    }
    var screenHeight:UInt32 {
        return UInt32(UIScreen.main.bounds.height)
    }
    
    var yDataIncome = [Double]()//Data for Piechart
    var yDataExpend = [Double]()//Data for Piechart
    var titles = [String]()
    
    //Data for Linechart
    var yDataAIncome = [Double]()//bitcoin
    var yDataAExpend = [Double]()
    var yDataBIncome = [Double]()//ethereum
    var yDataBExpend = [Double]()
    var yDataCIncome = [Double]()//ripple
    var yDataCExpend = [Double]()
    
    
    @IBOutlet weak var switchControl: UISegmentedControl!
    
    
    
    //Switch income or expenditure
    @IBAction func switchAnalysis(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            switchControl.selectedSegmentTintColor = UIColor.init(displayP3Red: 0.4157, green: 0.498, blue: 0.5686, alpha: 1)
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            switchControl.setTitleTextAttributes(titleTextAttributes, for: .selected)
            incomeAnalysisPie()
            drawPieChartViewIncome()
            drawLineChartViewIncome()
            
            
        } else if sender.selectedSegmentIndex == 1 {
            switchControl.selectedSegmentTintColor = UIColor.init(displayP3Red: 0.1569, green: 0.4667, blue: 0.4588, alpha: 1)
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            switchControl.setTitleTextAttributes(titleTextAttributes, for: .selected)
            expendAnalysisPie()
            drawPieChartViewExpend()
            drawLineChartViewExpend()
        }
        
    }
    
    //Draw income pie chart
    func drawPieChartViewIncome() {
        let titles = ["Bitcoin","Ethereum","Ripple"]
        var yVals = [PieChartDataEntry]()
        for i in 0...titles.count - 1 {
            let entry = PieChartDataEntry.init(value: Double(yDataIncome[i]), label: titles[i])
            yVals.append(entry)
            }
        
        let dataSet = PieChartDataSet.init(entries: yVals, label:"")
        dataSet.colors = [UIColor.red,UIColor.yellow,UIColor.blue,UIColor.orange,UIColor.green]
        dataSet.colors = [UIColor(red: 0, green: 0.3922, blue: 0, alpha: 1),UIColor(red: 0.8039, green: 0, blue: 0, alpha: 1), UIColor(red: 1, green: 0.7255, blue: 0.0588, alpha: 1) ]
        dataSet.xValuePosition = .insideSlice
        dataSet.yValuePosition = .outsideSlice
        dataSet.sliceSpace = 1
        dataSet.selectionShift = 6.66
            
       
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.4
        dataSet.valueLinePart2Length = 0.4
        dataSet.valueLineWidth = 1
        dataSet.valueLineColor = UIColor.white
            
        let data = PieChartData.init(dataSets: [dataSet])
        pieChartView.usePercentValuesEnabled = true
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = "%"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueFont(UIFont.boldSystemFont(ofSize: 20.0))
        data.setValueTextColor(UIColor.white)
        pieChartView.data = data
            }
    
    
    //Income analysis pie chart data
    func incomeAnalysisPie() {
        
        pieChartView.frame = CGRect(x: Int(screenWidth/2)-200, y: 100, width: 400, height: 350)
        self.view.addSubview(pieChartView)
        pieChartView.backgroundColor =  UIColor.init(displayP3Red: 0.4157, green: 0.498, blue: 0.5686, alpha: 1)
        pieChartView.setExtraOffsets(left: 30, top: -20, right: 30, bottom: 30)
        pieChartView.chartDescription?.text = "Proportion of income summary"
        pieChartView.chartDescription?.font = UIFont.boldSystemFont(ofSize: 10)
        pieChartView.chartDescription?.textColor = UIColor.white
        pieChartView.chartDescription?.position = CGPoint(x: Int(screenWidth/2)+100, y: 320)
               
        
        pieChartView.dragDecelerationEnabled = true
        pieChartView.drawEntryLabelsEnabled = true
        pieChartView.entryLabelFont = UIFont.systemFont(ofSize: 15)
        pieChartView.entryLabelColor = UIColor.white
        pieChartView.drawSlicesUnderHoleEnabled = true
        pieChartView.drawHoleEnabled = true
        pieChartView.holeRadiusPercent = 0.382
        pieChartView.holeColor = UIColor.white
        pieChartView.transparentCircleRadiusPercent = 0.5
        pieChartView.drawCenterTextEnabled = true
        pieChartView.centerText = "Income"
       
        pieChartView.legend.maxSizePercent = 1
        pieChartView.legend.form = .circle
        pieChartView.legend.formSize = 8
        pieChartView.legend.formToTextSpace = 4
        pieChartView.legend.font = UIFont.systemFont(ofSize: 10)
    
        pieChartView.legend.textColor = UIColor.white
        pieChartView.legend.horizontalAlignment = .center
        pieChartView.legend.verticalAlignment = .top
        self.pieChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInBack)
        self.drawPieChartViewIncome()
    }
    
    
    //Draw expenditure pie chart
    func drawPieChartViewExpend() {
        
        let titles = ["Bitcoin","Ethereum","Ripple"]
        var yVals = [PieChartDataEntry]()
        for i in 0...titles.count - 1 {
            let entry = PieChartDataEntry.init(value: Double(yDataExpend[i]), label: titles[i])
            yVals.append(entry)
            }
            
        let dataSet = PieChartDataSet.init(entries: yVals, label:"")
        dataSet.colors = [UIColor.red,UIColor.yellow,UIColor.blue,UIColor.orange,UIColor.green]
        dataSet.colors = [UIColor(red: 0, green: 0.3922, blue: 0, alpha: 1),UIColor(red: 0.8039, green: 0, blue: 0, alpha: 1), UIColor(red: 1, green: 0.7255, blue: 0.0588, alpha: 1) ]
        
        dataSet.xValuePosition = .insideSlice
        dataSet.yValuePosition = .outsideSlice
        dataSet.sliceSpace = 1
        dataSet.selectionShift = 6.66
                
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.4
        dataSet.valueLinePart2Length = 0.4
        dataSet.valueLineWidth = 1
        dataSet.valueLineColor = UIColor.white
                
        let data = PieChartData.init(dataSets: [dataSet])
        pieChartView.usePercentValuesEnabled = true
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = "%"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueFont(UIFont.boldSystemFont(ofSize: 20.0))
        data.setValueTextColor(UIColor.white)
        pieChartView.data = data
            }
        
    
    //Expenditure pie chart data
    func expendAnalysisPie() {
        pieChartView.frame = CGRect(x: Int(screenWidth/2)-200, y: 100, width: 400, height: 350)
        self.view.addSubview(pieChartView)
        pieChartView.backgroundColor =  UIColor.init(displayP3Red: 0.1569, green: 0.4667, blue: 0.4588, alpha: 1)
        pieChartView.setExtraOffsets(left: 30, top: -20, right: 30, bottom: 30)
        pieChartView.chartDescription?.text = "Proportion of expenditure summary"
        pieChartView.chartDescription?.font = UIFont.systemFont(ofSize: 10)
        pieChartView.chartDescription?.textColor = UIColor.white
        pieChartView.chartDescription?.position = CGPoint(x: Int(screenWidth/2)+100, y: 320)
                   
        pieChartView.dragDecelerationEnabled = true
        pieChartView.drawEntryLabelsEnabled = true
        pieChartView.entryLabelFont = UIFont.boldSystemFont(ofSize: 15)
        pieChartView.entryLabelColor = UIColor.white
        pieChartView.drawSlicesUnderHoleEnabled = true
        pieChartView.drawHoleEnabled = true
        pieChartView.holeRadiusPercent = 0.382
        pieChartView.holeColor = UIColor.white
        pieChartView.transparentCircleRadiusPercent = 0.5
        pieChartView.drawCenterTextEnabled = true
        pieChartView.centerText = "Expenditure"
        
        pieChartView.legend.maxSizePercent = 1
        pieChartView.legend.form = .circle
        pieChartView.legend.formSize = 8
        pieChartView.legend.formToTextSpace = 4
        pieChartView.legend.font = UIFont.systemFont(ofSize: 10)
        
        pieChartView.legend.textColor = UIColor.white
        pieChartView.legend.horizontalAlignment = .center
        pieChartView.legend.verticalAlignment = .top
        self.pieChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInBack)
        self.drawPieChartViewExpend()
    }
        
    
    //Draw income line chart
    func drawLineChartViewIncome() {

        lineChartView.frame = CGRect(x: Int(screenWidth/2)-200, y: 450, width: 400, height: 350)
        self.view.addSubview(lineChartView)
        lineChartView.delegate = self
        lineChartView.backgroundColor = UIColor.init(displayP3Red: 0.4157, green: 0.498, blue: 0.5686, alpha: 1)
        lineChartView.noDataText = "No Data"
            
        lineChartView.scaleYEnabled = false
        lineChartView.doubleTapToZoomEnabled = true
        lineChartView.dragEnabled = true
        lineChartView.dragDecelerationEnabled = true
        lineChartView.dragDecelerationFrictionCoef = 0.9
        
       
        let xAxis = lineChartView.xAxis
        xAxis.axisLineWidth = 1.0
        xAxis.axisLineColor = UIColor.white
        xAxis.forceLabelsEnabled = true
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = true
        xAxis.drawLabelsEnabled = false
            
       
        lineChartView.rightAxis.enabled = false
        let leftAxis = lineChartView.leftAxis
        leftAxis.labelCount = 16
        leftAxis.forceLabelsEnabled = false
        leftAxis.axisMinimum = 0
        leftAxis.drawZeroLineEnabled = true
        leftAxis.inverted = false
        leftAxis.axisLineWidth = 1.0/UIScreen.main.scale
        leftAxis.axisLineColor = UIColor.white
        leftAxis.labelPosition = .outsideChart
        leftAxis.labelTextColor = UIColor.white
        leftAxis.labelFont = UIFont.systemFont(ofSize: 10)
            
            
        
        leftAxis.gridLineDashLengths = [3.0,3.0]
        leftAxis.gridColor = UIColor.init(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1)
        
        leftAxis.gridAntialiasEnabled = true
        
        lineChartView.chartDescription?.text = "Last five income record"
        lineChartView.chartDescription?.textColor = UIColor.white
        lineChartView.chartDescription?.font = UIFont.boldSystemFont(ofSize: 10)
        lineChartView.legend.form = .line
        lineChartView.legend.formSize = 20
        lineChartView.legend.textColor = UIColor.white
        lineChartView.legend.font = UIFont.systemFont(ofSize: 10)
        lineChartView.legend.verticalAlignment = .top
        lineChartView.legend.horizontalAlignment = .center
        
        let xValues = ["1","2","3","4","5"]

        lineChartView.xAxis.labelCount = 5
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
        let leftValueFormatter = NumberFormatter()
        
        lineChartView.leftAxis.valueFormatter = DefaultAxisValueFormatter.init(formatter: leftValueFormatter)
            
        var yDataArray1 = [ChartDataEntry]()
        for i in 0...(yDataAIncome.count-1) {
            let y = yDataAIncome[i]
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            
            yDataArray1.append(entry)
        }
            
            
        let set1 = LineChartDataSet.init(entries: yDataArray1, label: "Bitcoin")
        set1.colors = [UIColor(red: 0, green: 0.3922, blue: 0, alpha: 1)]
        set1.drawCirclesEnabled = false
        set1.lineWidth = 1.0
        set1.circleColors = [UIColor.white]
        set1.circleRadius = 1.0
        set1.drawCirclesEnabled = true
        set1.valueColors = [UIColor.white]
        set1.valueFont = UIFont.systemFont(ofSize:10)
            
        var yDataArray2 = [ChartDataEntry]()
        for i in 0...(yDataBIncome.count-1) {
            let y = yDataBIncome[i]
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            yDataArray2.append(entry)
        }
        let set2 = LineChartDataSet.init(entries: yDataArray2, label: "Ethereum")
        set2.colors = [UIColor(red: 0.8039, green: 0, blue: 0, alpha: 1)]
        set2.drawCirclesEnabled = false
        set2.lineWidth = 1.0
        set2.circleColors = [UIColor.white]
        set2.circleRadius = 1.0
        set2.drawCirclesEnabled = true
        set2.valueColors = [UIColor.white]
        set2.valueFont = UIFont.systemFont(ofSize:10)
        
        var yDataArray3 = [ChartDataEntry]()
        for i in 0...(yDataCIncome.count-1) {
            let y = yDataCIncome[i]
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            yDataArray3.append(entry);
        }
        
        
        let set3 = LineChartDataSet.init(entries: yDataArray3, label: "Ripple")
        set3.colors = [UIColor(red: 1, green: 0.7255, blue: 0.0588, alpha: 1)]
        set3.drawCirclesEnabled = false
        set3.lineWidth = 1.0
        set3.circleColors = [UIColor.white]
        set3.circleRadius = 1.0
        set3.drawCirclesEnabled = true
        set3.valueColors = [UIColor.white]
        set3.valueFont = UIFont.systemFont(ofSize:10)
        
        
        let data = LineChartData.init(dataSets: [set1,set2,set3])
        lineChartView.data = data
        lineChartView.animate(xAxisDuration: 1)
            
        }


    //Line chart build-in function 1
    func showMarkerView(value:String) {
        
        let marker = MarkerView.init(frame: CGRect(x: 20, y: 20, width: 60, height: 20))
        marker.chartView = self.lineChartView
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        label.text = value
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = UIColor.gray
        label.textAlignment = .center
        marker.addSubview(label)
        self.lineChartView.marker = marker
    }

    
    //Line chart build-in function 2
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight)
    {
        self.showMarkerView(value: "\(entry.y)")
    }
       
      
    //Draw expenditure line chart
    func drawLineChartViewExpend() {
        
        lineChartView.frame = CGRect(x: Int(screenWidth/2)-200, y: 450, width: 400, height: 350)
              
        self.view.addSubview(lineChartView)
        lineChartView.delegate = self
            
        lineChartView.backgroundColor = UIColor.init(displayP3Red: 0.1569, green: 0.4667, blue: 0.4588, alpha: 1)
        lineChartView.noDataText = "No Data"

        lineChartView.scaleYEnabled = false
        lineChartView.doubleTapToZoomEnabled = true
        lineChartView.dragEnabled = true
        lineChartView.dragDecelerationEnabled = true
        lineChartView.dragDecelerationFrictionCoef = 0.9
              
        let xAxis = lineChartView.xAxis
        xAxis.axisLineWidth = 1.0
        xAxis.axisLineColor = UIColor.white
        xAxis.forceLabelsEnabled = true
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = true
        xAxis.drawLabelsEnabled = false
                  
        lineChartView.rightAxis.enabled = false
        let leftAxis = lineChartView.leftAxis
        leftAxis.labelCount = 16
        leftAxis.forceLabelsEnabled = false
        leftAxis.axisMinimum = 0
        leftAxis.drawZeroLineEnabled = true
            
        leftAxis.inverted = false
        leftAxis.axisLineWidth = 1.0/UIScreen.main.scale
        leftAxis.axisLineColor = UIColor.white
                
        leftAxis.labelPosition = .outsideChart
        leftAxis.labelTextColor = UIColor.white
        leftAxis.labelFont = UIFont.systemFont(ofSize: 10)
                      
                      
                  
        leftAxis.gridLineDashLengths = [3.0,3.0]
        leftAxis.gridColor = UIColor.init(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1)
        leftAxis.gridAntialiasEnabled = true
        
        lineChartView.chartDescription?.text = "Last five expenditure record"
        lineChartView.chartDescription?.textColor = UIColor.white
        lineChartView.chartDescription?.font = UIFont.boldSystemFont(ofSize: 10)
        lineChartView.legend.form = .line
        lineChartView.legend.formSize = 20
        lineChartView.legend.textColor = UIColor.white
        lineChartView.legend.font = UIFont.systemFont(ofSize: 10)
        lineChartView.legend.verticalAlignment = .top
        lineChartView.legend.horizontalAlignment = .center
        
        let xValues = ["1","2","3","4","5"]
        lineChartView.xAxis.labelCount = 5
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
        let leftValueFormatter = NumberFormatter()

                  
        lineChartView.leftAxis.valueFormatter = DefaultAxisValueFormatter.init(formatter: leftValueFormatter)
                  
        var yDataArray1 = [ChartDataEntry]()
        for i in 0...(yDataAExpend.count-1) {
            let y = yDataAExpend[i]
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
                  
            yDataArray1.append(entry)
        }
                  
        let set1 = LineChartDataSet.init(entries: yDataArray1, label: "Bitcoin")
        set1.colors = [UIColor(red: 0, green: 0.3922, blue: 0, alpha: 1)]
        set1.drawCirclesEnabled = false //是否绘制转折点
        set1.lineWidth = 1.0
        set1.circleColors = [UIColor.white]
        set1.circleRadius = 1.0
        set1.drawCirclesEnabled = true
        set1.valueColors = [UIColor.white]
        set1.valueFont = UIFont.systemFont(ofSize:10)
                  
        var yDataArray2 = [ChartDataEntry]()
        for i in 0...(yDataBExpend.count-1) {
            let y = yDataBExpend[i]
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            yDataArray2.append(entry)
        }
        
        let set2 = LineChartDataSet.init(entries: yDataArray2, label: "Ethereum")
        set2.colors = [UIColor(red: 0.8039, green: 0, blue: 0, alpha: 1)]
        set2.drawCirclesEnabled = false
        set2.lineWidth = 1.0
        set2.circleColors = [UIColor.white]
        set2.circleRadius = 1.0
        set2.drawCirclesEnabled = true
        set2.valueColors = [UIColor.white]
        set2.valueFont = UIFont.systemFont(ofSize:10)
        
        var yDataArray3 = [ChartDataEntry]()
        for i in 0...(yDataCExpend.count-1) {
            let y = yDataCExpend[i]
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            yDataArray3.append(entry);
        }
        
        let set3 = LineChartDataSet.init(entries: yDataArray3, label: "Ripple")
        set3.colors = [UIColor(red: 1, green: 0.7255, blue: 0.0588, alpha: 1)]
        set3.drawCirclesEnabled = false
        set3.lineWidth = 1.0
        set3.circleColors = [UIColor.white]
        set3.circleRadius = 1.0
        set3.drawCirclesEnabled = true
        set3.valueColors = [UIColor.white]
        set3.valueFont = UIFont.systemFont(ofSize:10)
        
        let data = LineChartData.init(dataSets: [set1,set2,set3])
        lineChartView.data = data
        lineChartView.animate(xAxisDuration: 1)
        
        }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        incomeAnalysisPie()
        drawPieChartViewIncome()
        drawLineChartViewIncome()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        switchControl.setTitleTextAttributes(titleTextAttributes, for: .selected)
        switchControl.selectedSegmentTintColor = UIColor.init(displayP3Red: 0.4157, green: 0.498, blue: 0.5686, alpha: 1)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
