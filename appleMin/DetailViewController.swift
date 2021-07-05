//
//  DetailViewController.swift
//  appleMin
//
//  Created by 김우재 on 2021/05/10.
//

import UIKit
import Charts

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var highPriceLabel: UILabel!
    @IBOutlet weak var lowPriceLabel: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var CoupangButton: UIButton!
    
    // MARK: - Local Variables
    var imageURL: String!
    var itemName: String!
    var itemPrice: UILabel!
    var highPrice: Int!
    var lowPrice: Int!
    var dateArray: [String]!
    var priceArray: [Int]!
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChartView.noDataText = "데이터가 없습니다."
        lineChartView.noDataFont = .systemFont(ofSize: 20)
        lineChartView.noDataTextColor = .lightGray
        setChart(dataPoints: dateArray, values: priceArray)
        
        // Do any additional setup after loading the view.
        self.imageView.image = UIImage(data: try! Data(contentsOf: URL(string: imageURL)!))
        self.navigationItem.title = itemName
        self.currentPriceLabel.text = itemPrice.text
        self.currentPriceLabel.textColor = itemPrice.textColor
        self.highPriceLabel.text = String(highPrice.withCommas())
        self.lowPriceLabel.text = String(lowPrice.withCommas())
        self.CoupangButton.layer.cornerRadius = 5.0
    }
    
    func setChart(dataPoints: [String], values: [Int]) {
        var lineDataArray: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataPoint = ChartDataEntry(x: Double(i), y: Double(values[i]))
            lineDataArray.append(dataPoint)
        }
        let chartDataSet = LineChartDataSet(entries: lineDataArray, label: "가격")
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        chartDataSet.colors = [UIColor.systemPink]
        chartDataSet.setCircleColor(UIColor.systemPink)
        chartDataSet.circleHoleColor = UIColor.systemPink
        chartDataSet.circleRadius = 4.0
        
        lineChartView.xAxis.labelPosition = .bottom
        // X축 레이블 포맷 지정
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dateArray)
        
        
        // X축 레이블 갯수 최대로 설정 (이 코드 안쓸 시 Jan Mar May 이런식으로 띄엄띄엄 조금만 나옴)
        lineChartView.xAxis.setLabelCount(dataPoints.count, force: true)
        
        // 오른쪽 레이블 제거
        lineChartView.rightAxis.enabled = false
        
        // 기본 애니메이션
        lineChartView.animate(xAxisDuration: 0.5, yAxisDuration: 0.5)
        // 옵션 애니메이션
        //barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        
        var average: Double = 0.0
        for i in priceArray {
            average += Double(i)
        }
        average /= Double(priceArray.count)
        
        // 리미트라인
        let ll = ChartLimitLine(limit: average, label: "평균가")
        ll.lineColor = UIColor.systemBlue
        lineChartView.leftAxis.addLimitLine(ll)
        
        lineChartView.data = chartData
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
