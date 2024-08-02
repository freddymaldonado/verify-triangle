import Foundation

protocol Triangle {
	var sides: [Int] { get }
	var type: TriangleType { get }
	var result: String { get }
	var errorString: String { get }
	var resultString: String { get }
}

enum TriangleType: String {
	case equilateral = "EQUILÁTERO"
	case isosceles = "ISÓSCELES"
	case scalene = "ESCALENO"
	case invalid = "INVÁLIDO"
}

struct SimpleTriangle: Triangle {
	let sides: [Int]
	
	var isValid: Bool {
		guard sides.count == 3 else { return false }
		let sortedSides = sides.sorted()
		return sortedSides[0] > 0 && sortedSides[0] + sortedSides[1] > sortedSides[2]
	}
	
	var type: TriangleType {
		guard isValid else { return .invalid }
		let uniqueSidesCount = Set(sides).count
		switch uniqueSidesCount {
			case 1: return .equilateral
			case 2: return .isosceles
			case 3: return .scalene
			default: return .invalid
		}
	}
	
	var resultString: String {
		"""
		>>> Resultado: Los lados ingresados forman un triángulo \(type.rawValue).
		"""
	}
	
	var errorString: String {
		"""
		>>> Resultado: Error: Los lados \(sides) no forman un triángulo.
		"""
	}
	
	var result: String {
		isValid ? "\n" + resultString : "\n" + errorString
	}
}

func getUserInput() -> [Int] {
	let red = "\u{001B}[0;31m"
	let yellow = "\u{001B}[0;33m"
	let green = "\u{001B}[0;32m"
	let reset = "\u{001B}[0m"
	
	print("\n")
	print("""
	==================================================
	|             DETECTOR TIPO DE TRIÁNGULO         |
	==================================================
	| Por favor, ingrese la longitud de los 3 lados  |
	| del triángulo.                                 |
	| Ingrese los valores separados por espacios     |
	| Ej: ('3 4 5') y presione enter.                |
	==================================================
	""")
	
	var sides: [Int] = []
	while sides.count < 3 {
		if let input = readLine(), !input.isEmpty {
			let newSides = input.split(separator: " ").compactMap { Int($0) }
			if newSides.count + sides.count > 3 {
				print("\(red)Entrada inválida: Un triángulo debe tener exactamente 3 lados.\(reset)")
				sides = []
			} else {
				sides.append(contentsOf: newSides)
				let coloredSides = sides.map { "\(yellow)\($0)\(reset)" }.joined(separator: " ")
				let remaining = 3 - sides.count
				if remaining > 0 {
					print("\(yellow)Faltan \(remaining) \(remaining == 1 ? "lado" : "lados") más.\(reset) Lados ingresados: \(coloredSides)")
				} else {
					print("\(green)Todos los lados ingresados: \(coloredSides)\(reset)")
				}
			}
		} else {
			print("\(red)Entrada inválida: No se ingresó ningún valor.\(reset)")
		}
	}
	
	return sides
}

func main() {
	let sides = getUserInput()
	let triangle = SimpleTriangle(sides: sides)
	print(triangle.result)
}

main()
