
import Foundation
import Charts

open class HourFormatter: NSObject, IValueFormatter, IAxisValueFormatter
{
  private let maxValue: Double?
  private let minValue: Double?
  
  public override init()
  {
    self.minValue = nil;
    self.maxValue = nil;
  }
  
  public init(minValue: Double?, maxValue: Double?) {
    self.minValue = minValue;
    self.maxValue = maxValue;
  }
  
  fileprivate func format(_ value: Double) -> String
  {
    if let min = self.minValue {
      if value <= min {
        return "";
      }
    }
    if let max = self.maxValue {
      if value >= max {
        return ""
      }
    }
    let seconds = value.truncatingRemainder(dividingBy: 1) * 10 * 60;
    let hour = Int(floor(value));
    let hourString = String(format: "%02d", hour)
    let secondsString = String(format: "%02d", seconds);
    return "\(hourString):\(secondsString)";
  }
  
  open func stringForValue(
    _ value: Double, axis: AxisBase?) -> String
  {
    return format(value)
  }
  
  open func stringForValue(
    _ value: Double,
    entry: ChartDataEntry,
    dataSetIndex: Int,
    viewPortHandler: ViewPortHandler?) -> String
  {
    return format(value)
  }
}

