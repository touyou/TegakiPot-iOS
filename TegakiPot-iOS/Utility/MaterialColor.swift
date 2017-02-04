import Foundation
import UIKit

/**
  Hex Color Util
 */

extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat

        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)

            if hexColor.characters.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

/**
 Material Colors Enum
 */

enum MaterialColor: String {
    case redLighten5        = "#ffebeeff"
    case redLighten4        = "#ffcdd2ff"
    case redLighten3        = "#ef9a9aff"
    case redLighten2        = "#e57373ff"
    case redLighten1        = "#ef5350ff"
    case red                = "#f44336ff"
    case redDarken1         = "#e53935ff"
    case redDarken2         = "#d32f2fff"
    case redDarken3         = "#c62828ff"
    case redDarken4         = "#b71c1cff"
    case redAccent1         = "#ff8a80ff"
    case redAccent2         = "#ff5252ff"
    case redAccent3         = "#ff1744ff"
    case redAccent4         = "#d50000ff"

    case pinkLighten5       = "#fce4ecff"
    case pinkLighten4       = "#f8bbd0ff"
    case pinkLighten3       = "#f48fb1ff"
    case pinkLighten2       = "#f06292ff"
    case pinkLighten1       = "#ec407aff"
    case pink               = "#e91e63ff"
    case pinkDarken1        = "#d81b60ff"
    case pinkDarken2        = "#c2185bff"
    case pinkDarken3        = "#ad1457ff"
    case pinkDarken4        = "#880e4fff"
    case pinkAccent1        = "#ff80abff"
    case pinkAccent2        = "#ff4081ff"
    case pinkAccent3        = "#f50057ff"
    case pinkAccent4        = "#c51162ff"

    case purpleLighten5     = "#f3e5f5ff"
    case purpleLighten4     = "#e1bee7ff"
    case purpleLighten3     = "#ce93d8ff"
    case purpleLighten2     = "#ba68c8ff"
    case purpleLighten1     = "#ab47bcff"
    case purple             = "#9c27b0ff"
    case purpleDarken1      = "#8e24aaff"
    case purpleDarken2      = "#7b1fa2ff"
    case purpleDarken3      = "#6a1b9aff"
    case purpleDarken4      = "#4a148cff"
    case purpleAccent1      = "#ea80fcff"
    case purpleAccent2      = "#e040fbff"
    case purpleAccent3      = "#d500f9ff"
    case purpleAccent4      = "#aa00ffff"

    case deepPurpleLighten5 = "#ede7f6ff"
    case deepPurpleLighten4 = "#d1c4e9ff"
    case deepPurpleLighten3 = "#b39ddbff"
    case deepPurpleLighten2 = "#9575cdff"
    case deepPurpleLighten1 = "#7e57c2ff"
    case deepPurple         = "#673ab7ff"
    case deepPurpleDarken1  = "#5E35B1ff"
    case deepPurpleDarken2  = "#512da8ff"
    case deepPurpleDarken3  = "#4527a0ff"
    case deepPurpleDarken4  = "#311b92ff"
    case deepPurpleAccent1  = "#b388ffff"
    case deepPurpleAccent2  = "#7c4dffff"
    case deepPurpleAccent3  = "#651fffff"
    case deepPurpleAccent4  = "#6200eaff"

    case indigoLighten5     = "#e8eaf6ff"
    case indigoLighten4     = "#c5cae9ff"
    case indigoLighten3     = "#9fa8daff"
    case indigoLighten2     = "#7986cbff"
    case indigoLighten1     = "#5c6bc0ff"
    case indigo             = "#3f51b5ff"
    case indigoDarken1      = "#3949ABff"
    case indigoDarken2      = "#303f9fff"
    case indigoDarken3      = "#283593ff"
    case indigoDarken4      = "#1a237eff"
    case indigoAccent1      = "#8c9effff"
    case indigoAccent2      = "#536dfeff"
    case indigoAccent3      = "#3d5afeff"
    case indigoAccent4      = "#304ffeff"

    case blueLighten5       = "#e3f2fdff"
    case blueLighten4       = "#bbdefbff"
    case blueLighten3       = "#90caf9ff"
    case blueLighten2       = "#64b5f6ff"
    case blueLighten1       = "#42a5f5ff"
    case blue               = "#2196f3ff"
    case blueDarken1        = "#1E88E5ff"
    case blueDarken2        = "#1976d2ff"
    case blueDarken3        = "#1565c0ff"
    case blueDarken4        = "#0d47a1ff"
    case blueAccent1        = "#82b1ffff"
    case blueAccent2        = "#448affff"
    case blueAccent3        = "#2979ffff"
    case blueAccent4        = "#2962ffff"

