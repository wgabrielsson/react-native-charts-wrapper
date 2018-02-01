
import Foundation
import Charts

open class FormatterWithUnit: NSObject, IValueFormatter, IAxisValueFormatter
{
  private let maxValue: Double?
  private let minValue: Double?
  private let unit: String?
  private let numberFormatter = NumberFormatter()
  
  public init(minValue: Double?, maxValue: Double?, unit: String?) {
    self.minValue = minValue;
    self.maxValue = maxValue;
    self.unit = unit
  }
  
  private func shouldSkip(value: Double) -> Bool {
    if let min = self.minValue {
      if value <= min {
        return true;
      }
    }
    if let max = self.maxValue {
      if value >= max {
        return true
      }
    }
    return false
  }
  
  private func format(value: Double) -> String {
    if shouldSkip(value: value) {
      return ""
    }
    
    let unit = self.unit ?? ""
    let valueString = numberFormatter.string(from: NSNumber(value: value))
    if let valueString = valueString {
      return "\(valueString) \(unit)"
    }
    return ""
  }
  
  open func stringForValue(
    _ value: Double, axis: AxisBase?) -> String
  {
    return format(value: value)
  }
  
  open func stringForValue(
    _ value: Double,
    entry: ChartDataEntry,
    dataSetIndex: Int,
    viewPortHandler: ViewPortHandler?) -> String
  {
    return format(value: value)
  }
}



