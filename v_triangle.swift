import Foundation

protocol Triangle {
	var sides: [Int] { get }
	var type: TriangleType { get }
}

enum TriangleType: String {
	case equilateral = "EQUILÁTERO"
	case isosceles = "ISÓSCELES"
	case scalene = "ESCALENO"
}

struct SimpleTriangle: Triangle {
	let sides: [Int]
	
	var isValid: Bool {
		guard sides.count == 3 else { return false }
		let sortedSides = sides.sorted()
		return sortedSides[0] > 0 && sortedSides[0] + sortedSides[1] > sortedSides[2]
	}
	
	var type: TriangleType {
		guard isValid else { return .scalene }
		let uniqueSidesCount = Set(sides).count
		switch uniqueSidesCount {
			case 1: return .equilateral
			case 2: return .isosceles
			default: return .scalene
		}
	}
	
	var resultString: String {
		"""
		======================================================================
		| Los lados ingresados forman un triángulo \(type.rawValue).         |
		======================================================================
		"""
	}
	
	var errorString: String {
		"""
		======================================================================
		| Error. Los lados \(sides) no forman un triángulo.          	     |
		======================================================================
		"""
	}
	
	var result: String {
		isValid ? resultString : errorString
	}
}

func getUserInput() -> [Int] {
	print("""
	==================================================
	|             DETECTOR TIPO DE TRIÁNGULO         |
	==================================================
	| Por favor, ingrese la longitud de los 3 lados  |
	| del triángulo. 								 |
	| Ingrese los valores separados por espacios     |
	| Ej: ('3 4 5') y presione enter.                |
	==================================================
	""")
	if let input = readLine() {
		let sides = input.split(separator: " ").compactMap { Int($0) }
		if sides.count == 3 {
			return sides
		}
	}
	print("Entrada inválida.")
	return getUserInput()
}

func main() {
	let sides = getUserInput()
	let triangle = SimpleTriangle(sides: sides)
	print(triangle.result)
}

main()