    case lightBlueLighten5  = "#e1f5feff"
    case lightBlueLighten4  = "#b3e5fcff"
    case lightBlueLighten3  = "#81d4faff"
    case lightBlueLighten2  = "#4fc3f7ff"
    case lightBlueLighten1  = "#29b6f6ff"
    case lightBlue          = "#03a9f4ff"
    case lightBlueDarken1   = "#039BE5ff"
    case lightBlueDarken2   = "#0288d1ff"
    case lightBlueDarken3   = "#0277bdff"
    case lightBlueDarken4   = "#01579bff"
    case lightBlueAccent1   = "#80d8ffff"
    case lightBlueAccent2   = "#40c4ffff"
    case lightBlueAccent3   = "#00b0ffff"
    case lightBlueAccent4   = "#0091eaff"

    case cyanLighten5       = "#e0f7faff"
    case cyanLighten4       = "#b2ebf2ff"
    case cyanLighten3       = "#80deeaff"
    case cyanLighten2       = "#4dd0e1ff"
    case cyanLighten1       = "#26c6daff"
    case cyan               = "#00bcd4ff"
    case cyanDarken1        = "#00ACC1ff"
    case cyanDarken2        = "#0097a7ff"
    case cyanDarken3        = "#00838fff"
    case cyanDarken4        = "#006064ff"
    case cyanAccent1        = "#84ffffff"
    case cyanAccent2        = "#18ffffff"
    case cyanAccent3        = "#00e5ffff"
    case cyanAccent4        = "#00b8d4ff"

    case tealLighten5       = "#e0f2f1ff"
    case tealLighten4       = "#b2dfdbff"
    case tealLighten3       = "#80cbc4ff"
    case tealLighten2       = "#4db6acff"
    case tealLighten1       = "#26a69aff"
    case teal               = "#009688ff"
    case tealDarken1        = "#00897Bff"
    case tealDarken2        = "#00796bff"
    case tealDarken3        = "#00695cff"
    case tealDarken4        = "#004d40ff"
    case tealAccent1        = "#a7ffebff"
    case tealAccent2        = "#64ffdaff"
    case tealAccent3        = "#1de9b6ff"
    case tealAccent4        = "#00bfa5ff"

    case greenLighten5      = "#e8f5e9ff"
    case greenLighten4      = "#c8e6c9ff"
    case greenLighten3      = "#a5d6a7ff"
    case greenLighten2      = "#81c784ff"
    case greenLighten1      = "#66bb6aff"
    case green              = "#4caf50ff"
    case greenDarken1       = "#43A047ff"
    case greenDarken2       = "#388e3cff"
    case greenDarken3       = "#2e7d32ff"
    case greenDarken4       = "#1b5e20ff"
    case greenAccent1       = "#b9f6caff"
    case greenAccent2       = "#69f0aeff"
    case greenAccent3       = "#00e676ff"
    case greenAccent4       = "#00c853ff"

    case lightGreenLighten5 = "#f1f8e9ff"
    case lightGreenLighten4 = "#dcedc8ff"
    case lightGreenLighten3 = "#c5e1a5ff"
    case lightGreenLighten2 = "#aed581ff"
    case lightGreenLighten1 = "#9ccc65ff"
    case lightGreen         = "#8bc34aff"
    case lightGreenDarken1  = "#7CB342ff"
    case lightGreenDarken2  = "#689f38ff"
    case lightGreenDarken3  = "#558b2fff"
    case lightGreenDarken4  = "#33691eff"
    case lightGreenAccent1  = "#ccff90ff"
    case lightGreenAccent2  = "#b2ff59ff"
    case lightGreenAccent3  = "#76ff03ff"
    case lightGreenAccent4  = "#64dd17ff"

    case limeLighten5       = "#f9fbe7ff"
    case limeLighten4       = "#f0f4c3ff"
    case limeLighten3       = "#e6ee9cff"
    case limeLighten2       = "#dce775ff"
    case limeLighten1       = "#d4e157ff"
    case lime               = "#cddc39ff"
    case limeDarken1        = "#C0CA33ff"
    case limeDarken2        = "#afb42bff"
    case limeDarken3        = "#9e9d24ff"
    case limeDarken4        = "#827717ff"
    case limeAccent1        = "#f4ff81ff"
    case limeAccent2        = "#eeff41ff"
    case limeAccent3        = "#c6ff00ff"
    case limeAccent4        = "#aeea00ff"

    case yellowLighten5     = "#fffde7ff"
    case yellowLighten4     = "#fff9c4ff"
    case yellowLighten3     = "#fff59dff"
    case yellowLighten2     = "#fff176ff"
    case yellowLighten1     = "#ffee58ff"
    case yellow             = "#ffeb3bff"
    case yellowDarken1      = "#FDD835ff"
    case yellowDarken2      = "#fbc02dff"
    case yellowDarken3      = "#f9a825ff"
    case yellowDarken4      = "#f57f17ff"
    case yellowAccent1      = "#ffff8dff"
    case yellowAccent2      = "#ffff00ff"
    case yellowAccent3      = "#ffea00ff"
    case yellowAccent4      = "#ffd600ff"

    case amberLighten5      = "#fff8e1ff"
    case amberLighten4      = "#ffecb3ff"
    case amberLighten3      = "#ffe082ff"
    case amberLighten2      = "#ffd54fff"
    case amberLighten1      = "#ffca28ff"
    case amber              = "#ffc107ff"
    case amberDarken1       = "#FFB300ff"
    case amberDarken2       = "#ffa000ff"
    case amberDarken3       = "#ff8f00ff"
    case amberDarken4       = "#ff6f00ff"
    case amberAccent1       = "#ffe57fff"
    case amberAccent2       = "#ffd740ff"
    case amberAccent3       = "#ffc400ff"
    case amberAccent4       = "#ffab00ff"

    case orangeLighten5     = "#fff3e0ff"
    case orangeLighten4     = "#ffe0b2ff"
    case orangeLighten3     = "#ffcc80ff"
    case orangeLighten2     = "#ffb74dff"
    case orangeLighten1     = "#ffa726ff"
    case orange             = "#ff9800ff"
    case orangeDarken1      = "#FB8C00ff"
    case orangeDarken2      = "#f57c00ff"
    case orangeDarken3      = "#ef6c00ff"
    case orangeDarken4      = "#e65100ff"
    case orangeAccent1      = "#ffd180ff"
    case orangeAccent2      = "#ffab40ff"
    case orangeAccent3      = "#ff9100ff"
    case orangeAccent4      = "#ff6d00ff"

    case deepOrangeLighten5 = "#fbe9e7ff"
    case deepOrangeLighten4 = "#ffccbcff"
    case deepOrangeLighten3 = "#ffab91ff"
    case deepOrangeLighten2 = "#ff8a65ff"
    case deepOrangeLighten1 = "#ff7043ff"
    case deepOrange         = "#ff5722ff"
    case deepOrangeDarken1  = "#F4511Eff"
    case deepOrangeDarken2  = "#e64a19ff"
    case deepOrangeDarken3  = "#d84315ff"
    case deepOrangeDarken4  = "#bf360cff"
    case deepOrangeAccent1  = "#ff9e80ff"
    case deepOrangeAccent2  = "#ff6e40ff"
    case deepOrangeAccent3  = "#ff3d00ff"
    case deepOrangeAccent4  = "#dd2c00ff"

    case brownLighten5      = "#efebe9ff"
    case brownLighten4      = "#d7ccc8ff"
    case brownLighten3      = "#bcaaa4ff"
    case brownLighten2      = "#a1887fff"
    case brownLighten1      = "#8d6e63ff"
    case brown              = "#795548ff"
    case brownDarken1       = "#6D4C41ff"
    case brownDarken2       = "#5d4037ff"
    case brownDarken3       = "#4e342eff"
    case brownDarken4       = "#3e2723ff"

    case grayLighten5       = "#fafafaff"
    case grayLighten4       = "#f5f5f5ff"
    case grayLighten3       = "#eeeeeeff"
    case grayLighten2       = "#e0e0e0ff"
    case grayLighten1       = "#bdbdbdff"
    case gray               = "#9e9e9eff"
    case grayDarken1        = "#757575ff"
    case grayDarken2        = "#616161ff"
    case grayDarken3        = "#424242ff"
    case grayDarken4        = "#212121ff"

    case blueGrayLighten5   = "#eceff1ff"
    case blueGrayLighten4   = "#cfd8dcff"
    case blueGrayLighten3   = "#b0bec5ff"
    case blueGrayLighten2   = "#90a4aeff"
    case blueGrayLighten1   = "#78909cff"
    case blueGray           = "#607d8bff"
    case blueGrayDarken1    = "#546E7Aff"
    case blueGrayDarken2    = "#455a64ff"
    case blueGrayDarken3    = "#37474fff"
    case blueGrayDarken4    = "#263238ff"

    case black              = "#323A45ff"
    case white              = "#ffffffff"

    var color: UIColor? {
        return UIColor(hexString: self.rawValue)
    }
}
